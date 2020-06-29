# frozen_string_literal:true

# Facet helper methods
module OregonDigital::FacetHelperBehavior
  # OVERRIDE FROM BLACKLIGHT FACET HELPER BEHAVIOR
  def render_facet_item(facet_field, item)
    if facet_in_params?(facet_field, item.value)
      render_selected_facet_value(facet_field, item)
    else
      render_facet_value(facet_field, item) unless user_collection?(facet_field, item.value)
    end
  end

  def user_collection?(facet_field, item_value)
    facet_field == 'member_of_collections_ssim' && Collection.where(title: item_value).first.collection_type.machine_id == 'user_collection'
  end
end
