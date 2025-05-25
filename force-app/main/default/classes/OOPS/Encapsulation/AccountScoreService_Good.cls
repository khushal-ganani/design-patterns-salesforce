public with sharing class AccountScoreService_Good {
    private List<Id> accountIds;
    private Map<Id, Decimal> opportunityScore;
    private Map<Id, Decimal> activityScore;

    // Constructor accepts the AccountPlan object
    public AccountScoreService_Good(List<Id> accountIds) {
        this.accountIds = accountIds;
        this.opportunityScore = new Map<Id, Decimal>();
        this.activityScore = new Map<Id, Decimal>();
        calculateScore();
    }

    // Public method to trigger score calculation
    private void calculateScore() {
        calculateOpportunityScore();
        calculateActivityScore();
    }

    // Public method to get the final Opportunity score
    public Decimal getOpportunityScore(Id accountId) {
        return opportunityScore.get(accountId);
    }

    // Public method to get the final Activity score
    public Decimal getActivityScore(Id accountId) {
        return activityScore.get(accountId);
    }

    // Private method to calculate score based on Opportunities
    private void calculateOpportunityScore() {
        List<Opportunity> relatedOpps = [
            SELECT Amount FROM Opportunity
            WHERE AccountId IN :accountIds
        ];
        for (Opportunity opp : relatedOpps) {
            // Some logic on score
        }
    }

    // Private method to calculate score based on Activities
    private void calculateActivityScore() {
        List<Task> relatedTasks = [
            SELECT Status FROM Task
            WHERE WhatId IN :accountIds
        ];
        for (Task t : relatedTasks) {
            // Some logic on score
        }
    }
}