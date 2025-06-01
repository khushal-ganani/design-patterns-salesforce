Opportunity opp = new Opportunity(Amount = 50000);

List<String> errors = new OpportunityValidator().validateRecord(opp);
System.debug('errors ===> ' + errors);