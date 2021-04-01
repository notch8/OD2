# frozen_string_literal: true

module OregonDigital
  # Provide select options for the full size download allowed field
  class DownloadService < Hyrax::QaSelectService
    def initialize(_authority_name = nil)
      super('download')
    end

    def all_labels(values)
      @authority.all.select { |r| values.include?(r[:id]) }.map { |hash| hash['label'] }.reject(&:blank?)
    end

    def select_sorted_all_options
      select_all_options.sort
    end
  end
end
