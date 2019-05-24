# frozen_string_literal:true

require 'iiif_manifest'

module OregonDigital
  # IIIFManifestControllerBehavior mixes in logic to generate a IIIF manifest
  # without the incorrect assumptions the Hyrax defaults make
  module IIIFManifestControllerBehavior
    def manifest
      headers['Access-Control-Allow-Origin'] = '*'

      json = sanitize_manifest(JSON.parse(manifest_builder.to_h.to_json))

      respond_to do |wants|
        wants.json { render json: json }
        wants.html { render json: json }
      end
    end

    def manifest_builder
      ::IIIFManifest::ManifestFactory.new(jp2_work_presenter)
    end

    def jp2_work_presenter
      return @jp2_work_presenter if @jp2_work_presenter

      solrdoc = curation_concern_from_search_results
      @jp2_work_presenter = OregonDigital::IIIFPresenter.new(solrdoc, current_ability, request)
      work = solrdoc.hydra_model.find(solrdoc.id)
      @jp2_work_presenter.file_sets = work.file_sets
      @jp2_work_presenter
    end

    def sanitize_manifest(hash)
      hash['label'] = sanitize_value(hash['label']) if hash.key?('label')
      hash['description'] = hash['description']&.collect { |elem| sanitize_value(elem) } if hash.key?('description')

      hash['sequences']&.each do |sequence|
        sequence['canvases']&.each do |canvas|
          canvas['label'] = sanitize_value(canvas['label'])
        end
      end
      hash
    end

    def sanitize_value(text)
      Loofah.fragment(text.to_s).scrub!(:prune).to_s
    end
  end
end
