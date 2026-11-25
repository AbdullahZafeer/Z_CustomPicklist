@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Delivered Qty Aggregation (Status C)'
define view entity ZSD_PICK_I_DELIV_QTY 
  as select from I_DeliveryDocumentItem
{
  key ReferenceSDDocument     as SalesOrder,
  key ReferenceSDDocumentItem as SalesOrderItem,
  
  @Semantics.quantity.unitOfMeasure: 'BaseUnit'
  sum(ActualDeliveryQuantity) as DeliveredQuantity,
  
  BaseUnit
} 
where GoodsMovementStatus = 'C' /* Only count Goods Issued quantities */
group by 
  ReferenceSDDocument, 
  ReferenceSDDocumentItem,
  BaseUnit
