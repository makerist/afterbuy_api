module Afterbuy
  class DataFilter < OpenStruct
  end

  module Representer
    module DataFilterRepresenter #< Roar::Decorator
      include Roar::XML

      property :add_data_filter do
        self.representation_wrap = :DataFilter
        property :filter, as: :Filter do
          # include FilterRepresenter
          property :filter_name, as: :FilterName, getter: lambda {|*| "ProductID" }
          property :filter_value, as: :FilterValue, wrap: :FilterValues, getter: lambda {|*| self[:afterbuy_product_ids].join(";") }
      end


      # collection :add_filters do
      #   include Afterbuy::Representer::FilterRepresenter
      #    # self.representation_wrap = :Filter
      #   collection :add_filters do
      #     property :filter_name, as: :FilterName, getter: lambda {|*| "ProductID" }
      #     property :filter_value, as: :FilterValue, wrap: :FilterValues, getter: ->() { self[:afterbuy_product_ids].join(";") }
      #   end
      #   self.representation_wrap = :Filter
      # end
      end
    end
  end
end