// class clsRelatedProductModal {
//   clsRelatedProductModal({
//     this.productTotalCollectible,
//     this.productTotalNew,
//     this.productTotalRefurbished,
//     this.productTotalUsed,
//     this.productActive,
//     this.productAdult,
//     this.productAmazon,
//     this.productBindingStatus,
//     this.productBindingType,
//     this.productBrand,
//     this.productCategories,
//     this.productCategoryIdFullpath,
//     this.productCategoryNameFullpath,
//     this.productComputedListprice,
//     this.productCreated,
//     this.productDescription,
//     this.productEan,
//     this.productEffectiveWeight,
//     this.productFeatures,
//     this.productFulfilled,
//     this.productFullCategoryName,
//     this.productGroup,
//     this.productHeight,
//     this.productId,
//     this.productImages,
//     this.productIsAddon,
//     this.productIsDigital,
//     this.productIsPreorder,
//     this.productIsRestricted,
//     this.productLabel,
//     this.productLastSync,
//     this.productLength,
//     this.productListprice,
//     this.productManufacturer,
//     this.productModel,
//     this.productMpn,
//     this.productName,
//     this.productOfferListingPrice,
//     this.productOfferListingPriceF,
//     this.productOfferSummary,
//     this.productPrice,
//     this.productPriceDomesticShipping,
//     this.productPriceInternational,
//     this.productPriceInternationalSeaShipping,
//     this.productPriceLocal,
//     this.productPriceMargin,
//     this.productPriceSale,
//     this.productPriceTotal,
//     this.productPrime,
//     this.productRating,
//     this.productRatingSync,
//     this.productRejectComment,
//     this.productRelated,
//     this.productReviewCount,
//     this.productSrp,
//     this.productStudio,
//     this.productThumbnailImages,
//     this.productUpc,
//     this.productUpdated,
//     this.productUrl,
//     this.productVariationType,
//     this.productWeight,
//     this.productWidth,
//     this.productAttributes,
//     this.productIsSlowshipping,
//     this.productKeepaLastSync,
//     this.productReviewUrl,
//     this.productTypeName,
//     this.productDiscount,
//     this.productListingPrice,
//     this.productListingPriceF,
//     this.productParentAmazon,
//     this.productReleaseDate,
//     this.productVariations,
//     this.productNoApiData,
//     this.productZincioLastSync,
//   });
//
//   String? productTotalCollectible;
//   String? productTotalNew;
//   String? productTotalRefurbished;
//   String? productTotalUsed;
//   String? productActive;
//   String? productAdult;
//   String? productAmazon;
//   String? productBindingStatus;
//   String? productBindingType;
//   String? productBrand;
//   List<String>? productCategories;
//   String? productCategoryIdFullpath;
//   String? productCategoryNameFullpath;
//   String? productComputedListprice;
//   String? productCreated;
//   String? productDescription;
//   String? productEan;
//   String? productEffectiveWeight;
//   List<String>? productFeatures;
//   String? productFulfilled;
//   String? productFullCategoryName;
//   String? productGroup;
//   String? productHeight;
//   String? productId;
//   List<String>? productImages;
//   String? productIsAddon;
//   String? productIsDigital;
//   String? productIsPreorder;
//   String? productIsRestricted;
//   String? productLabel;
//   String? productLastSync;
//   String? productLength;
//   String? productListprice;
//   String? productManufacturer;
//   String? productModel;
//   String? productMpn;
//   String? productName;
//   String? productOfferListingPrice;
//   String? productOfferListingPriceF;
//   String? productOfferSummary;
//   String? productPrice;
//   String? productPriceDomesticShipping;
//   String? productPriceInternational;
//   String? productPriceInternationalSeaShipping;
//   String? productPriceLocal;
//   String? productPriceMargin;
//   String? productPriceSale;
//   String? productPriceTotal;
//   String? productPrime;
//   String? productRating;
//   String? productRatingSync;
//   String? productRejectComment;
//   List<String>? productRelated;
//   String? productReviewCount;
//   String? productSrp;
//   String? productStudio;
//   List<String>? productThumbnailImages;
//   String? productUpc;
//   String? productUpdated;
//   String? productUrl;
//   String? productVariationType;
//   String? productWeight;
//   String? productWidth;
//   dynamic productAttributes;
//   String? productIsSlowshipping;
//   String? productKeepaLastSync;
//   String? productReviewUrl;
//   String? productTypeName;
//   String? productDiscount;
//   String? productListingPrice;
//   String? productListingPriceF;
//   String? productParentAmazon;
//   String? productReleaseDate;
//   dynamic? productVariations;
//   String? productNoApiData;
//   String? productZincioLastSync;
//
//   factory clsRelatedProductModal.fromJson(Map<String, dynamic> json) =>
//       clsRelatedProductModal(
//           productTotalCollectible: json["product_TotalCollectible"],
//           productTotalNew: json["product_TotalNew"],
//           productTotalRefurbished: json["product_TotalRefurbished"] == null ? null : json["product_TotalRefurbished"],
//           productTotalUsed: json["product_TotalUsed"],
//           productActive: json["product_active"],
//           productAdult: json["product_adult"],
//           productAmazon: json["product_amazon"],
//           productBindingStatus: json["product_binding_status"] == null ? null : json["product_binding_status"],
//           productBindingType: json["product_binding_type"] == null ? null : json["product_binding_type"],
//           productBrand: json["product_brand"],
//           productCategories: List<String>.from(json["product_categories"].map((x) => x)),
//           productCategoryIdFullpath: json["product_category_id_fullpath"],
//           productCategoryNameFullpath: json["product_category_name_fullpath"],
//           productComputedListprice: json["product_computed_listprice"] == null ? null : json["product_computed_listprice"],
//           productCreated: json["product_created"],
//           productDescription: json["product_description"],
//           productEan: json["product_ean"],
//           productEffectiveWeight: json["product_effective_weight"],
//           productFeatures: List<String>.from(json["product_features"].map((x) => x)),
//           productFulfilled: json["product_fulfilled"],
//           productFullCategoryName: json["product_full_category_name"],
//           productGroup: json["product_group"],
//           productHeight: json["product_height"],
//           productId: json["product_id"],
//           productImages: List<String>.from(json["product_images"].map((x) => x)),
//           productIsAddon: json["product_is_addon"],
//           productIsDigital: json["product_is_digital"],
//           productIsPreorder: json["product_is_preorder"],
//           productIsRestricted: json["product_is_restricted"],
//           productLabel: json["product_label"] == null ? null : json["product_label"],
//           productLastSync: json["product_last_sync"],
//           productLength: json["product_length"],
//           productListprice: json["product_listprice"] == null ? null : json["product_listprice"],
//           productManufacturer: json["product_manufacturer"],
//           productModel: json["product_model"] == null ? null : json["product_model"],
//           productMpn: json["product_mpn"] == null ? null : json["product_mpn"],
//           productName: json["product_name"],
//           productOfferListingPrice: json["product_offerListingPrice"] == null ? null : json["product_offerListingPrice"],
//           productOfferListingPriceF: json["product_offerListingPriceF"] == null ? null : json["product_offerListingPriceF"],
//           productOfferSummary: json["product_offer_summary"] == null ? null : json["product_offer_summary"],
//           productPrice: json["product_price"],
//           productPriceDomesticShipping: json["product_price_domestic_shipping"] == null ? null : json["product_price_domestic_shipping"],
//           productPriceInternational: json["product_price_international"],
//           productPriceInternationalSeaShipping: json["product_price_international_sea_shipping"],
//           productPriceLocal: json["product_price_local"],
//           productPriceMargin: json["product_price_margin"],
//           productPriceSale: json["product_price_sale"] == null ? null : json["product_price_sale"],
//           productPriceTotal: json["product_price_total"],
//           productPrime: json["product_prime"],
//           productRating: json["product_rating"] == null ? null : json["product_rating"],
//           productRatingSync: json["product_rating_sync"] == null ? null : json["product_rating_sync"],
//           productRejectComment: json["product_reject_comment"],
//           productRelated: json["product_related"] == null ? null : List<String>.from(json["product_related"].map((x) => x)),
//           productReviewCount: json["product_review_count"] == null ? null : json["product_review_count"],
//           productSrp: json["product_srp"],
//           productStudio: json["product_studio"] == null ? null : json["product_studio"],
//           productThumbnailImages: List<String>.from(json["product_thumbnail_images"].map((x) => x)),
//           productUpc: json["product_upc"],
//           productUpdated: json["product_updated"],
//           productUrl: json["product_url"],
//           productVariationType: json["product_variation_type"],
//           productWeight: json["product_weight"],
//           productWidth: json["product_width"],
//           productAttributes: json["product_attributes"] == null ? null : json["product_attributes"],
//           productIsSlowshipping: json["product_is_slowshipping"] == null ? null : json["product_is_slowshipping"],
//           productKeepaLastSync: json["product_keepa_last_sync"] == null ? null : json["product_keepa_last_sync"],
//           productReviewUrl: json["product_review_url"] == null ? null : json["product_review_url"],
//           productTypeName: json["product_type_name"] == null ? null : json["product_type_name"],
//           productDiscount: json["product_discount"] == null ? null : json["product_discount"],
//           productListingPrice: json["product_listingPrice"] == null ? null : json["product_listingPrice"],
//           productListingPriceF: json["product_listingPriceF"] == null ? null : json["product_listingPriceF"],
//           productParentAmazon: json["product_parent_amazon"] == null ? null : json["product_parent_amazon"],
//           productReleaseDate: json["product_release_date"] == null ? null : json["product_release_date"],
//           productVariations: json["product_variations"] == null ? null : json["product_variations"],
//           productNoApiData: json["product_no_api_data"] == null ? null : json["product_no_api_data"],
//           productZincioLastSync: json["product_zincio_last_sync"] == null ? null : json["product_zincio_last_sync"]
//       );
//
// }