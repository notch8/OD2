# frozen_string_literal: true

# Sidekiq Worker for fetching linked data labels
class FetchGraphWorker
  include Sidekiq::Worker
  sidekiq_options retry: 11 # Around 2.5 days of retries

  # JOBS TEND TOWARD BEING LARGE. DISABLED BECAUSE FETCHING IS HEAVY HANDED.
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  def perform(pid, _user_key)
    # Fetch Work and SolrDoc
    work = ActiveFedora::Base.find(pid)
    solr_doc = SolrDocument.find(pid)
    # TODO: ADD BACK IN WHEN SETTING UP EMAIL
    # user = User.where(email: user_key).first

    # Use 0 for version to tell Solr that the document just needs to exist to be updated
    # Versions dont need to match
    solr_doc.response['response']['docs'].first['_version_'] = 0
    solr_doc['_version_'] = 0

    # Iterate over Controller Props values
    # rubocop:disable Metrics/BlockLength
    work.controlled_properties.each do |controlled_prop|
      work.attributes[controlled_prop.to_s].each do |val|
        val = Hyrax::ControlledVocabularies::Location.new(val) if val.include? 'sws.geonames.org'
        # Fetch labels
        if val.respond_to?(:fetch)
          begin
            val.fetch(headers: { 'Accept' => default_accept_header })
          rescue TriplestoreAdapter::TriplestoreException
            fetch_failed_graph(pid, val, controlled_prop)
            next
          end
          val.persist!
        end

        # For each behavior
        work.class.index_config[controlled_prop].behaviors.each do |behavior|
          # Insert into SolrDocument
          if val.is_a?(String)
            Solrizer.insert_field(solr_doc, "#{controlled_prop}_label", val, behavior)
            Solrizer.insert_field(solr_doc, 'creator_combined_label', val, behavior) if creator_combined_facet?(controlled_prop)
            Solrizer.insert_field(solr_doc, 'location_combined_label', val, behavior) if location_combined_facet?(controlled_prop)
            Solrizer.insert_field(solr_doc, 'topic_combined_label', val, behavior) if topic_combined_facet?(controlled_prop)
            Solrizer.insert_field(solr_doc, 'scientific_combined_label', val, behavior) if scientific_combined_facet?(controlled_prop)
          else
            extracted_val = val.solrize.last.is_a?(String) ? val.solrize.last : val.solrize.last[:label].split('$').first
            Solrizer.insert_field(solr_doc, "#{controlled_prop}_label", [extracted_val], behavior)
            Solrizer.insert_field(solr_doc, 'location_combined_label', [extracted_val], behavior) if location_combined_facet?(controlled_prop)
            Solrizer.insert_field(solr_doc, 'creator_combined_label', [extracted_val], behavior) if creator_combined_facet?(controlled_prop)
            Solrizer.insert_field(solr_doc, 'topic_combined_label', [extracted_val], behavior) if topic_combined_facet?(controlled_prop)
            Solrizer.insert_field(solr_doc, 'scientific_combined_label', [extracted_val], behavior) if scientific_combined_facet?(controlled_prop)
          end
        end
      end
    end
    # rubocop:enable Metrics/BlockLength

    # Commit Changes
    ActiveFedora::SolrService.add(solr_doc)
    ActiveFedora::SolrService.commit
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity

  # TODO: WILL INTEGRATE THIS WHEN REDOING EMAILING FOR THESE JOBS
  # def fetch_failed_callback(user, val)
  #   Hyrax.config.callback.run(:ld_fetch_failure, user, val.rdf_subject.value)
  # end

  def fetch_failed_graph(pid, val, controlled_prop)
    FetchFailedGraphWorker.perform_async(pid, val, controlled_prop)
  end

  def default_accept_header
    RDF::Util::File::HttpAdapter.default_accept_header.sub(%r{, \*\/\*;q=0\.1\Z}, '')
  end

  def location_combined_facet?(controlled_prop)
    %i[ranger_district water_basin location].include? controlled_prop
  end

  def creator_combined_facet?(controlled_prop)
    %i[arranger artist author cartographer collector composer creator contributor dedicatee donor designer editor illustrator interviewee interviewer lyricist owner patron photographer print_maker recipient transcriber translator].include? controlled_prop
  end

  def topic_combined_facet?(controlled_prop)
    %i[keyword subject].include? controlled_prop
  end

  def scientific_combined_facet?(controlled_prop)
    %i[taxon_class family genus order species phylum_or_division].include? controlled_prop
  end
end
