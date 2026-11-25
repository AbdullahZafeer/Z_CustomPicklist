//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'Picklist Header Projection'
//@Metadata.allowExtensions: true
//define root view entity ZSD_PICK_C_HDR 
//  provider contract transactional_query
//  as projection on ZSD_PICK_I_HDR 
//{
//  @Consumption.valueHelpDefinition: [{ entity: { name: 'I_SalesOrderStdVH', element: 'SalesOrder' } }]
//  key SalesOrder,
//  
//  @Consumption.valueHelpDefinition: [{ entity: { name: 'I_Customer_VH', element: 'Customer' } }]
//  SoldToParty,
//  
//  @EndUserText.label: 'Ship to Party'
//  @Consumption.valueHelpDefinition: [{ entity: { name: 'I_Customer_VH', element: 'Customer' } }]
//  ShipToParty,
//  
//  CustomerName,
//  CustomerReference,
//  CusRefDate,
//  
//  @Consumption.filter.selectionType: #INTERVAL
//  CreationDate,
//  DocumentDate,
//  
//  MarketingCode,
//  SalesOrderStatusCode,
//  SalesOrderStatus,
//  ApprovalStatusCode,
//  ApprovalStatus,
//  DeliveryBlockCode,
//  DeliveryBlock,
//  CreditManagementStatusCode,
//  
//  /* Associations */
//  _Item : redirected to composition child ZSD_PICK_C_ITM
//}

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Picklist Header Projection'
@Metadata.allowExtensions: true
define root view entity ZSD_PICK_C_HDR 
  provider contract transactional_query
  as projection on ZSD_PICK_I_HDR 
{
  @Consumption.valueHelpDefinition: [{ entity: { name: 'I_SalesOrderStdVH', element: 'SalesOrder' } }]
  key SalesOrder,
  
  @Consumption.valueHelpDefinition: [{ entity: { name: 'I_Customer_VH', element: 'Customer' } }]
  SoldToParty,
  
  @EndUserText.label: 'Ship to Party'
  @Consumption.valueHelpDefinition: [{ entity: { name: 'I_Customer_VH', element: 'Customer' } }]
  ShipToParty,
  
  CustomerName,
  ShipToName,
  SoldToContact,
  ShiptoContact,
  
  CustomerReference,
  CusRefDate,
  
  
  CreationDate,
  DocumentDate,
  
  MarketingCode,
  SalesOrderStatusCode,
  SalesOrderStatus,
  ApprovalStatusCode,
  ApprovalStatus,
  DeliveryBlockCode,
  DeliveryBlock,
  Del_Block,
  
  CreditManagementStatusCode,
  CreditManagementStatus,
  Credit,
  
  CustomerAddress,
  ShipToAddress,
  Remarks,
  
  /* Associations */
  _Item : redirected to composition child ZSD_PICK_C_ITM
}
