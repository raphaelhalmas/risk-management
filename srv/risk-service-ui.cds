using RiskService from './risk-service';

annotate RiskService.Risk with {
	title						@title: 'Title';
	bp							@title: 'Business Partner';
	priority    		@title: 'Priority';
	description			@title: 'Description';
	mitigation			@title: 'Mitigation';
	impact					@title: 'Impact';
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

annotate RiskService.BusinessPartner with {
	ID				@title: 'Code';
	LastName  @title: 'Last Name';
	FirstName @title: 'First Name';
}

annotate RiskService.Risk with @(
	UI: {
		HeaderInfo: {
			TypeName: 'Risk',
			TypeNamePlural: 'Risks',
			Title: {
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
			{Value: bp_ID},
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
				{Value: bp_ID},
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

	bp @(
		Common: {
			Text: bp.LastName, TextArrangement: #TextOnly,
			ValueList: {
				Label: 'Business Partners',
				CollectionPath: 'BusinessPartner',
				Parameters: [
					{ $Type: 'Common.ValueListParameterInOut',
						LocalDataProperty: bp_ID,
						ValueListProperty: 'ID'
					},
					{ $Type: 'Common.ValueListParameterDisplayOnly',
						ValueListProperty: 'LastName'
					},
					{ $Type: 'Common.ValueListParameterDisplayOnly',
						ValueListProperty: 'FirstName'
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
			Title: {
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

annotate RiskService.BusinessPartner with @(
	UI: {
		HeaderInfo: {
			TypeName: 'Business Partner',
			TypeNamePlural: 'Business Partners',
			Title: {
				$Type : 'UI.DataField',
				Value : ID
			}
		},
		LineItem: [
			{Value: ID},
			{Value: LastName},
			{Value: FirstName}
		]
	}
) 
{

};