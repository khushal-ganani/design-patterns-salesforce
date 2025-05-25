List<Id> accountIds = new List<Id>();
for (Account acc : [SELECT Id FROM Account LIMIT 10]) {
    accountIds.add(acc.Id);
}
AccountScoreService_Good service = new AccountScoreService_Good(accountIds);

Decimal opportunityScore = service.getOpportunityScore(accountIds[0]);
Decimal activityScore = service.getActivityScore(accountIds[0]);