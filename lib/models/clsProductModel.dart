// ignore_for_file: camel_case_types, non_constant_identifier_names, file_names

class clsProductModel {
  clsProductModel({
    this.productTotalCollectible,
    this.productTotalNew,
    this.productTotalRefurbished,
    this.productTotalUsed,
    this.productActive,
    this.productAdult,
    this.productAmazon,
    this.productBindingStatus,
    this.productBindingType,
    this.productBrand,
    this.productCategories,
    this.productCategoryIdFullpath,
    this.productCategoryNameFullpath,
    this.productComputedListprice,
    this.productCreated,
    this.productDescription,
    this.productEan,
    this.productEffectiveWeight,
    this.productFeatures,
    this.productFulfilled,
    this.productFullCategoryName,
    this.productGroup,
    this.productHeight,
    this.productId,
    this.productImages,
    this.productIsAddon,
    this.productIsDigital,
    this.productIsPreorder,
    this.productIsRestricted,
    this.productLabel,
    this.productLastSync,
    this.productLength,
    this.productListprice,
    this.productManufacturer,
    this.productModel,
    this.productMpn,
    this.productName,
    this.productOfferListingPrice,
    this.productOfferListingPriceF,
    this.productOfferSummary,
    this.productPrice,
    this.productPriceDomesticShipping,
    this.productPriceInternational,
    this.productPriceInternationalSeaShipping,
    this.productPriceLocal,
    this.productPriceMargin,
    this.productPriceSale,
    this.productPriceTotal,
    this.productPrime,
    this.productRating,
    this.product_rating_unknownfield_s,
    this.productRatingSync,
    this.productRejectComment,
    this.productRelated,
    this.productReviewCount,
    this.productSrp,
    this.productStudio,
    this.productThumbnailImages,
    this.productUpc,
    this.productUpdated,
    this.productUrl,
    this.productVariationType,
    this.productWeight,
    this.productWidth,
    this.productAttributes,
    this.productIsSlowshipping,
    this.productKeepaLastSync,
    this.productReviewUrl,
    this.productTypeName,
    this.productDiscount,
    this.productListingPrice,
    this.productListingPriceF,
    this.productParentAmazon,
    this.productReleaseDate,
    this.productVariations,
    this.productNoApiData,
    this.productZincioLastSync,
  });

  dynamic productTotalCollectible;
  dynamic productTotalNew;
  dynamic productTotalRefurbished;
  dynamic productTotalUsed;
  dynamic productActive;
  dynamic productAdult;
  dynamic productAmazon;
  dynamic productBindingStatus;
  dynamic productBindingType;
  dynamic productBrand;
  dynamic productCategories;
  dynamic productCategoryIdFullpath;
  dynamic productCategoryNameFullpath;
  dynamic productComputedListprice;
  dynamic productCreated;
  dynamic productDescription;
  dynamic productEan;
  dynamic productEffectiveWeight;
  dynamic productFeatures;
  dynamic productFulfilled;
  dynamic productFullCategoryName;
  dynamic productGroup;
  dynamic productHeight;
  dynamic productId;
  dynamic productImages;
  dynamic productIsAddon;
  dynamic productIsDigital;
  dynamic productIsPreorder;
  dynamic productIsRestricted;
  dynamic productLabel;
  dynamic productLastSync;
  dynamic productLength;
  dynamic productListprice;
  dynamic productManufacturer;
  dynamic productModel;
  dynamic productMpn;
  dynamic productName;
  dynamic productOfferListingPrice;
  dynamic productOfferListingPriceF;
  dynamic productOfferSummary;
  dynamic productPrice;
  dynamic productPriceDomesticShipping;
  dynamic productPriceInternational;
  dynamic productPriceInternationalSeaShipping;
  dynamic productPriceLocal;
  dynamic productPriceMargin;
  dynamic productPriceSale;
  dynamic productPriceTotal;
  dynamic productPrime;
  dynamic productRating;
  dynamic product_rating_unknownfield_s;
  dynamic productRatingSync;
  dynamic productRejectComment;
  dynamic productRelated;
  dynamic productReviewCount;
  dynamic productSrp;
  dynamic productStudio;
  dynamic productThumbnailImages;
  dynamic productUpc;
  dynamic productUpdated;
  dynamic productUrl;
  dynamic productVariationType;
  dynamic productWeight;
  dynamic productWidth;
  dynamic productAttributes;
  dynamic productIsSlowshipping;
  dynamic productKeepaLastSync;
  dynamic productReviewUrl;
  dynamic productTypeName;
  dynamic productDiscount;
  dynamic productListingPrice;
  dynamic productListingPriceF;
  dynamic productParentAmazon;
  dynamic productReleaseDate;
  dynamic productVariations;
  dynamic productNoApiData;
  dynamic productZincioLastSync;

