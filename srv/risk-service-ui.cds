using RiskService from './risk-service';

annotate RiskService.Risk with {
	title       @title: 'Title';
	priority    @title: 'Priority';
	description @title: 'Description';
	mitigation  @title: 'Mitigation';
	impact      @title: 'Impact';
}

annotate RiskService.Mitigation with {
	ID @(
		UI.Hidden,
		Common: {
		Text: description
		}
	);
	description  @title: 'Description';
	owner        @title: 'Owner';
	timeline     @title: 'Timeline';
	risks        @title: 'Risks';
}

annotate RiskService.Risk with @(
	UI: {
		HeaderInfo: {
			TypeName: 'Risk',
			TypeNamePlural: 'Risks',
			Title          : {
                $Type : 'UI.DataField',
                Value : title
            },
			Description : {
				$Type: 'UI.DataField',
				Value: description
			}
		},
		SelectionFields: [priority],
		LineItem: [
			{Value: title},
			{Value: mitigation_ID},
			{
				Value: priority,
				Criticality: criticality
			},
			{
				Value: impact,
				Criticality: criticality
			}
		],
		Facets: [
			{$Type: 'UI.ReferenceFacet', Label: 'Main', Target: '@UI.FieldGroup#Main'}
		],
		FieldGroup#Main: {
			Data: [
				{Value: mitigation_ID},
				{
					Value: priority,
					Criticality: criticality
				},
				{
					Value: impact,
					Criticality: criticality
				}
			]
		}
	}
) 
{

};

annotate RiskService.Risk with {
	mitigation @(
		Common: {
			//show text, not id for mitigation in the context of risks
			Text: mitigation.description, TextArrangement: #TextOnly,
			ValueList: {
				Label: 'Mitigations',
				CollectionPath: 'Mitigation',
				Parameters: [
					{ $Type: 'Common.ValueListParameterInOut',
						LocalDataProperty: mitigation_ID,
						ValueListProperty: 'ID'
					},
					{ $Type: 'Common.ValueListParameterDisplayOnly',
						ValueListProperty: 'description'
					}
				]
			}
		}
	);
}

annotate RiskService.Mitigation with @(
	UI: {
		HeaderInfo: {
			TypeName: 'Mitigation',
			TypeNamePlural: 'Mitigations',
			Title          : {
                $Type : 'UI.DataField',
                Value : description
            }
		},
		LineItem: [
			{Value: description}
		]
	}
) 
{

};
