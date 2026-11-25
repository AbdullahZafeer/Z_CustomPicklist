//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'Picklist Item Data'
//define view entity ZSD_PICK_I_ITM 
//  as select from I_SalesOrderItem as Item
//  
//  association to parent ZSD_PICK_I_HDR as _Header 
//    on $projection.SalesOrder = _Header.SalesOrder
//    
//  -- Delivered Quantity Aggregation
//  association [0..1] to ZSD_PICK_I_DELIV_QTY as _DelivQty 
//    on  $projection.SalesOrder = _DelivQty.SalesOrder
//    and $projection.SalesOrderItem = _DelivQty.SalesOrderItem
//    
//  -- Item Delivery Status Text
//  association [0..1] to I_DeliveryStatusText as _DeliveryStatusText 
//    on  Item.DeliveryStatus = _DeliveryStatusText.DeliveryStatus
//    and _DeliveryStatusText.Language = $session.system_language
//    
//  -- Storage Location Name
//  association [0..1] to I_StorageLocation as _SLoc
//    on  Item.Plant = _SLoc.Plant
//    and Item.StorageLocation = _SLoc.StorageLocation
//
//  -- Grade (Material Pricing Group Text)
//  association [0..1] to I_MaterialPricingGroupText as _GradeText
//    on  Item.MaterialPricingGroup = _GradeText.MaterialPricingGroup
//    and _GradeText.Language = $session.system_language
//
//  --  Size (Additional Material Group 1 Text)
//  association [0..1] to I_AdditionalMaterialGroup1Text as _SizeText
//    on  Item.AdditionalMaterialGroup1 = _SizeText.AdditionalMaterialGroup1
//    and _SizeText.Language = $session.system_language
//
//{
//  key Item.SalesOrder,
//  key Item.SalesOrderItem,
//
//      
//      Item.SalesOrderItemText as ItemDescription,
//      Item.Plant,
//      Item.StorageLocation,
//      _SLoc.StorageLocationName,
//      Item.Batch,
//      
//      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
//      Item.OrderQuantity,
//      Item.OrderQuantityUnit,
//      
//      @Semantics.quantity.unitOfMeasure: 'ItemWeightUnit'
//      Item.ItemGrossWeight,
//      Item.ItemWeightUnit,
//
//      
//      Item.AdditionalMaterialGroup1   as SizeCode,
//      _SizeText.AdditionalMaterialGroup1Name as ItemSize,
//      
//      Item.MaterialPricingGroup       as GradeCode,
//      _GradeText.MaterialPricingGroupName as Grade,
//
//      
//      Item.DeliveryStatus             as DeliveryStatusCode,
//      _DeliveryStatusText.DeliveryStatusDescription as DeliveryStatus,
//
//     
//      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
//      cast( coalesce( _DelivQty.DeliveredQuantity, 0 ) as abap.quan(13,3) ) as DeliveredQuantity,
//      
//
//      /* 1. Pending Cartons = Order Qty - Delivered Qty */
//      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
//      cast( ( Item.OrderQuantity - coalesce( _DelivQty.DeliveredQuantity, 0 ) ) as abap.quan(13,3) ) as PendingCartons,
//
//      /* 2. Per Carton SQM (Using built-in division function to strictly prevent float upgrade) */
//      division( cast(Item.TargetToBaseQuantityNmrtr as abap.dec(13,3)), 
//                cast(Item.TargetToBaseQuantityDnmntr as abap.dec(13,3)), 3 ) as PerCartonSQM,
//
//      /* 3. Pending SQM = Pending Cartons * Per Carton SQM */
//      cast( 
//        cast( ( Item.OrderQuantity - coalesce( _DelivQty.DeliveredQuantity, 0 ) ) as abap.dec(13,3) ) * 
//        division( cast(Item.TargetToBaseQuantityNmrtr as abap.dec(13,3)), cast(Item.TargetToBaseQuantityDnmntr as abap.dec(13,3)), 3 ) 
//      as abap.dec(13,3) ) as PendingSQM,
//
//      /* 4. Total SQM = Order Qty * Per Carton SQM */
//      cast( 
//        cast( Item.OrderQuantity as abap.dec(13,3) ) * 
//        division( cast(Item.TargetToBaseQuantityNmrtr as abap.dec(13,3)), cast(Item.TargetToBaseQuantityDnmntr as abap.dec(13,3)), 3 ) 
//      as abap.dec(13,3) ) as TotalSQM,
// 
//      _Header,
//      _SLoc,
//      _DelivQty,
//      _DeliveryStatusText,
//      _GradeText,
//      _SizeText
//}

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Picklist Item Data'
define view entity ZSD_PICK_I_ITM 
  as select from I_SalesOrderItem as Item
  
  association to parent ZSD_PICK_I_HDR as _Header 
    on $projection.SalesOrder = _Header.SalesOrder
    
  -- Delivered Quantity Aggregation
  association [0..1] to ZSD_PICK_I_DELIV_QTY as _DelivQty 
    on  $projection.SalesOrder = _DelivQty.SalesOrder
    and $projection.SalesOrderItem = _DelivQty.SalesOrderItem
    
  -- Item Delivery Status Text
  association [0..1] to I_DeliveryStatusText as _DeliveryStatusText 
    on  Item.DeliveryStatus = _DeliveryStatusText.DeliveryStatus
    and _DeliveryStatusText.Language = $session.system_language
    
  -- Storage Location Name
  association [0..1] to I_StorageLocation as _SLoc
    on  Item.Plant = _SLoc.Plant
    and Item.StorageLocation = _SLoc.StorageLocation

  -- Grade (Material Pricing Group Text)
  association [0..1] to I_MaterialPricingGroupText as _GradeText
    on  Item.MaterialPricingGroup = _GradeText.MaterialPricingGroup
    and _GradeText.Language = $session.system_language

  -- Size (Additional Material Group 1 Text)
  association [0..1] to I_AdditionalMaterialGroup1Text as _SizeText
    on  Item.AdditionalMaterialGroup1 = _SizeText.AdditionalMaterialGroup1
    and _SizeText.Language = $session.system_language

  -- Product Master Data (For Gross Weight)
  association [0..1] to I_Product as _Product
    on  Item.Material = _Product.Product

