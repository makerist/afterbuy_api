module Afterbuy
  class Product < OpenStruct
  end

  module Representer
    class ProductRepresenter < Roar::Decorator
      include Roar::XML

      self.representation_wrap = :Product

      property :product_ident, as: :ProductIdent do
        self.representation_wrap = :ProductIdent

        property :product_insert,    as: :ProductInsert
        property :base_product_type, as: :BaseProductType
        property :user_product_id,   as: :UserProductID
        property :product_id,        as: :ProductID
        property :anr,               as: :Anr
        property :ean,               as: :EAN
      end

      property :anr,                                    as: :Anr
      property :ean,                                    as: :EAN
      property :footer_id,                              as: :FooterID
      property :header_id,                              as: :HeaderID
      property :name,                                   as: :Name
      property :manufacturer_part_number,               as: :ManufacturerPartNumber
      property :short_description,                      as: :ShortDescription
      property :memo,                                   as: :Memo
      property :description,                            as: :Description
      property :keywords,                               as: :Keywords
      property :quantity,                               as: :Quantity
      property :auction_quantity,                       as: :AuctionQuantity
      property :stock,                                  as: :Stock
      property :discontinued,                           as: :Discontinued
      property :merge_stock,                            as: :MergeStock
      property :unit_of_quantity,                       as: :UnitOfQuantity
      property :baseprice_factor,                       as: :BasepriceFactor
      property :minimum_stock,                          as: :MinimumStock
      property :selling_price,                          as: :SellingPrice
      property :buying_price,                           as: :BuyingPrice
      property :dealer_price,                           as: :DealerPrice
      property :level,                                  as: :Level
      property :position,                               as: :Position
      property :title_replace,                          as: :TitleReplace
      property :tax_rate,                               as: :TaxRate
      property :weight,                                 as: :Weight
      property :stocklocation_1,                        as: :Stocklocation_1
      property :stocklocation_2,                        as: :Stocklocation_2
      property :stocklocation_3,                        as: :Stocklocation_3
      property :stocklocation_4,                        as: :Stocklocation_4
      property :search_alias,                           as: :SearchAlias
      property :froogle,                                as: :Froogle
      property :kelkoo,                                 as: :Kelkoo
      property :shipping_group,                         as: :ShippingGroup
      property :shop_shipping_group,                    as: :ShopShippingGroup
      property :cross_catalog_id,                       as: :CrossCatalogID
      property :free_value_1,                           as: :FreeValue1
      property :free_value_2,                           as: :FreeValue2
      property :free_value_3,                           as: :FreeValue3
      property :free_value_4,                           as: :FreeValue4
      property :free_value_5,                           as: :FreeValue5
      property :free_value_6,                           as: :FreeValue6
      property :free_value_7,                           as: :FreeValue7
      property :free_value_8,                           as: :FreeValue8
      property :free_value_9,                           as: :FreeValue9
      property :free_value_10,                          as: :FreeValue10
      property :delivery_time,                          as: :DeliveryTime
      property :image_small_url,                        as: :ImageSmallURL
      property :image_large_url,                        as: :ImageLargeURL
      property :image_name,                             as: :ImageName
      property :image_source,                           as: :ImageSource
      property :manufacturer_standard_product_id_type,  as: :ManufacturerStandardProductIDType
      property :manufacturer_standard_product_id_value, as: :ManufacturerStandardProductIDValue
      property :product_brand,                          as: :ProductBrand
      property :google_product_category,                as: :GoogleProductCategory
      property :condition,                              as: :Condition
      property :age_group,                              as: :AgeGroup
      property :gender,                                 as: :Gender
      collection :skus, as: :Sku, wrap: :Skus do
        property :update_action, as: :UpdateAction
      end
      collection :add_catalogs, as: :AddCatalog, wrap: :AddCatalogs, extend: CatalogRepresenter, class: Catalog do
        property :update_action, as: :UpdateAction
      end
      collection :add_attributes, as: :AddAttribut, wrap: :AddAttributes, extend: AttributeRepresenter, class: Attribute do
        property :update_action, as: :UpdateAction
      end
      collection :product_pictures, as: :ProductPicture, wrap: :ProductPictures, extend: ProductPictureRepresenter, class: ProductPicture
    end
  end
end
