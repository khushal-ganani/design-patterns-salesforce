public with sharing class CaseTriggerHandler_Good {
    private CaseOwnerAssigner assigner = new CaseOwnerAssigner();
    private CaseNotifier notifier = new CaseNotifier();
    private CaseAuditLogger logger = new CaseAuditLogger();

    public void handleBeforeInsert (List<Case> newCases) {
        assigner.assignQueue(newCases);
    }

    public void handleAfterInsert (List<Case> newCases) {
        notifier.notifySupport(newCases);
        logger.logCreation(newCases);
    }
}