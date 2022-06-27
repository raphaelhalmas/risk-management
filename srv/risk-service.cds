using { riskmanagement } from '../db/schema';

@path: 'service/risk'
service RiskService {
  entity Risk as projection on riskmanagement.Risk;
    annotate Risk with @odata.draft.enabled;
  entity Mitigation as projection on riskmanagement.Mitigation;
    annotate Mitigation with @odata.draft.enabled;
}