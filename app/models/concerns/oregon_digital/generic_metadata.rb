# frozen_string_literal:true

module OregonDigital
  # Sets metadata for a generic work
  module GenericMetadata
    extend ActiveSupport::Concern
    # Usage notes and expectations can be found in the Metadata Application Profile:
    # https://docs.google.com/spreadsheets/d/16xBFjmeSsaN0xQrbOpQ_jIOeFZk3ZM9kmB8CU3IhP2c/edit#gid=0

    included do
      initial_properties = properties.keys
      property :label, predicate: ActiveFedora::RDF::Fcrepo::Model.downloadFilename, multiple: false
      property :relative_path, predicate: ::RDF::URI.new('http://scholarsphere.psu.edu/ns#relativePath'), multiple: false
      property :import_url, predicate: ::RDF::URI.new('http://scholarsphere.psu.edu/ns#importUrl'), multiple: false
      property :resource_type, predicate: ::RDF::Vocab::DC.type, multiple: false do |index|
        index.as :stored_searchable, :facetable
      end
      property :date_created, predicate: ::RDF::Vocab::DC.created do |index|
        index.as :stored_searchable
      end

      property :description, basic_searchable: false, predicate: ::RDF::Vocab::DC.description do |index|
        index.as :stored_searchable
      end

      property :rights_statement, predicate: ::RDF::Vocab::EDM.rights do |index|
        index.as :stored_searchable, :facetable
      end
      property :identifier, predicate: ::RDF::Vocab::DC.identifier do |index|
        index.as :stored_searchable
      end

      property :alternative, predicate: ::RDF::Vocab::DC.alternative do |index|
        index.as :stored_searchable
      end

      property :tribal_title, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/tribalTitle') do |index|
        index.as :stored_searchable
      end

      property :creator_display, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/cco_creatorDisplay') do |index|
        index.as :stored_searchable, :facetable
      end

      property :former_owner, predicate: ::RDF::Vocab::MARCRelators.fmo do |index|
        index.as :stored_searchable, :facetable
      end

      property :abstract, predicate: ::RDF::Vocab::DC.abstract do |index|
        index.as :stored_searchable
      end

      property :accepted_name_usage, predicate: ::RDF::Vocab::DWC.acceptedNameUsage do |index|
        index.as :stored_searchable
      end

      property :biographical_information, predicate: ::RDF::URI.new('http://rdaregistry.info/Elements/a/P50113') do |index|
        index.as :stored_searchable
      end

      property :compass_direction, basic_searchable: false, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/compassDirection') do |index|
        index.as :stored_searchable
      end

      property :contents, basic_searchable: false, showable: false, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/contents') do |index|
        index.as :stored_searchable
      end

      property :cover_description, basic_searchable: false, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/coverDescription') do |index|
        index.as :stored_searchable
      end

      property :coverage, predicate: ::RDF::Vocab::DC11.coverage do |index|
        index.as :stored_searchable
      end

      property :description_of_manifestation, basic_searchable: false, predicate: ::RDF::URI.new('http://rdaregistry.info/Elements/w/P10271') do |index|
        index.as :stored_searchable
      end

      property :identification_verification_status, basic_searchable: false, predicate: ::RDF::Vocab::DWC.identificationVerificationStatus, multiple: false do |index|
        index.as :stored_searchable
      end

      property :inscription, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/vra_inscription') do |index|
        index.as :stored_searchable
      end

      property :layout, basic_searchable: false, predicate: ::RDF::URI.new('http://rdaregistry.info/Elements/m/P30155') do |index|
        index.as :stored_searchable
      end

      property :military_highest_rank, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/militaryHighestRank'), multiple: false do |index|
        index.as :stored_searchable
      end

      property :military_occupation, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/militaryOccupation') do |index|
        index.as :stored_searchable
      end

      property :military_service_location, basic_searchable: false, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/militaryServiceLocation') do |index|
        index.as :stored_searchable
      end

      property :mode_of_issuance, basic_searchable: false, predicate: ::RDF::URI.new('http://rdaregistry.info/Elements/m/P30003') do |index|
        index.as :facetable, :stored_searchable
      end

      property :mods_note, basic_searchable: false, predicate: ::RDF::Vocab::MODS.note do |index|
        index.as :stored_searchable
      end

      property :object_orientation, basic_searchable: false, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/objectOrientation'), multiple: false do |index|
        index.as :stored_searchable
      end

      property :original_name_usage, predicate: ::RDF::Vocab::DWC.originalNameUsage do |index|
        index.as :stored_searchable
      end

      property :tribal_notes, basic_searchable: false, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/tribalNotes') do |index|
        index.as :stored_searchable
      end

      property :source_condition, basic_searchable: false, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/sourceCondition') do |index|
        index.as :stored_searchable
      end

      property :specimen_type, basic_searchable: false, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/specimenType'), multiple: false do |index|
        index.as :stored_searchable
      end

      property :temporal, basic_searchable: false, predicate: ::RDF::Vocab::DC.temporal do |index|
        index.as :stored_searchable
      end

      property :event, predicate: ::RDF::Vocab::SCHEMA.Event do |index|
        index.as :stored_searchable
      end

      property :keyword, predicate: ::RDF::Vocab::DC11.subject do |index|
        index.as :stored_searchable, :facetable
      end

      property :sports_team, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/sportsTeam') do |index|
        index.as :stored_searchable
      end

      property :state_or_edition, basic_searchable: false, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/vra_stateEdition') do |index|
        index.as :stored_searchable
      end

      property :tribal_classes, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/tribalClasses') do |index|
        index.as :stored_searchable
      end

      property :tribal_terms, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/tribalTerms') do |index|
        index.as :stored_searchable
      end

      property :scientific_name_authorship, predicate: ::RDF::Vocab::DWC.scientificNameAuthorship do |index|
        index.as :stored_searchable
      end

      property :award, predicate: ::RDF::Vocab::SCHEMA.award do |index|
        index.as :stored_searchable
      end

      property :legal_name, predicate: ::RDF::Vocab::SCHEMA.legalName do |index|
        index.as :stored_searchable
      end

      property :box_number, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/boxNumber') do |index|
        index.as :stored_searchable, :facetable
      end

      property :citation, basic_searchable: false, predicate: ::RDF::Vocab::SCHEMA.citation do |index|
        index.as :stored_searchable
      end

      property :current_repository_id, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/vra_idCurrentRepository') do |index|
        index.as :stored_searchable
      end

      property :folder_name, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/folderName') do |index|
        index.as :stored_searchable, :facetable
      end

      property :folder_number, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/folderNumber') do |index|
        index.as :stored_searchable, :facetable
      end

      property :local_collection_id, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/localCollectionID') do |index|
        index.as :stored_searchable
      end

      property :location_copyshelf_location, predicate: ::RDF::Vocab::MODS.locationCopyShelfLocator do |index|
        index.as :stored_searchable
      end

      property :language, predicate: ::RDF::Vocab::DC.language do |index|
        index.as :stored_searchable, :facetable
      end

      property :provenance, predicate: ::RDF::Vocab::DC.provenance do |index|
        index.as :stored_searchable
      end

      property :source, predicate: ::RDF::Vocab::DC.source do |index|
        index.as :stored_searchable
      end

      property :series_name, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/seriesName') do |index|
        index.as :stored_searchable, :facetable
      end

      property :series_number, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/seriesNumber') do |index|
        index.as :stored_searchable, :facetable
      end

      property :art_series, basic_searchable: false, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/artSeries') do |index|
        index.as :stored_searchable
      end

      property :has_finding_aid, predicate: ::RDF::URI.new('http://lod.xdams.org/reload/oad/has_findingAid') do |index|
        index.as :stored_searchable
      end

      property :has_part, basic_searchable: false, predicate: ::RDF::Vocab::DC.hasPart do |index|
        index.as :stored_searchable
      end

      property :has_version, predicate: ::RDF::Vocab::DC.hasVersion do |index|
        index.as :stored_searchable
      end

      property :isPartOf, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/isPartOf') do |index|
        index.as :stored_searchable
      end

      property :is_version_of, basic_searchable: false, predicate: ::RDF::Vocab::DC.isVersionOf do |index|
        index.as :stored_searchable
      end

      property :relation, predicate: ::RDF::Vocab::DC.relation do |index|
        index.as :stored_searchable, :facetable
      end

      property :workType, predicate: ::RDF::URI.new('https://www.w3.org/1999/02/22-rdf-syntax-ns#type'),
                          class_name: OregonDigital::ControlledVocabularies::WorkType do |index|
        index.as :stored_searchable, :facetable
      end

      property :extent, basic_searchable: false, predicate: ::RDF::Vocab::DC.extent do |index|
        index.as :stored_searchable
      end

      property :material, predicate: ::RDF::URI.new('http://purl.org/vra/material') do |index|
        index.as :stored_searchable
      end

      property :measurements, basic_searchable: false, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/vra_measurements') do |index|
        index.as :stored_searchable
      end

      property :physical_extent, basic_searchable: false, predicate: ::RDF::Vocab::MODS.physicalExtent do |index|
        index.as :stored_searchable
      end

      property :technique, predicate: ::RDF::URI.new('http://purl.org/vra/hasTechnique') do |index|
        index.as :stored_searchable
      end

      property :exhibit, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/exhibit') do |index|
        index.as :stored_searchable, :facetable
      end

      property :conversion, basic_searchable: false, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/conversionSpecifications') do |index|
        index.as :stored_searchable
      end

      property :copy_location, predicate: ::RDF::Vocab::MODS.locationCopySublocation do |index|
        index.as :stored_searchable
      end

      property :date_digitized, basic_searchable: false, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/dateDigitized'), multiple: false do |index|
        index.as :stored_searchable
      end

      property :file_size, basic_searchable: false, predicate: ::RDF::URI.new('http://rdaregistry.info/Elements/m/P30183'), multiple: false do |index|
        index.as :stored_searchable
      end

      property :replaces_url, basic_searchable: false, showable: false, predicate: ::RDF::Vocab::DC.replaces, multiple: false

      property :rights_note, predicate: ::RDF::Vocab::EBUCore.rightsExpression do |index|
        index.as :stored_searchable
      end

      property :box, basic_searchable: false, predicate: ::RDF::Vocab::SCHEMA.box do |index|
        index.as :stored_searchable
      end

      property :gps_latitude, basic_searchable: false, predicate: ::RDF::Vocab::EXIF.gpsLatitude, multiple: false do |index|
        index.as :stored_searchable
      end

      property :gps_longitude, basic_searchable: false, predicate: ::RDF::Vocab::EXIF.gpsLongitude, multiple: false do |index|
        index.as :stored_searchable
      end

      property :street_address, predicate: ::RDF::Vocab::MADS.streetAddress do |index|
        index.as :stored_searchable
      end

      property :award_date, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/awardDate') do |index|
        index.as :stored_searchable
      end

      property :collected_date, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/collectedDate') do |index|
        index.as :stored_searchable
      end

      property :date, predicate: ::RDF::Vocab::DC.date do |index|
        index.as :stored_searchable
      end

      property :issued, predicate: ::RDF::Vocab::DC.issued do |index|
        index.as :stored_searchable
      end

      property :view_date, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/cco_viewDate') do |index|
        index.as :stored_searchable
      end

      property :acquisition_date, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/acquisitionDate') do |index|
        index.as :stored_searchable
      end

      property :accession_number, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/cco_accessionNumber') do |index|
        index.as :stored_searchable
      end

      property :barcode, predicate: ::RDF::Vocab::Bibframe.barcode do |index|
        index.as :stored_searchable
      end

      property :hydrologic_unit_code, basic_searchable: false, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/hydrologicUnitCode') do |index|
        index.as :stored_searchable
      end

      property :item_locator, predicate: ::RDF::URI.new('http://purl.org/ontology/holding') do |index|
        index.as :stored_searchable
      end

      property :longitude_latitude_identification, basic_searchable: false, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/llid') do |index|
        index.as :stored_searchable
      end

      property :copyright_claimant, predicate: ::RDF::Vocab::MARCRelators.cpc do |index|
        index.as :stored_searchable
      end

      property :rights_holder, predicate: ::RDF::Vocab::DC.rightsHolder do |index|
        index.as :stored_searchable
      end

      property :license, predicate: ::RDF::Vocab::CC.License do |index|
        index.as :stored_searchable, :facetable
      end

      property :use_restrictions, basic_searchable: false, predicate: ::RDF::URI.new('http://rdaregistry.info/Elements/u/P60497') do |index|
        index.as :stored_searchable
      end

      property :access_restrictions, predicate: ::RDF::URI.new('http://data.archiveshub.ac.uk/def/accessRestrictions'), multiple: false do |index|
        index.as :stored_searchable
      end

      property :oembed_url, basic_searchable: false, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/oembed'), multiple: false do |index|
        index.as :facetable
      end

      property :original_filename, basic_searchable: false, showable: false, predicate: ::RDF::URI.new('http://www.loc.gov/premis/rdf/v3/originalName'), multiple: false do |index|
        index.as :stored_searchable
      end

      # End of normal properties
      # Controlled vocabulary terms
      property :arranger, predicate: ::RDF::Vocab::MARCRelators.arr, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :artist, predicate: ::RDF::Vocab::MARCRelators.art, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :author, predicate: ::RDF::Vocab::MARCRelators.aut, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :cartographer, predicate: ::RDF::Vocab::MARCRelators.ctg, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :collector, predicate: ::RDF::Vocab::MARCRelators.col, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :composer, predicate: ::RDF::Vocab::MARCRelators.cmp, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :creator, predicate: ::RDF::Vocab::DC11.creator, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :contributor, predicate: ::RDF::Vocab::DC11.contributor, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :dedicatee, predicate: ::RDF::Vocab::MARCRelators.dte, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :donor, predicate: ::RDF::Vocab::MARCRelators.dnr, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :designer, predicate: ::RDF::Vocab::MARCRelators.dsr, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :editor, predicate: ::RDF::Vocab::MARCRelators.edt, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :illustrator, predicate: ::RDF::Vocab::MARCRelators.ill, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :interviewee, predicate: ::RDF::Vocab::MARCRelators.ive, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :interviewer, predicate: ::RDF::Vocab::MARCRelators.ivr, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :lyricist, predicate: ::RDF::Vocab::MARCRelators.lyr, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :owner, predicate: ::RDF::Vocab::MARCRelators.own, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :patron, predicate: ::RDF::Vocab::MARCRelators.pat, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :photographer, predicate: ::RDF::Vocab::MARCRelators.pht, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :print_maker, predicate: ::RDF::Vocab::MARCRelators.prm, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :recipient, predicate: ::RDF::Vocab::MARCRelators.rcp, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :transcriber, predicate: ::RDF::Vocab::MARCRelators.trc, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :translator, predicate: ::RDF::Vocab::MARCRelators.trl, class_name: OregonDigital::ControlledVocabularies::Creator do |index|
        index.as :stored_searchable, :facetable
      end

      property :location, predicate: ::RDF::Vocab::DC.spatial, class_name: Hyrax::ControlledVocabularies::Location do |index|
        index.as :stored_searchable, :facetable
      end

      property :place_of_production, predicate: ::RDF::URI.new('http://rdaregistry.info/Elements/u/P60161'), class_name: Hyrax::ControlledVocabularies::Location do |index|
        index.as :stored_searchable
      end

      property :publication_place, predicate: ::RDF::Vocab::MARCRelators.pup, class_name: Hyrax::ControlledVocabularies::Location do |index|
        index.as :stored_searchable
      end

      property :ranger_district, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/rangerDistrict'),
                                 class_name: Hyrax::ControlledVocabularies::Location do |index|
        index.as :stored_searchable, :facetable
      end

      property :water_basin, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/waterBasin'),
                             class_name: Hyrax::ControlledVocabularies::Location do |index|
        index.as :stored_searchable, :facetable
      end

      property :cultural_context, predicate: ::RDF::URI.new('http://purl.org/vra/culturalContext'),
                                  class_name: OregonDigital::ControlledVocabularies::Culture do |index|
        index.as :stored_searchable, :facetable
      end

      property :ethnographic_term, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/ethnographic'),
                                   class_name: OregonDigital::ControlledVocabularies::EthnographicTerm do |index|
        index.as :stored_searchable, :facetable
      end

      property :style_or_period, predicate: ::RDF::URI.new('http://purl.org/vra/StylePeriod'),
                                 class_name: OregonDigital::ControlledVocabularies::StylePeriod do |index|
        index.as :stored_searchable, :facetable
      end

      property :form_of_work, predicate: ::RDF::URI.new('http://rdaregistry.info/Elements/w/P10004'),
                              class_name: OregonDigital::ControlledVocabularies::FormOfWork do |index|
        index.as :stored_searchable, :facetable
      end

      property :format, predicate: ::RDF::Vocab::DC.format, class_name: OregonDigital::ControlledVocabularies::MediaType do |index|
        index.as :stored_searchable, :facetable
      end

      property :institution, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/contributingInstitution'),
                             class_name: OregonDigital::ControlledVocabularies::Institution do |index|
        index.as :stored_searchable, :facetable
      end

      property :local_collection_name, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/localCollectionName'),
                                       class_name: OregonDigital::ControlledVocabularies::LocalCollectionName do |index|
        index.as :stored_searchable, :facetable
      end

      property :tgn, predicate: ::RDF::URI.new('http://dbpedia.org/ontology/HistoricPlace'),
                     class_name: OregonDigital::ControlledVocabularies::HistoricPlace do |index|
        index.as :stored_searchable, :facetable
      end

      property :repository, predicate: ::RDF::Vocab::MARCRelators.rps,
                            class_name: OregonDigital::ControlledVocabularies::Repository do |index|
        index.as :stored_searchable, :facetable
      end

      property :publisher, predicate: ::RDF::Vocab::DC.publisher,
                           class_name: OregonDigital::ControlledVocabularies::Publisher do |index|
        index.as :stored_searchable, :facetable
      end

      property :taxon_class, predicate: ::RDF::Vocab::DWC.class,
                             class_name: OregonDigital::ControlledVocabularies::Scientific do |index|
        index.as :stored_searchable, :facetable
      end

      property :family, predicate: ::RDF::Vocab::DWC.family,
                        class_name: OregonDigital::ControlledVocabularies::Scientific do |index|
        index.as :stored_searchable, :facetable
      end

      property :genus, predicate: ::RDF::Vocab::DWC.genus,
                       class_name: OregonDigital::ControlledVocabularies::Scientific do |index|
        index.as :stored_searchable, :facetable
      end

      property :order, predicate: ::RDF::Vocab::DWC.order,
                       class_name: OregonDigital::ControlledVocabularies::Scientific do |index|
        index.as :stored_searchable, :facetable
      end

      property :species, predicate: ::RDF::Vocab::DWC.specificEpithet,
                         class_name: OregonDigital::ControlledVocabularies::Scientific do |index|
        index.as :stored_searchable, :facetable
      end

      property :phylum_or_division, predicate: ::RDF::Vocab::DWC.phylum,
                                    class_name: OregonDigital::ControlledVocabularies::Scientific do |index|
        index.as :stored_searchable, :facetable
      end

      property :common_name, predicate: ::RDF::Vocab::DWC.vernacularName,
                             class_name: OregonDigital::ControlledVocabularies::Scientific do |index|
        index.as :stored_searchable
      end

      property :military_branch, predicate: ::RDF::URI.new('http://opaquenamespace.org/ns/militaryBranch'),
                                 class_name: OregonDigital::ControlledVocabularies::Subject do |index|
        index.as :stored_searchable, :facetable
      end

      property :subject, predicate: ::RDF::Vocab::DC.subject, class_name: OregonDigital::ControlledVocabularies::Subject do |index|
        index.as :stored_searchable, :facetable
      end

      id_blank = proc { |attributes| attributes[:id].blank? }

      class_attribute :controlled_properties

      # Sets controlled values
      self.controlled_properties = properties.select { |_k, v| v.class_name.nil? ? false : v.class_name.to_s.include?('ControlledVocabularies') }.keys.map(&:to_sym)

      # Allows for the controlled properties to accept nested data
      controlled_properties.each do |prop|
        accepts_nested_attributes_for prop, reject_if: id_blank, allow_destroy: true
      end

      # defines a method for Generic to be able to grab a list of properties
      define_singleton_method :controlled_property_labels do
        controlled_properties.each_with_object([]) { |prop, array| array << "#{prop}_label" }.freeze
      end

      define_singleton_method :generic_properties do
        (properties.reject { |_k, v| v.class_name.nil? ? false : v.class_name.to_s.include?('ControlledVocabularies') }.keys - initial_properties)
      end
    end
  end
end
