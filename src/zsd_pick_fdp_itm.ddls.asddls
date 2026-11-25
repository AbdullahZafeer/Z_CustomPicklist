@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'FDP Item for Picklist'
define view entity ZSD_PICK_FDP_ITM 
  as select from ZSD_PICK_I_ITM 
  association to parent ZSD_PICK_FDP_HDR as _Header on $projection.SalesOrder = _Header.SalesOrder
{
  key SalesOrder,
  key SalesOrderItem,
  
  /* Basic Item Info */
  ItemDescription,
  Plant,
  StorageLocation,
  StorageLocationName,
  Batch,
  
  /* Native Size & Grade */
  SizeCode,
  ItemSize,
  GradeCode,
  Grade,
  
  /* Delivery Status */
  DeliveryStatusCode,
  DeliveryStatus,
  
  /* Quantities & Cartons */
  @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
  OrderQuantity,
  OrderQuantityUnit,
  
  @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
  DeliveredQuantity,
  
  @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
  PendingCartons,
  
  /* SQM Math */
  PerCartonSQM,
  PendingSQM,
  TotalSQM,
  
  /* Weight */
  @Semantics.quantity.unitOfMeasure: 'ItemWeightUnit'
  ItemGrossWeight,
  ItemWeightUnit,
  
  _Header
}
