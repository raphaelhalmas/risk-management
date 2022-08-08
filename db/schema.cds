namespace riskmanagement;

using { managed } from '@sap/cds/common';
using { API_BUSINESS_PARTNER as BusinessPartnerAPI } from '../srv/external/API_BUSINESS_PARTNER.csn';

entity Risk : managed {
  key ID              : UUID @(Core.Computed : true);
      title           : String(100);
      bp              : Association to BusinessPartner;
      priority        : String(5);
      mitigation      : Association to Mitigation;
      description     : String;
      impact          : Integer;
      criticality     : Integer;
}

entity Mitigation : managed {
  key ID          : UUID @(Core.Computed : true);
      description : String;
      owner       : String;
      timeline    : String;
      risks       : Association to many Risk
                      on risks.mitigation = $self;
}

entity BusinessPartner as projection on BusinessPartnerAPI.A_BusinessPartner {
  key BusinessPartner as ID,
      LastName,
      FirstName
}
