List<Id> accountIds = new List<Id>();
for (Account acc : [SELECT Id FROM Account LIMIT 10]) {
    accountIds.add(acc.Id);
}
AccountScoreService_Bad service = new AccountScoreService_Bad();

service.accountIds = accountIds;
service.calculateOpportunityScore();
service.calculateActivityScore();

Decimal opportunityScore = service.opportunityScore.get(accountIds[0]);
Decimal activityScore = service.activityScore.get(accountIds[0]);