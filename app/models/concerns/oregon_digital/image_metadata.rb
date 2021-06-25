# frozen_string_literal:true

module OregonDigital
  # Sets metadata for image work
  module ImageMetadata
    extend ActiveSupport::Concern
    # Usage notes and expectations can be found in the Metadata Application Profile:
    # https://docs.google.com/spreadsheets/d/1ien3djlZxcctuAE99XweyuNdMiN5YsrKoYBJcK3DjLQ/edit?usp=sharing

    included do
      initial_properties = properties.keys
      property :photograph_orientation, predicate: RDF::URI.new('http://opaquenamespace.org/ns/photographOrientation'), multiple: false, basic_searchable: false do |index|
        index.as :stored_searchable
      end

      property :view, predicate: RDF::URI.new('http://opaquenamespace.org/ns/cco_viewDescription'), multiple: true, basic_searchable: false do |index|
        index.as :stored_searchable
      end

      property :color_content, predicate: RDF::URI.new('http://rdaregistry.info/Elements/e/P20224'), multiple: true, basic_searchable: false do |index|
        index.as :stored_searchable
      end

      property :resolution, predicate: RDF::Vocab::EXIF.resolution, multiple: false, basic_searchable: false do |index|
        index.as :stored_searchable
      end

      define_singleton_method :image_properties do
        (properties.reject { |_k, v| v.class_name.nil? ? false : v.class_name.to_s.include?('ControlledVocabularies') }.keys - (Generic.generic_properties + initial_properties))
      end

      ORDERED_TERMS = [
        { name: :alternative, section_name: 'Titles' },
        { name: :tribal_title, section_name: '' },
        { name: :title, section_name: '' },
        { name: :creator, section_name: 'Creators' },
        { name: :photographer, section_name: '' },
        { name: :arranger, section_name: '' },
        { name: :artist, section_name: '' },
        { name: :author, section_name: '' },
        { name: :cartographer, section_name: '' },
        { name: :collector, section_name: '' },
        { name: :composer, section_name: '' },
        { name: :creator_display, section_name: '' },
        { name: :contributor, section_name: '' },
        { name: :dedicatee, section_name: '' },
        { name: :designer, section_name: '' },
        { name: :donor, section_name: '' },
        { name: :editor, section_name: '' },
        { name: :illustrator, section_name: '' },
        { name: :interviewee, section_name: '' },
        { name: :interviewer, section_name: '' },
        { name: :lyricist, section_name: '' },
        { name: :owner, section_name: '' },
        { name: :patron, section_name: '' },
        { name: :print_maker, section_name: '' },
        { name: :recipient, section_name: '' },
        { name: :transcriber, section_name: '' },
        { name: :translator, section_name: '' },
        { name: :description, section_name: 'Descriptions' },
        { name: :abstract, section_name: '' },
        { name: :biographical_information, section_name: '' },
        { name: :compass_direction, section_name: '' },
        { name: :cover_description, section_name: '' },
        { name: :coverage, section_name: '' },
        { name: :description_of_manifestation, section_name: '' },
        { name: :designer_inscription, section_name: '' },
        { name: :form_of_work, section_name: '' },
        { name: :former_owner, section_name: '' },
        { name: :inscription, section_name: '' },
        { name: :layout, section_name: '' },
        { name: :military_highest_rank, section_name: '' },
        { name: :military_occupation, section_name: '' },
        { name: :military_service_location, section_name: '' },
        { name: :mode_of_issuance, section_name: '' },
        { name: :mods_note, section_name: '' },
        { name: :motif, section_name: '' },
        { name: :object_orientation, section_name: '' },
        { name: :photograph_orientation, section_name: '' },
        { name: :tribal_notes, section_name: '' },
        { name: :source_condition, section_name: '' },
        { name: :temporal, section_name: '' },
        { name: :view, section_name: '' },
        { name: :subject, section_name: 'Subjects' },
        { name: :award, section_name: '' },
        { name: :cultural_context, section_name: '' },
        { name: :ethnographic_term, section_name: '' },
        { name: :event, section_name: '' },
        { name: :keyword, section_name: '' },
        { name: :legal_name, section_name: '' },
        { name: :military_branch, section_name: '' },
        { name: :sports_team, section_name: '' },
        { name: :state_or_edition, section_name: '' },
        { name: :style_or_period, section_name: '' },
        { name: :tribal_classes, section_name: '' },
        { name: :tribal_terms, section_name: '' },
        { name: :phylum_or_division, section_name: 'Scientifics' },
        { name: :taxon_class, section_name: '' },
        { name: :order, section_name: '' },
        { name: :family, section_name: '' },
        { name: :genus, section_name: '' },
        { name: :species, section_name: '' },
        { name: :common_name, section_name: '' },
        { name: :accepted_name_usage, section_name: '' },
        { name: :original_name_usage, section_name: '' },
        { name: :scientific_name_authorship, section_name: '' },
        { name: :specimen_type, section_name: '' },
        { name: :identification_verification_status, section_name: '' },
        { name: :location, section_name: 'Locations' },
        { name: :box, section_name: '' },
        { name: :gps_latitude, section_name: '' },
        { name: :gps_longitude, section_name: '' },
        { name: :ranger_district, section_name: '' },
        { name: :street_address, section_name: '' },
        { name: :tgn, section_name: '' },
        { name: :water_basin, section_name: '' },
        { name: :date, section_name: 'Dates' },
        { name: :acquisition_date, section_name: '' },
        { name: :award_date, section_name: '' },
        { name: :collected_date, section_name: '' },
        { name: :date_created, section_name: '' },
        { name: :issued, section_name: '' },
        { name: :view_date, section_name: '' },
        { name: :accession_number, section_name: 'Identifiers' },
        { name: :barcode, section_name: '' },
        { name: :hydrologic_unit_code, section_name: '' },
        { name: :identifier, section_name: '' },
        { name: :item_locator, section_name: '' },
        { name: :longitude_latitude_identification, section_name: '' },
        { name: :license, section_name: 'Rights' },
        { name: :access_restrictions, section_name: '' },
        { name: :copyright_claimant, section_name: '' },
        { name: :rights_holder, section_name: '' },
        { name: :rights_note, section_name: '' },
        { name: :rights_statement, section_name: '' },
        { name: :use_restrictions, section_name: '' },
        { name: :repository, section_name: 'Sources' },
        { name: :copy_location, section_name: '' },
        { name: :location_copyshelf_location, section_name: '' },
        { name: :local_collection_name, section_name: '' },
        { name: :box_number, section_name: '' },
        { name: :citation, section_name: '' },
        { name: :current_repository_id, section_name: '' },
        { name: :folder_name, section_name: '' },
        { name: :folder_number, section_name: '' },
        { name: :language, section_name: '' },
        { name: :local_collection_id, section_name: '' },
        { name: :publisher, section_name: '' },
        { name: :place_of_production, section_name: '' },
        { name: :provenance, section_name: '' },
        { name: :publication_place, section_name: '' },
        { name: :series_name, section_name: '' },
        { name: :series_number, section_name: '' },
        { name: :source, section_name: '' },
        { name: :art_series, section_name: 'Relations' },
        { name: :has_finding_aid, section_name: '' },
        { name: :has_part, section_name: '' },
        { name: :has_version, section_name: '' },
        { name: :isPartOf, section_name: '' },
        { name: :is_version_of, section_name: '' },
        { name: :relation, section_name: '' },
        { name: :related_url, section_name: '' },
        { name: :resource_type, section_name: 'Types' },
        { name: :workType, section_name: '' },
        { name: :material, section_name: 'Formats' },
        { name: :measurements, section_name: '' },
        { name: :physical_extent, section_name: '' },
        { name: :technique, section_name: '' },
        { name: :color_content, section_name: 'Administratives' },
        { name: :conversion, section_name: '' },
        { name: :full_text, section_name: '' },
        { name: :exhibit, section_name: '' },
        { name: :institution, section_name: '' },
        { name: :original_filename, section_name: '' },
        { name: :resolution, section_name: '' },
        { name: :full_size_download_allowed, section_name: '' },
        { name: :date_modified, section_name: '' },
        { name: :date_uploaded, section_name: '' }
      ].freeze
    end
  end
end
