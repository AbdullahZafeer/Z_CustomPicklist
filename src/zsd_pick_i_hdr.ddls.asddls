//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'Picklist Header (Sales Order)'
//define root view entity ZSD_PICK_I_HDR 
//  as select from I_SalesOrder as Header
//  
// 
//  left outer join I_SalesOrderPartner as _SoldTo 
//    on  Header.SalesOrder = _SoldTo.SalesOrder 
//    and _SoldTo.PartnerFunction = 'AG'
//    
//  left outer join I_Customer as _SoldToCustomer 
//    on _SoldTo.Customer = _SoldToCustomer.Customer
//
// 
//  left outer join I_OrganizationAddress as _SoldToAddr 
//    on _SoldToCustomer.AddressID = _SoldToAddr.AddressID
//  left outer join I_CountryText as _SoldToCountryText
//    on  _SoldToAddr.Country = _SoldToCountryText.Country
//    and _SoldToCountryText.Language = $session.system_language
//  left outer join I_RegionText as _SoldToRegionText
//    on  _SoldToAddr.Country = _SoldToRegionText.Country
//    and _SoldToAddr.Region  = _SoldToRegionText.Region
//    and _SoldToRegionText.Language = $session.system_language
//
//  left outer join I_SalesOrderPartner as _ShipTo 
//    on  Header.SalesOrder = _ShipTo.SalesOrder 
//    and _ShipTo.PartnerFunction = 'WE'
//    
//  left outer join I_Customer as _ShipToCustomer 
//    on _ShipTo.Customer = _ShipToCustomer.Customer
//
// 
//  left outer join I_OrganizationAddress as _ShipToAddr 
//    on _ShipToCustomer.AddressID = _ShipToAddr.AddressID
//  left outer join I_CountryText as _ShipToCountryText
//    on  _ShipToAddr.Country = _ShipToCountryText.Country
//    and _ShipToCountryText.Language = $session.system_language
//  left outer join I_RegionText as _ShipToRegionText
//    on  _ShipToAddr.Country = _ShipToRegionText.Country
//    and _ShipToAddr.Region  = _ShipToRegionText.Region
//    and _ShipToRegionText.Language = $session.system_language
//                                                  
//  left outer join I_OverallDeliveryStatusText as _DeliveryStatusText 
//    on  Header.OverallDeliveryStatus = _DeliveryStatusText.OverallDeliveryStatus
//    and _DeliveryStatusText.Language = $session.system_language
//
//  left outer join I_SalesDocApprovalStatusT as _ApprovalStatusText 
//    on  Header.SalesDocApprovalStatus = _ApprovalStatusText.SalesDocApprovalStatus
//    and _ApprovalStatusText.Language = $session.system_language
//    
//  left outer join I_DeliveryBlockReasonText as _DeliveryBlockText 
//    on  Header.DeliveryBlockReason = _DeliveryBlockText.DeliveryBlockReason
//    and _DeliveryBlockText.Language = $session.system_language
//
//
//  composition [0..*] of ZSD_PICK_I_ITM as _Item
//
//{
//  key Header.SalesOrder,
//  
//
//  Header.SoldToParty,
//  _SoldToCustomer.CustomerName as CustomerName,
//  
//
//  _ShipTo.Customer as ShipToParty,
//  _ShipToCustomer.CustomerName as ShipToName,
//  Header.YY1_SD_SoldtoContact_SDH as SoldToContact,
//  
//  Header.PurchaseOrderByCustomer as CustomerReference,
//  Header.CustomerPurchaseOrderDate as CusRefDate,
//  Header.CreationDate,
//  Header.SalesOrderDate as DocumentDate,
//  
//
//  Header.YY1_SDSearchTem1_SDH as MarketingCode,
//  
//
//  Header.OverallDeliveryStatus as SalesOrderStatusCode,
////  _DeliveryStatusText.OverallDeliveryStatusDesc as SalesOrderStatus,
//  Header.YY1_SalesOrderStatus_SDH as SalesOrderStatus,
//  
//  Header.YY1_SD_ShipToContact_SDH as ShiptoContact,
//  
//  Header.YY1_SDDeliveryBlock_SDH as Del_Block,
//  Header.YY1_SDCreditMStatus_SDH as Credit, 
//  
//  Header.SalesDocApprovalStatus as ApprovalStatusCode,
//  _ApprovalStatusText.SalesDocApprovalStatusDesc as ApprovalStatus,
//  
//  Header.DeliveryBlockReason as DeliveryBlockCode,
//  _DeliveryBlockText.DeliveryBlockReasonText as DeliveryBlock,
//  
//  Header.TotalCreditCheckStatus as CreditManagementStatusCode,
//  
//  cast( 
//    concat_with_space( 
//      coalesce(_SoldToAddr.HouseNumber, ''),
//      concat_with_space( 
//        coalesce(_SoldToAddr.StreetName, ''),
//        concat_with_space( 
//          coalesce(_SoldToAddr.CityName, ''),
//          concat_with_space( 
//            coalesce(_SoldToRegionText.RegionName, ''),
//            coalesce(_SoldToCountryText.CountryName, ''),
//            1 
//          ), 
//          1 
//        ), 
//        1 
//      ), 
//      1 
//    ) 
//  as abap.char(255) ) as CustomerAddress,
//
//  cast( 
//    concat_with_space( 
//      coalesce(_ShipToAddr.HouseNumber, ''),
//      concat_with_space( 
//        coalesce(_ShipToAddr.StreetName, ''),
//        concat_with_space( 
//          coalesce(_ShipToAddr.CityName, ''),
//          concat_with_space( 
//            coalesce(_ShipToRegionText.RegionName, ''),
//            coalesce(_ShipToCountryText.CountryName, ''),
//            1 
//          ), 
//          1 
//        ), 
//        1 
//      ), 
//      1 
//    ) 
//  as abap.char(255) ) as ShipToAddress,
//  
//  cast( '' as abap.char(255) ) as Remarks,
//  Header.YY1_SDCreditMStatus_SDH as CreditManagementStatus,
//  
//  _Item
//}


