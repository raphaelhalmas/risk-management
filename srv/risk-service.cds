using { risksmanagement } from '../db/schema';

@path: 'service/risk'
service RiskService {
  entity Risk as projection on risksmanagement.Risk;
    annotate Risk with @odata.draft.enabled;
  entity Mitigation as projection on risksmanagement.Mitigation;
    annotate Mitigation with @odata.draft.enabled;
}