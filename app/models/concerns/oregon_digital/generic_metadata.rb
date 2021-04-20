# frozen_string_literal:true

module OregonDigital
  # Sets metadata for a generic work
  module GenericMetadata
    extend ActiveSupport::Concern
    # Usage notes and expectations can be found in the Metadata Application Profile:
    # https://docs.google.com/spreadsheets/d/16xBFjmeSsaN0xQrbOpQ_jIOeFZk3ZM9kmB8CU3IhP2c/edit#gid=0
    # Also, check out tmp/scripts/map_parse for a script to generate properties from the MAP above

    included do
      initial_properties = properties.keys
      property :label, predicate: ActiveFedora::RDF::Fcrepo::Model.downloadFilename, multiple: false
      property :relative_path, predicate: ::RDF::URI.new('http://scholarsphere.psu.edu/ns#relativePath'), multiple: false
      property :import_url, predicate: ::RDF::URI.new('http://scholarsphere.psu.edu/ns#importUrl'), multiple: false

      property :alternative, predicate: RDF::Vocab::DC.alternative, multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :tribal_title, predicate: RDF::URI.new('http://opaquenamespace.org/ns/tribalTitle'), multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :title, predicate: RDF::Vocab::DC.title, multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :creator, predicate: RDF::Vocab::DC11.creator, multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :photographer, predicate: RDF::Vocab::MARCRelators.pht, multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :arranger, predicate: RDF::Vocab::MARCRelators.arr, multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :artist, predicate: RDF::Vocab::MARCRelators.art, multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :author, predicate: RDF::Vocab::MARCRelators.aut, multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :cartographer, predicate: RDF::Vocab::MARCRelators.ctg, multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :collector, predicate: RDF::Vocab::MARCRelators.col, multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :composer, predicate: RDF::Vocab::MARCRelators.cmp, multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :creator_display, predicate: RDF::URI.new('http://opaquenamespace.org/ns/cco_creatorDisplay'), multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable, :facetable
      end

      property :contributor, predicate: RDF::Vocab::DC11.contributor, multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :dedicatee, predicate: RDF::Vocab::MARCRelators.dte, multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :designer, predicate: RDF::Vocab::MARCRelators.dsr, multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :donor, predicate: RDF::Vocab::MARCRelators.dnr, multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :editor, predicate: RDF::Vocab::MARCRelators.edt, multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :illustrator, predicate: RDF::Vocab::MARCRelators.ill, multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :interviewee, predicate: RDF::Vocab::MARCRelators.ive, multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :interviewer, predicate: RDF::Vocab::MARCRelators.ivr, multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :lyricist, predicate: RDF::Vocab::MARCRelators.lyr, multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :owner, predicate: RDF::Vocab::MARCRelators.own, multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :patron, predicate: RDF::Vocab::MARCRelators.pat, multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :print_maker, predicate: RDF::Vocab::MARCRelators.prm, multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :recipient, predicate: RDF::Vocab::MARCRelators.rcp, multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :transcriber, predicate: RDF::Vocab::MARCRelators.trc, multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :translator, predicate: RDF::Vocab::MARCRelators.trl, multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :description, predicate: RDF::Vocab::DC.description, multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :abstract, predicate: RDF::Vocab::DC.abstract, multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :biographical_information, predicate: RDF::URI.new('http://rdaregistry.info/Elements/a/P50113'), multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :compass_direction, predicate: RDF::URI.new('http://opaquenamespace.org/ns/compassDirection'), multiple: true, basic_searchable: false do |index|
        index.as :stored_searchable
      end

      property :cover_description, predicate: RDF::URI.new('http://opaquenamespace.org/ns/coverDescription'), multiple: true, basic_searchable: false do |index|
        index.as :stored_searchable
      end

      property :coverage, predicate: RDF::Vocab::DC11.coverage, multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :description_of_manifestation, predicate: RDF::URI.new('http://rdaregistry.info/Elements/w/P10271'), multiple: true, basic_searchable: false do |index|
        index.as :stored_searchable
      end

      property :designer_inscription, predicate: RDF::URI.new('http://opaquenamespace.org/ns/cdwa/InscriptionTranscription'), multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :form_of_work, predicate: RDF::URI.new('http://rdaregistry.info/Elements/w/P10004'), multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::FormOfWork do |index|
        index.as :stored_searchable, :facetable
      end

      property :former_owner, predicate: RDF::Vocab::MARCRelators.fmo, multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable, :facetable
      end

      property :inscription, predicate: RDF::URI.new('http://opaquenamespace.org/ns/vra_inscription'), multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :layout, predicate: RDF::URI.new('http://rdaregistry.info/Elements/m/P30155'), multiple: true, basic_searchable: false do |index|
        index.as :stored_searchable
      end

      property :military_highest_rank, predicate: RDF::URI.new('http://opaquenamespace.org/ns/militaryHighestRank'), multiple: false, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :military_occupation, predicate: RDF::URI.new('http://opaquenamespace.org/ns/militaryOccupation'), multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :military_service_location, predicate: RDF::URI.new('http://opaquenamespace.org/ns/militaryServiceLocation'), multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :mode_of_issuance, predicate: RDF::URI.new('http://rdaregistry.info/Elements/m/P30003'), multiple: true, basic_searchable: false do |index|
        index.as :stored_searchable, :facetable
      end

      property :mods_note, predicate: RDF::Vocab::MODS.note, multiple: true, basic_searchable: false do |index|
        index.as :stored_searchable
      end

      property :motif, predicate: RDF::URI.new('http://opaquenamespace.org/ns/motif'), multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :object_orientation, predicate: RDF::URI.new('http://opaquenamespace.org/ns/objectOrientation'), multiple: false, basic_searchable: false do |index|
        index.as :stored_searchable
      end

      property :tribal_notes, predicate: RDF::URI.new('http://opaquenamespace.org/ns/tribalNotes'), multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :source_condition, predicate: RDF::URI.new('http://opaquenamespace.org/ns/sourceCondition'), multiple: true, basic_searchable: false do |index|
        index.as :stored_searchable
      end

      property :temporal, predicate: RDF::Vocab::DC.temporal, multiple: true, basic_searchable: false do |index|
        index.as :stored_searchable
      end

      property :subject, predicate: RDF::Vocab::DC.subject, multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::Subject do |index|
        index.as :stored_searchable, :facetable
      end

      property :award, predicate: RDF::Vocab::SCHEMA.award, multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :cultural_context, predicate: RDF::URI.new('http://purl.org/vra/culturalContext'), multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::Culture do |index|
        index.as :stored_searchable, :facetable
      end

      property :ethnographic_term, predicate: RDF::URI.new('http://opaquenamespace.org/ns/ethnographic'), multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::EthnographicTerm do |index|
        index.as :stored_searchable, :facetable
      end

      property :event, predicate: RDF::Vocab::SCHEMA.Event, multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :keyword, predicate: RDF::Vocab::DC11.subject, multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable, :facetable
      end

      property :legal_name, predicate: RDF::Vocab::SCHEMA.legalName, multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :military_branch, predicate: RDF::URI.new('http://opaquenamespace.org/ns/militaryBranch'), multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::Subject do |index|
        index.as :stored_searchable, :facetable
      end

      property :sports_team, predicate: RDF::URI.new('http://opaquenamespace.org/ns/sportsTeam'), multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :state_or_edition, predicate: RDF::URI.new('http://opaquenamespace.org/ns/vra_stateEdition'), multiple: true, basic_searchable: false do |index|
        index.as :stored_searchable
      end

      property :style_or_period, predicate: RDF::URI.new('http://purl.org/vra/StylePeriod'), multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::StylePeriod do |index|
        index.as :stored_searchable, :facetable
      end

      property :tribal_classes, predicate: RDF::URI.new('http://opaquenamespace.org/ns/tribalClasses'), multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :tribal_terms, predicate: RDF::URI.new('http://opaquenamespace.org/ns/tribalTerms'), multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :phylum_or_division, predicate: RDF::Vocab::DWC.phylum, multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::Scientific do |index|
        index.as :stored_searchable, :facetable
      end

      property :taxon_class, predicate: RDF::Vocab::DWC.class, multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::Scientific do |index|
        index.as :stored_searchable, :facetable
      end

      property :order, predicate: RDF::Vocab::DWC.order, multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::Scientific do |index|
        index.as :stored_searchable, :facetable
      end

      property :family, predicate: RDF::Vocab::DWC.family, multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::Scientific do |index|
        index.as :stored_searchable, :facetable
      end

      property :genus, predicate: RDF::Vocab::DWC.genus, multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::Scientific do |index|
        index.as :stored_searchable, :facetable
      end

      property :species, predicate: RDF::Vocab::DWC.specificEpithet, multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::Scientific do |index|
        index.as :stored_searchable, :facetable
      end

      property :common_name, predicate: RDF::Vocab::DWC.vernacularName, multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::Scientific do |index|
        index.as :stored_searchable
      end

      property :accepted_name_usage, predicate: RDF::Vocab::DWC.acceptedNameUsage, multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :original_name_usage, predicate: RDF::Vocab::DWC.originalNameUsage, multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :scientific_name_authorship, predicate: RDF::Vocab::DWC.scientificNameAuthorship, multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :specimen_type, predicate: RDF::URI.new('http://opaquenamespace.org/ns/specimenType'), multiple: false, basic_searchable: false do |index|
        index.as :stored_searchable
      end

      property :identification_verification_status, predicate: RDF::Vocab::DWC.identificationVerificationStatus, multiple: false, basic_searchable: false do |index|
        index.as :stored_searchable
      end

      property :location, predicate: RDF::Vocab::DC.spatial, multiple: true, basic_searchable: true, class_name: Hyrax::ControlledVocabularies::Location do |index|
        index.as :stored_searchable, :facetable
      end

      property :box, predicate: RDF::Vocab::SCHEMA.box, multiple: true, basic_searchable: false do |index|
        index.as :stored_searchable
      end

      property :gps_latitude, predicate: RDF::Vocab::EXIF.gpsLatitude, multiple: false, basic_searchable: false do |index|
        index.as :stored_searchable
      end

      property :gps_longitude, predicate: RDF::Vocab::EXIF.gpsLongitude, multiple: false, basic_searchable: false do |index|
        index.as :stored_searchable
      end

      property :ranger_district, predicate: RDF::URI.new('http://opaquenamespace.org/ns/rangerDistrict'), multiple: true, basic_searchable: true, class_name: Hyrax::ControlledVocabularies::Location do |index|
        index.as :stored_searchable, :facetable
      end

      property :street_address, predicate: RDF::Vocab::MADS.streetAddress, multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :tgn, predicate: RDF::URI.new('http://dbpedia.org/ontology/HistoricPlace'), multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::HistoricPlace do |index|
        index.as :stored_searchable, :facetable
      end

      property :water_basin, predicate: RDF::URI.new('http://opaquenamespace.org/ns/waterBasin'), multiple: true, basic_searchable: true, class_name: Hyrax::ControlledVocabularies::Location do |index|
        index.as :stored_searchable, :facetable
      end

      property :date, predicate: RDF::Vocab::DC.date, multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :acquisition_date, predicate: RDF::URI.new('http://opaquenamespace.org/ns/acquisitionDate'), multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :award_date, predicate: RDF::URI.new('http://opaquenamespace.org/ns/awardDate'), multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :collected_date, predicate: RDF::URI.new('http://opaquenamespace.org/ns/collectedDate'), multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :date_created, predicate: RDF::Vocab::DC.created, multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :issued, predicate: RDF::Vocab::DC.issued, multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :view_date, predicate: RDF::URI.new('http://opaquenamespace.org/ns/cco_viewDate'), multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :accession_number, predicate: RDF::URI.new('http://opaquenamespace.org/ns/cco_accessionNumber'), multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :barcode, predicate: RDF::URI.new('http://opaquenamespace.org/ns/barcode'), multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :hydrologic_unit_code, predicate: RDF::URI.new('http://opaquenamespace.org/ns/hydrologicUnitCode'), multiple: true, basic_searchable: false do |index|
        index.as :stored_searchable
      end

      property :identifier, predicate: RDF::Vocab::DC.identifier, multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :item_locator, predicate: RDF::URI.new('http://purl.org/ontology/holding'), multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :longitude_latitude_identification, predicate: RDF::URI.new('http://opaquenamespace.org/ns/llid'), multiple: true, basic_searchable: false do |index|
        index.as :stored_searchable
      end

      property :license, predicate: RDF::Vocab::CC.License, multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable, :facetable
      end

      property :access_restrictions, predicate: RDF::URI.new('http://data.archiveshub.ac.uk/def/accessRestrictions'), multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::AccessRestrictions do |index|
        index.as :stored_searchable
      end

      property :copyright_claimant, predicate: RDF::Vocab::MARCRelators.cpc, multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :rights_holder, predicate: RDF::Vocab::DC.rightsHolder, multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :rights_note, predicate: RDF::Vocab::EBUCore.rightsExpression, multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :rights_statement, predicate: RDF::Vocab::EDM.rights, multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable, :facetable
      end

      property :use_restrictions, predicate: RDF::URI.new('http://rdaregistry.info/Elements/u/P60497'), multiple: true, basic_searchable: false do |index|
        index.as :stored_searchable
      end

      property :repository, predicate: RDF::Vocab::MARCRelators.rps, multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::Repository do |index|
        index.as :stored_searchable, :facetable
      end

      property :copy_location, predicate: RDF::Vocab::MODS.locationCopySublocation, multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :location_copyshelf_location, predicate: RDF::Vocab::MODS.locationCopyShelfLocator, multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :local_collection_name, predicate: RDF::URI.new('http://opaquenamespace.org/ns/localCollectionName'), multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::LocalCollectionName do |index|
        index.as :stored_searchable, :facetable
      end

      property :box_number, predicate: RDF::URI.new('http://opaquenamespace.org/ns/boxNumber'), multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable, :facetable
      end

      property :citation, predicate: RDF::Vocab::SCHEMA.citation, multiple: true, basic_searchable: false do |index|
        index.as :stored_searchable
      end

      property :current_repository_id, predicate: RDF::URI.new('http://opaquenamespace.org/ns/vra_idCurrentRepository'), multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :folder_name, predicate: RDF::URI.new('http://opaquenamespace.org/ns/folderName'), multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable, :facetable
      end

      property :folder_number, predicate: RDF::URI.new('http://opaquenamespace.org/ns/folderNumber'), multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable, :facetable
      end

      property :language, predicate: RDF::Vocab::DC.language, multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable, :facetable
      end

      property :local_collection_id, predicate: RDF::URI.new('http://opaquenamespace.org/ns/localCollectionID'), multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :publisher, predicate: RDF::Vocab::DC.publisher, multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::Publisher do |index|
        index.as :stored_searchable, :facetable
      end

      property :place_of_production, predicate: RDF::URI.new('http://rdaregistry.info/Elements/u/P60161'), multiple: true, basic_searchable: true, class_name: Hyrax::ControlledVocabularies::Location do |index|
        index.as :stored_searchable
      end

      property :provenance, predicate: RDF::Vocab::DC.provenance, multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :publication_place, predicate: RDF::Vocab::MARCRelators.pup, multiple: true, basic_searchable: true, class_name: Hyrax::ControlledVocabularies::Location do |index|
        index.as :stored_searchable
      end

      property :series_name, predicate: RDF::URI.new('http://opaquenamespace.org/ns/seriesName'), multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable, :facetable
      end

      property :series_number, predicate: RDF::URI.new('http://opaquenamespace.org/ns/seriesNumber'), multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable, :facetable
      end

      property :source, predicate: RDF::Vocab::DC.source, multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :art_series, predicate: RDF::URI.new('http://opaquenamespace.org/ns/artSeries'), multiple: true, basic_searchable: false do |index|
        index.as :stored_searchable
      end

      property :has_finding_aid, predicate: RDF::URI.new('http://lod.xdams.org/reload/oad/has_findingAid'), multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :has_part, predicate: RDF::Vocab::DC.hasPart, multiple: true, basic_searchable: false do |index|
        index.as :stored_searchable
      end

      property :has_version, predicate: RDF::Vocab::DC.hasVersion, multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :isPartOf, predicate: RDF::URI.new('http://opaquenamespace.org/ns/isPartOf'), multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :is_version_of, predicate: RDF::Vocab::DC.isVersionOf, multiple: true, basic_searchable: false do |index|
        index.as :stored_searchable
      end

      property :relation, predicate: RDF::Vocab::DC.relation, multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :related_url, predicate: RDF::RDFS.seeAlso, multiple: true, basic_searchable: false do |index|
        index.as :stored_searchable
      end

      property :resource_type, predicate: RDF::Vocab::DC.type, multiple: false, basic_searchable: true do |index|
        index.as :stored_searchable, :facetable
      end

      property :workType, predicate: RDF::URI.new('http://www.rdaregistry.info/Elements/w/#P10004'), multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::WorkType do |index|
        index.as :stored_searchable, :facetable
      end

      property :material, predicate: RDF::URI.new('http://purl.org/vra/material'), multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :measurements, predicate: RDF::URI.new('http://opaquenamespace.org/ns/vra_measurements'), multiple: true, basic_searchable: false do |index|
        index.as :stored_searchable
      end

      property :physical_extent, predicate: RDF::Vocab::MODS.physicalExtent, multiple: true, basic_searchable: false do |index|
        index.as :stored_searchable
      end

      property :technique, predicate: RDF::URI.new('http://purl.org/vra/hasTechnique'), multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable
      end

      property :conversion, predicate: RDF::URI.new('http://opaquenamespace.org/ns/conversionSpecifications'), multiple: true, basic_searchable: false do |index|
        index.as :stored_searchable
      end

      property :full_text, predicate: RDF::URI.new('http://opaquenamespace.org/ns/fullText'), multiple: false, basic_searchable: false do |index|
        index.as :stored_searchable
      end

      property :exhibit, predicate: RDF::URI.new('http://opaquenamespace.org/ns/exhibit'), multiple: true, basic_searchable: true do |index|
        index.as :stored_searchable, :facetable
      end

      property :institution, predicate: RDF::URI.new('http://opaquenamespace.org/ns/contributingInstitution'), multiple: true, basic_searchable: true, class_name: OregonDigital::ControlledVocabularies::Institution do |index|
        index.as :stored_searchable, :facetable
      end

      property :original_filename, predicate: RDF::URI.new('http://www.loc.gov/premis/rdf/v3/originalName'), multiple: false, basic_searchable: false do |index|
        index.as :stored_searchable
      end

      property :replaces_url, predicate: RDF::Vocab::DC.replaces, multiple: false, basic_searchable: false do |index|
        index.as :stored_searchable
      end

      property :full_size_download_allowed, predicate: RDF::URI.new('http://opaquenamespace.org/ns/fullSizeDownloadAllowed'), multiple: false, basic_searchable: false do |index|
        index.as :stored_searchable, :facetable
      end

      property :date_modified, predicate: RDF::Vocab::DC.modified, multiple: false, basic_searchable: false do |index|
        index.as :stored_searchable
      end

      property :date_uploaded, predicate: RDF::Vocab::DC.dateSubmitted, multiple: false, basic_searchable: false do |index|
        index.as :stored_searchable
      end

      define_singleton_method :generic_properties do
        (properties.reject { |_k, v| v.class_name.nil? ? false : v.class_name.to_s.include?('ControlledVocabularies') }.keys - initial_properties)
      end

      ORDERED_PROPERTIES = [
        { name: 'alternative', is_controlled: false, collection_facetable: false },
        { name: 'tribal_title', is_controlled: false, collection_facetable: false },
        { name: 'creator_display', is_controlled: false, collection_facetable: false },
        { name: 'creator_label', is_controlled: true, collection_facetable: true },
        { name: 'contributor_label', is_controlled: true, collection_facetable: true },
        { name: 'arranger_label', is_controlled: true, collection_facetable: true },
        { name: 'artist_label', is_controlled: true, collection_facetable: true },
        { name: 'author_label', is_controlled: true, collection_facetable: true },
        { name: 'cartographer_label', is_controlled: true, collection_facetable: true },
        { name: 'collector_label', is_controlled: true, collection_facetable: true },
        { name: 'composer_label', is_controlled: true, collection_facetable: true },
        { name: 'dedicatee_label', is_controlled: true, collection_facetable: true },
        { name: 'donor_label', is_controlled: true, collection_facetable: true },
        { name: 'designer_label', is_controlled: true, collection_facetable: true },
        { name: 'editor_label', is_controlled: true, collection_facetable: true },
        { name: 'former_owner', is_controlled: false, collection_facetable: true },
        { name: 'illustrator_label', is_controlled: true, collection_facetable: true },
        { name: 'interviewee_label', is_controlled: true, collection_facetable: true },
        { name: 'interviewer_label', is_controlled: true, collection_facetable: true },
        { name: 'lyricist_label', is_controlled: true, collection_facetable: true },
        { name: 'owner_label', is_controlled: true, collection_facetable: true },
        { name: 'patron_label', is_controlled: true, collection_facetable: true },
        { name: 'photographer_label', is_controlled: true, collection_facetable: true },
        { name: 'print_maker_label', is_controlled: true, collection_facetable: true },
        { name: 'recipient_label', is_controlled: true, collection_facetable: true },
        { name: 'transcriber_label', is_controlled: true, collection_facetable: true },
        { name: 'translator_label', is_controlled: true, collection_facetable: true },
        { name: 'date', is_controlled: false, collection_facetable: false },
        { name: 'date_created', is_controlled: false, collection_facetable: false },
        { name: 'issued', is_controlled: false, collection_facetable: false },
        { name: 'award_date', is_controlled: false, collection_facetable: false },
        { name: 'acquisition_date', is_controlled: false, collection_facetable: false },
        { name: 'collected_date', is_controlled: false, collection_facetable: false },
        { name: 'description', is_controlled: false, collection_facetable: false },
        { name: 'tribal_notes', is_controlled: false, collection_facetable: false },
        { name: 'abstract', is_controlled: false, collection_facetable: false },
        { name: 'table_of_contents', is_controlled: false, collection_facetable: false },
        { name: 'view', is_controlled: false, collection_facetable: false },
        { name: 'view_date', is_controlled: false, collection_facetable: false },
        { name: 'temporal', is_controlled: false, collection_facetable: false },
        { name: 'coverage', is_controlled: false, collection_facetable: false },
        { name: 'inscription', is_controlled: false, collection_facetable: false },
        { name: 'source_condition', is_controlled: false, collection_facetable: false },
        { name: 'description_of_manifestation', is_controlled: false, collection_facetable: false },
        { name: 'mode_of_issuance', is_controlled: false, collection_facetable: true },
        { name: 'form_of_work_label', is_controlled: true, collection_facetable: true },
        { name: 'layout', is_controlled: false, collection_facetable: false },
        { name: 'biographical_information', is_controlled: false, collection_facetable: false },
        { name: 'cover_description', is_controlled: false, collection_facetable: false },
        { name: 'first_line', is_controlled: false, collection_facetable: false },
        { name: 'first_line_chorus', is_controlled: false, collection_facetable: false },
        { name: 'instrumentation', is_controlled: false, collection_facetable: false },
        { name: 'military_branch_label', is_controlled: true, collection_facetable: true },
        { name: 'military_highest_rank', is_controlled: false, collection_facetable: false },
        { name: 'military_occupation', is_controlled: false, collection_facetable: false },
        { name: 'military_service_location', is_controlled: false, collection_facetable: false },
        { name: 'compass_direction', is_controlled: false, collection_facetable: false },
        { name: 'object_orientation', is_controlled: false, collection_facetable: false },
        { name: 'photograph_orientation', is_controlled: false, collection_facetable: false },
        { name: 'subject_label', is_controlled: true, collection_facetable: true },
        { name: 'tribal_classes', is_controlled: false, collection_facetable: false },
        { name: 'tribal_terms', is_controlled: false, collection_facetable: false },
        { name: 'keyword', is_controlled: false, collection_facetable: true },
        { name: 'ethnographic_term_label', is_controlled: true, collection_facetable: true },
        { name: 'legal_name', is_controlled: false, collection_facetable: false },
        { name: 'event', is_controlled: false, collection_facetable: false },
        { name: 'sports_team', is_controlled: false, collection_facetable: false },
        { name: 'award', is_controlled: false, collection_facetable: false },
        { name: 'workType_label', is_controlled: true, collection_facetable: true },
        { name: 'cultural_context_label', is_controlled: true, collection_facetable: true },
        { name: 'style_or_period_label', is_controlled: true, collection_facetable: true },
        { name: 'state_or_edition', is_controlled: false, collection_facetable: false },
        { name: 'phylum_or_division_label', is_controlled: true, collection_facetable: true },
        { name: 'taxon_class_label', is_controlled: true, collection_facetable: true },
        { name: 'order_label', is_controlled: true, collection_facetable: true },
        { name: 'family_label', is_controlled: true, collection_facetable: true },
        { name: 'genus_label', is_controlled: true, collection_facetable: true },
        { name: 'species_label', is_controlled: true, collection_facetable: true },
        { name: 'common_name_label', is_controlled: false, collection_facetable: false },
        { name: 'accepted_name_usage', is_controlled: false, collection_facetable: false },
        { name: 'original_name_usage', is_controlled: false, collection_facetable: false },
        { name: 'scientific_name_authorship', is_controlled: false, collection_facetable: false },
        { name: 'specimen_type', is_controlled: false, collection_facetable: false },
        { name: 'identification_verification_status', is_controlled: false, collection_facetable: false },
        { name: 'location_label', is_controlled: true, collection_facetable: true },
        { name: 'tgn_label', is_controlled: true, collection_facetable: true },
        { name: 'ranger_district_label', is_controlled: true, collection_facetable: true },
        { name: 'water_basin_label', is_controlled: true, collection_facetable: true },
        { name: 'street_address', is_controlled: false, collection_facetable: false },
        { name: 'gps_latitude', is_controlled: false, collection_facetable: false },
        { name: 'gps_longitude', is_controlled: false, collection_facetable: false },
        { name: 'box', is_controlled: false, collection_facetable: false },
        { name: 'material', is_controlled: false, collection_facetable: false },
        { name: 'technique', is_controlled: false, collection_facetable: false },
        { name: 'measurements', is_controlled: false, collection_facetable: false },
        { name: 'physical_extent', is_controlled: false, collection_facetable: false },
        { name: 'rights_statement_label', is_controlled: true, name_label: 'rights_statement', collection_facetable: true },
        { name: 'license_label', is_controlled: true, collection_facetable: true },
        { name: 'use_restrictions', is_controlled: false, collection_facetable: false },
        { name: 'rights_note', is_controlled: false, collection_facetable: false },
        { name: 'rights_holder', is_controlled: false, collection_facetable: false },
        { name: 'copyright_claimant', is_controlled: false, collection_facetable: false },
        { name: 'access_restrictions_label', is_controlled: false, collection_facetable: false },
        { name: 'identifier', is_controlled: false, collection_facetable: false },
        { name: 'item_locator', is_controlled: false, collection_facetable: false },
        { name: 'accession_number', is_controlled: false, collection_facetable: false },
        { name: 'barcode', is_controlled: false, collection_facetable: false },
        { name: 'hydrologic_unit_code', is_controlled: false, collection_facetable: false },
        { name: 'longitude_latitude_identification', is_controlled: false, collection_facetable: false },
        { name: 'language_label', is_controlled: true, name_label: 'language', collection_facetable: true },
        { name: 'source', is_controlled: false, collection_facetable: false },
        { name: 'provenance', is_controlled: false, collection_facetable: false },
        { name: 'repository_label', is_controlled: true, collection_facetable: true },
        { name: 'current_repository_id', is_controlled: false, collection_facetable: false },
        { name: 'location_copyshelf_location', is_controlled: false, collection_facetable: false },
        { name: 'copy_location', is_controlled: false, collection_facetable: false },
        { name: 'local_collection_name_label', is_controlled: true, collection_facetable: true },
        { name: 'local_collection_id', is_controlled: false, collection_facetable: false },
        { name: 'series_name', is_controlled: false, collection_facetable: true },
        { name: 'series_number', is_controlled: false, collection_facetable: true },
        { name: 'box_number', is_controlled: false, collection_facetable: true },
        { name: 'folder_name', is_controlled: false, collection_facetable: true },
        { name: 'folder_number', is_controlled: false, collection_facetable: true },
        { name: 'publisher_label', is_controlled: true, collection_facetable: true },
        { name: 'publication_place_label', is_controlled: true, collection_facetable: false },
        { name: 'place_of_production_label', is_controlled: true, collection_facetable: false },
        { name: 'contained_in_journal', is_controlled: false, collection_facetable: false },
        { name: 'is_volume', is_controlled: false, collection_facetable: true },
        { name: 'has_number', is_controlled: false, collection_facetable: true },
        { name: 'on_pages', is_controlled: false, collection_facetable: false },
        { name: 'citation', is_controlled: false, collection_facetable: false },
        { name: 'has_finding_aid', is_controlled: false, collection_facetable: false },
        { name: 'relation', is_controlled: false, collection_facetable: false },
        { name: 'is_version_of', is_controlled: false, collection_facetable: false },
        { name: 'has_version', is_controlled: false, collection_facetable: false },
        { name: 'isPartOf', is_controlled: false, collection_facetable: false },
        { name: 'has_part', is_controlled: false, collection_facetable: false },
        { name: 'larger_work', is_controlled: false, collection_facetable: false },
        { name: 'designer_inscription', is_controlled: false, collection_facetable: false },
        { name: 'art_series', is_controlled: false, collection_facetable: false },
        { name: 'motif', is_controlled: false, collection_facetable: false },
        { name: 'resource_type_label', is_controlled: true, name_label: 'Media', collection_facetable: true },
        { name: 'set', is_controlled: false, collection_facetable: false },
        { name: 'exhibit', is_controlled: false, collection_facetable: true },
        { name: 'institution_label', is_controlled: true, collection_facetable: true },
        { name: 'conversion', is_controlled: false, collection_facetable: false },
        { name: 'date_uploaded', is_controlled: false, collection_facetable: false },
        { name: 'date_modified', is_controlled: false, collection_facetable: false },
        { name: 'original_filename', is_controlled: false, collection_facetable: false },
        { name: 'resolution', is_controlled: false, collection_facetable: false },
        { name: 'color_content', is_controlled: false, collection_facetable: false }
      ].freeze

      UNORDERED_PROPERTIES = [
        { name: 'full_size_download_allowed_label', is_controlled: true, collection_facetable: true }
      ].freeze

      ORDERED_TERMS = %i[
        alternative
        tribal_title
        title
        creator
        photographer
        arranger
        artist
        author
        cartographer
        collector
        composer
        creator_display
        contributor
        dedicatee
        designer
        donor
        editor
        illustrator
        interviewee
        interviewer
        lyricist
        owner
        patron
        print_maker
        recipient
        transcriber
        translator
        description
        abstract
        biographical_information
        compass_direction
        cover_description
        coverage
        description_of_manifestation
        designer_inscription
        form_of_work
        former_owner
        inscription
        layout
        military_highest_rank
        military_occupation
        military_service_location
        mode_of_issuance
        mods_note
        motif
        object_orientation
        tribal_notes
        source_condition
        temporal
        subject
        award
        cultural_context
        ethnographic_term
        event
        keyword
        legal_name
        military_branch
        sports_team
        state_or_edition
        style_or_period
        tribal_classes
        tribal_terms
        phylum_or_division
        taxon_class
        order
        family
        genus
        species
        common_name
        accepted_name_usage
        original_name_usage
        scientific_name_authorship
        specimen_type
        identification_verification_status
        location
        box
        gps_latitude
        gps_longitude
        ranger_district
        street_address
        tgn
        water_basin
        date
        acquisition_date
        award_date
        collected_date
        date_created
        issued
        view_date
        accession_number
        barcode
        hydrologic_unit_code
        identifier
        item_locator
        longitude_latitude_identification
        license
        access_restrictions
        copyright_claimant
        rights_holder
        rights_note
        rights_statement
        use_restrictions
        repository
        copy_location
        location_copyshelf_location
        local_collection_name
        box_number
        citation
        current_repository_id
        folder_name
        folder_number
        language
        local_collection_id
        publisher
        place_of_production
        provenance
        publication_place
        series_name
        series_number
        source
        art_series
        has_finding_aid
        has_part
        has_version
        isPartOf
        is_version_of
        relation
        related_url
        resource_type
        workType
        material
        measurements
        physical_extent
        technique
        conversion
        full_text
        exhibit
        institution
        original_filename
        full_size_download_allowed
        date_modified
        date_uploaded
      ].freeze
    end
  end
end
