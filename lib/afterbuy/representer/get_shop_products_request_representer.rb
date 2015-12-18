module Afterbuy
  class GetShopProductsRequest < OpenStruct
  end

  module Representer
    class GetShopProductsRequestRepresenter < RequestRepresenter
      collection :products, as: :Product, wrap: :DataFilter, extend: DataFilterRepresenter, class: DataFilter

      # property :data_filter, as: :DataFilter, class: DataFilter do
      #   include DataFilterRepresenter

      # include Roar::XML
      # collection :data_filters, as: :DataFilter, wrap: :DataFilter, extend: DataFilterRepresenter
      # collection :add_filters1 do
      #   self.representation_wrap  = :DataFilter

      #   collection :add_filters do
      #     # include Afterbuy::Representer::FilterRepresenter
      #      # self.representation_wrap = :Filter
      #       collection :add_filters do
      #         property :filter_name, as: :FilterName, getter: lambda {|*| "ProductID" }
      #         property :filter_value, as: :FilterValue, wrap: :FilterValues, getter: ->() { self[:afterbuy_product_ids].join(";") }
      #       end
      #     self.representation_wrap = :Filter
      #   end
      # end


      # collection :add_filters do
      #   self.representation_wrap  = :DataFilter
      #   include FilterRepresenter
      #   self.representation_wrap = :Filter
      # end


      # collection :data_filter, class: DataFilter do
      #   self.representation_wrap = :DataFilter
      #   property :mimi
      # end

      # nested :data_filter, as: :DataFilter do
      #   nested :filter, as: :Filter do
      #     property :filter_name, as: :FilterName, getter: lambda {|*| "ProductID" }
      #     property :filter_value, as: :FilterValue, wrap: :FilterValues, getter: lambda {|*| self[:afterbuy_product_ids].join(";") }
      #   end
      # end

    end
    # module Filters
    #   include Roar::XML

    #   self.representation_wrap  = :DataFilter
    #   include FilterRepresenter
    #   self.representation_wrap = :Filter
    # end
  end
end
# <DataFilter>
#     <Filter>
#       <FilterName>ProductID</FilterName>
#       <FilterValues>
#         <FilterValue>1234</FilterValue>
#       </FilterValues>
#     </Filter>
#   </DataFilter>

# <AddCatalogs>
      #   <UpdateAction>1</UpdateAction>  <======= (this is the intruder here)
      #   <AddCatalog>
      #     <CatalogID>1</CatalogID>
      #     <CatalogName>First Category</CatalogName>
      #   </AddCatalog>
      #   <AddCatalog>
      #     <CatalogID>2</CatalogID>
      #     <CatalogName>Second Category</CatalogName>
      #   </AddCatalog>
      # </AddCatalogs>
      # property :add_catalogs do
      #   self.representation_wrap = :AddCatalogs
      #   property :update_action, as: :UpdateAction
      #   collection :add_catalogs do
      #     include CatalogRepresenter
      #     self.representation_wrap = :AddCatalog
      #   end
      # end