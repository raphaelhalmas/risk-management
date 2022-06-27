namespace riskmanagement;
using { managed } from '@sap/cds/common';

  entity Risk : managed {
    key ID : UUID  @(Core.Computed : true);
    title : String(100);
    priority : String(5);
    description : String;
    mitigation : Association to Mitigation;
    impact : Integer;
    criticality : Integer;
  }

  entity Mitigation : managed {
    key ID : UUID  @(Core.Computed : true);
    description : String;
    owner : String;
    timeline : String;
    risks : Association to many Risk on risks.mitigation = $self;
  }