{
  key Item.SalesOrder,
  key Item.SalesOrderItem,

      Item.Material,
      Item.SalesOrderItemText as ItemDescription,
      Item.Plant,
      Item.StorageLocation,
      _SLoc.StorageLocationName,
      Item.Batch,
      
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      Item.OrderQuantity,
      Item.OrderQuantityUnit,
      
      /* Calculated ItemGrossWeight = Product.GrossWeight * PendingSQM */
      @Semantics.quantity.unitOfMeasure: 'ItemWeightUnit'
      cast( 
        cast( coalesce( _Product.GrossWeight, 0 ) as abap.dec(13,3) ) * 
        cast( 
          cast( ( Item.OrderQuantity - coalesce( _DelivQty.DeliveredQuantity, 0 ) ) as abap.dec(13,3) ) * 
          division( cast(Item.TargetToBaseQuantityNmrtr as abap.dec(13,3)), cast(Item.TargetToBaseQuantityDnmntr as abap.dec(13,3)), 3 ) 
        as abap.dec(13,3) )
      as abap.quan(13,3) ) as ItemGrossWeight,
      
      _Product.WeightUnit as ItemWeightUnit,

      Item.AdditionalMaterialGroup1   as SizeCode,
      _SizeText.AdditionalMaterialGroup1Name as ItemSize,
      
      Item.MaterialPricingGroup       as GradeCode,
      _GradeText.MaterialPricingGroupName as Grade,

      Item.DeliveryStatus             as DeliveryStatusCode,
      _DeliveryStatusText.DeliveryStatusDescription as DeliveryStatus,
     
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      cast( coalesce( _DelivQty.DeliveredQuantity, 0 ) as abap.quan(13,3) ) as DeliveredQuantity,
      
      /* 1. Pending Cartons = Order Qty - Delivered Qty */
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      cast( ( Item.OrderQuantity - coalesce( _DelivQty.DeliveredQuantity, 0 ) ) as abap.quan(13,3) ) as PendingCartons,

      /* 2. Per Carton SQM (Using built-in division function to strictly prevent float upgrade) */
      division( cast(Item.TargetToBaseQuantityNmrtr as abap.dec(13,3)), 
                cast(Item.TargetToBaseQuantityDnmntr as abap.dec(13,3)), 3 ) as PerCartonSQM,

      /* 3. Pending SQM = Pending Cartons * Per Carton SQM */
      cast( 
        cast( ( Item.OrderQuantity - coalesce( _DelivQty.DeliveredQuantity, 0 ) ) as abap.dec(13,3) ) * 
        division( cast(Item.TargetToBaseQuantityNmrtr as abap.dec(13,3)), cast(Item.TargetToBaseQuantityDnmntr as abap.dec(13,3)), 3 ) 
      as abap.dec(13,3) ) as PendingSQM,

      /* 4. Total SQM = Order Qty * Per Carton SQM */
      cast( 
        cast( Item.OrderQuantity as abap.dec(13,3) ) * 
        division( cast(Item.TargetToBaseQuantityNmrtr as abap.dec(13,3)), cast(Item.TargetToBaseQuantityDnmntr as abap.dec(13,3)), 3 ) 
      as abap.dec(13,3) ) as TotalSQM,
 
      _Header,
      _SLoc,
      _DelivQty,
      _DeliveryStatusText,
      _GradeText,
      _SizeText,
      _Product
}
