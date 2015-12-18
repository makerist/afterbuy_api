module Afterbuy
  class DataFilter < OpenStruct

  end

  module Representer
    class DataFilterRepresenter < Roar::Decorator
      include Roar::XML

      property :add_data_filter do
        self.representation_wrap = :DataFilter
        property :filter, as: :Filter do
          # include FilterRepresenter
          property :filter_name, as: :FilterName, getter: lambda {|*| "ProductID" }
          property :filter_value, as: :FilterValue, wrap: :FilterValues, getter: lambda {|*| self[:afterbuy_product_ids].join(";") }
        end
      end
    end
  end
end
