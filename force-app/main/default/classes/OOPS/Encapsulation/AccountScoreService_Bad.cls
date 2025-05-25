public with sharing class AccountScoreService_Bad {
    public List<Id> accountIds;
    public Map<Id, Decimal> opportunityScore;
    public Map<Id, Decimal> activityScore;

    // Private method to calculate score based on Opportunities
    public void calculateOpportunityScore() {
        List<Opportunity> relatedOpps = [
            SELECT Amount FROM Opportunity
            WHERE AccountId IN :accountIds
        ];
        for (Opportunity opp : relatedOpps) {
            // Some logic on score
        }
    }

    // Private method to calculate score based on Activities
    public void calculateActivityScore() {
        List<Task> relatedTasks = [
            SELECT Status FROM Task
            WHERE WhatId IN :accountIds
        ];
        for (Task t : relatedTasks) {
            // Some logic on score
        }
    }
}