@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Picklist Header (Sales Order)'
define root view entity ZSD_PICK_I_HDR 
  as select from I_SalesOrder as Header
  
  left outer join I_SalesOrderPartner as _SoldTo 
    on  Header.SalesOrder = _SoldTo.SalesOrder 
    and _SoldTo.PartnerFunction = 'AG'
    
  left outer join I_Customer as _SoldToCustomer 
    on _SoldTo.Customer = _SoldToCustomer.Customer

  left outer join I_OrganizationAddress as _SoldToAddr 
    on _SoldTo.AddressID = _SoldToAddr.AddressID
    
  left outer join I_CountryText as _SoldToCountryText
    on  _SoldToAddr.Country = _SoldToCountryText.Country
    and _SoldToCountryText.Language = $session.system_language
  left outer join I_RegionText as _SoldToRegionText
    on  _SoldToAddr.Country = _SoldToRegionText.Country
    and _SoldToAddr.Region  = _SoldToRegionText.Region
    and _SoldToRegionText.Language = $session.system_language

  left outer join I_SalesOrderPartner as _ShipTo 
    on  Header.SalesOrder = _ShipTo.SalesOrder 
    and _ShipTo.PartnerFunction = 'WE'
    
  left outer join I_Customer as _ShipToCustomer 
    on _ShipTo.Customer = _ShipToCustomer.Customer

  left outer join I_OrganizationAddress as _ShipToAddr 
    on _ShipTo.AddressID = _ShipToAddr.AddressID
  left outer join I_CountryText as _ShipToCountryText
    on  _ShipToAddr.Country = _ShipToCountryText.Country
    and _ShipToCountryText.Language = $session.system_language
  left outer join I_RegionText as _ShipToRegionText
    on  _ShipToAddr.Country = _ShipToRegionText.Country
    and _ShipToAddr.Region  = _ShipToRegionText.Region
    and _ShipToRegionText.Language = $session.system_language
                                                  
  -- Overall Total Delivery Status Text (Joined with Language = 'E')
  left outer join I_OverallTotalDeliveryStatusT as _TotalDeliveryStatusText 
    on  Header.OverallTotalDeliveryStatus = _TotalDeliveryStatusText.OverallTotalDeliveryStatus
    and _TotalDeliveryStatusText.Language = 'E'

  left outer join I_SalesDocApprovalStatusT as _ApprovalStatusText 
    on  Header.SalesDocApprovalStatus = _ApprovalStatusText.SalesDocApprovalStatus
    and _ApprovalStatusText.Language = $session.system_language
    
  left outer join I_DeliveryBlockReasonText as _DeliveryBlockText 
    on  Header.DeliveryBlockReason = _DeliveryBlockText.DeliveryBlockReason
    and _DeliveryBlockText.Language = $session.system_language

  composition [0..*] of ZSD_PICK_I_ITM as _Item

{
  key Header.SalesOrder,
  
  Header.SoldToParty,
  _SoldToCustomer.CustomerName as CustomerName,
  
  _ShipTo.Customer as ShipToParty,
  _ShipToCustomer.CustomerName as ShipToName,
  _SoldTo.InternationalMobilePhoneNumber as SoldToContact,
  
  Header.PurchaseOrderByCustomer as CustomerReference,
  Header.CustomerPurchaseOrderDate as CusRefDate,
  Header.CreationDate,
  Header.SalesOrderDate as DocumentDate,
  
  Header.YY1_SDSearchTem1_SDH as MarketingCode,
  
  /* Updated Status Code and Description from I_OverallTotalDeliveryStatusT */
  Header.OverallTotalDeliveryStatus as SalesOrderStatusCode,
  _TotalDeliveryStatusText.OverallTotalDeliveryStatusDesc as SalesOrderStatus,
  
  _ShipTo.InternationalMobilePhoneNumber as ShiptoContact,
  
  Header.YY1_SDDeliveryBlock_SDH as Del_Block,
  Header.YY1_SDCreditMStatus_SDH as Credit, 
  
  Header.SalesDocApprovalStatus as ApprovalStatusCode,
  _ApprovalStatusText.SalesDocApprovalStatusDesc as ApprovalStatus,
  
  Header.DeliveryBlockReason as DeliveryBlockCode,
  _DeliveryBlockText.DeliveryBlockReasonText as DeliveryBlock,
  
  Header.TotalCreditCheckStatus as CreditManagementStatusCode,
  
 cast( 
    concat_with_space( 
      coalesce(_SoldToAddr.StreetName, ''),
      concat_with_space( 
        coalesce(_SoldToAddr.CityName, ''), 
        coalesce(_SoldToAddr.PostalCode, ''), 
        1 
      ),
      1 
    ) 
  as abap.char(255) ) as CustomerAddress,

  cast( 
    concat_with_space( 
      coalesce(_ShipToAddr.StreetName, ''),
      concat_with_space( 
        coalesce(_ShipToAddr.CityName, ''), 
        coalesce(_ShipToAddr.PostalCode, ''), 
        1 
      ),
      1 
    ) 
  as abap.char(255) ) as ShipToAddress,
  
  cast( '' as abap.char(255) ) as Remarks,
  Header.YY1_SDCreditMStatus_SDH as CreditManagementStatus,
  
  _Item
}