  factory clsProductModel.fromJson(Map<String, dynamic> json) =>
      clsProductModel(
          productTotalCollectible: json["product_TotalCollectible"],
          productTotalNew: json["product_TotalNew"],
          productTotalRefurbished: json["product_TotalRefurbished"],
          productTotalUsed: json["product_TotalUsed"],
          productActive: json["product_active"],
          productAdult: json["product_adult"],
          productAmazon: json["product_amazon"],
          productBindingStatus: json["product_binding_status"],
          productBindingType: json["product_binding_type"],
          productBrand: json["product_brand"],
          productCategories: json["product_categories"],
          productCategoryIdFullpath: json["product_category_id_fullpath"],
          productCategoryNameFullpath: json["product_category_name_fullpath"],
          productComputedListprice: json["product_computed_listprice"],
          productCreated: json["product_created"],
          productDescription: json["product_description"],
          productEan: json["product_ean"],
          productEffectiveWeight: json["product_effective_weight"],
          productFeatures: json["product_features"],
          productFulfilled: json["product_fulfilled"],
          productFullCategoryName: json["product_full_category_name"],
          productGroup: json["product_group"],
          productHeight: json["product_height"],
          productId: json["product_id"],
          productImages: json["product_images"],
          productIsAddon: json["product_is_addon"],
          productIsDigital: json["product_is_digital"],
          productIsPreorder: json["product_is_preorder"],
          productIsRestricted: json["product_is_restricted"],
          productLabel: json["product_label"],
          productLastSync: json["product_last_sync"],
          productLength: json["product_length"],
          productListprice: json["product_listprice"],
          productManufacturer: json["product_manufacturer"],
          productModel: json["product_model"],
          productMpn: json["product_mpn"],
          productName: json["product_name"],
          productOfferListingPrice: json["product_offerListingPrice"],
          productOfferListingPriceF: json["product_offerListingPriceF"],
          productOfferSummary: json["product_offer_summary"],
          productPrice: json["product_price"],
          productPriceDomesticShipping: json["product_price_domestic_shipping"],
          productPriceInternational: json["product_price_international"],
          productPriceInternationalSeaShipping:
              json["product_price_international_sea_shipping"],
          productPriceLocal: json["product_price_local"],
          productPriceMargin: json["product_price_margin"],
          productPriceSale: json["product_price_sale"],
          productPriceTotal: json["product_price_total"],
          productPrime: json["product_prime"],
          productRating: json["product_rating"],
          product_rating_unknownfield_s: json["product_rating_unknownfield_s"],
          productRatingSync: json["product_rating_sync"],
          productRejectComment: json["product_reject_comment"],
          productRelated: json["product_related"],
          productReviewCount: json["product_review_count"],
          productSrp: json["product_srp"],
          productStudio: json["product_studio"],
          productThumbnailImages: json["product_thumbnail_images"],
          productUpc: json["product_upc"],
          productUpdated: json["product_updated"],
          productUrl: json["product_url"],
          productVariationType: json["product_variation_type"],
          productWeight: json["product_weight"],
          productWidth: json["product_width"],
          productAttributes: json["product_attributes"],
          productIsSlowshipping: json["product_is_slowshipping"],
          productKeepaLastSync: json["product_keepa_last_sync"],
          productReviewUrl: json["product_review_url"],
          productTypeName: json["product_type_name"],
          productDiscount: json["product_discount"],
          productListingPrice: json["product_listingPrice"],
          productListingPriceF: json["product_listingPriceF"],
          productParentAmazon: json["product_parent_amazon"],
          productReleaseDate: json["product_release_date"],
          productVariations: json["product_variations"],
          productNoApiData: json["product_no_api_data"],
          productZincioLastSync: json["product_zincio_last_sync"]);
}
