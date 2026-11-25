//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'FDP Header for Picklist'
//define root view entity ZSD_PICK_FDP_HDR 
//  as select from ZSD_PICK_I_HDR 
//  composition [0..*] of ZSD_PICK_FDP_ITM as _Item
//{
//  key SalesOrder,
//  
//  /* Customer & Date Info */
//  SoldToParty,
//  CustomerName,
//  CustomerReference,
//  CusRefDate,
//  CreationDate,
//  DocumentDate,
//  MarketingCode,
//  
//  /* Form Header Statuses */
//  SalesOrderStatusCode,
//  SalesOrderStatus,
//  ApprovalStatusCode,
//  ApprovalStatus,
//  DeliveryBlockCode,
//  DeliveryBlock,
//  CreditManagementStatusCode,
// 
//  _Item
//}

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'FDP Header for Picklist'
define root view entity ZSD_PICK_FDP_HDR 
  as select from ZSD_PICK_I_HDR 
  composition [0..*] of ZSD_PICK_FDP_ITM as _Item
{
  key SalesOrder,
  
  /* Customer & Date Info */
  SoldToParty,
  CustomerName,
  SoldToContact,
  CustomerAddress,
  
  ShipToParty,
  ShipToName,
  ShiptoContact,
  ShipToAddress,
  
  CustomerReference,
  CusRefDate,
  CreationDate,
  DocumentDate,
  MarketingCode,
  
  /* Form Header Statuses & Blocks */
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
  
  /* Miscellaneous */
  Remarks,
 
  _Item
}
