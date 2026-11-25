//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'Picklist Item Projection'
//@Metadata.allowExtensions: true
//define view entity ZSD_PICK_C_ITM 
//  as projection on ZSD_PICK_I_ITM 
//{
//  key SalesOrder,
//  key SalesOrderItem,
//  
//  ItemDescription,
//  Plant,
//  StorageLocation,
//  StorageLocationName,
//  Batch,
//  
//  ItemSize,
//  Grade,
//  
//  OrderQuantity,
//  OrderQuantityUnit,
//  DeliveredQuantity,
//  PendingCartons,
//  PerCartonSQM,
//  PendingSQM,
//  TotalSQM,
//  
//  ItemGrossWeight,
//  ItemWeightUnit,
//  
//  DeliveryStatusCode,
//  DeliveryStatus,
//  
//  /* Associations */
//  _Header : redirected to parent ZSD_PICK_C_HDR
//}


@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Picklist Item Projection'
@Metadata.allowExtensions: true
define view entity ZSD_PICK_C_ITM 
  as projection on ZSD_PICK_I_ITM 
{
  key SalesOrder,
  key SalesOrderItem,
  
  ItemDescription,
  
  @Consumption.valueHelpDefinition: [{ entity: { name: 'I_Plant', element: 'Plant' } }]
  Plant,
  
  @Consumption.valueHelpDefinition: [{ entity: { name: 'I_StorageLocation', element: 'StorageLocation' } }]
  StorageLocation,
  
  StorageLocationName,
  Batch,
  ItemSize,
  Grade,
  OrderQuantity,
  OrderQuantityUnit,
  DeliveredQuantity,
  PendingCartons,
  PerCartonSQM,
  PendingSQM,
  TotalSQM,
  ItemGrossWeight,
  ItemWeightUnit,
  DeliveryStatusCode,
  DeliveryStatus,
  
  /* Associations */
  _Header : redirected to parent ZSD_PICK_C_HDR
}
