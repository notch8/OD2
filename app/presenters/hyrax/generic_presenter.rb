# Generated via
#  `rails generate hyrax:work Generic`
module Hyrax
  class GenericPresenter < Hyrax::WorkShowPresenter
    delegate *OregonDigital::GenericMetadata::PROPERTIES.map(&:to_sym), to: :solr_document 
  end
end
