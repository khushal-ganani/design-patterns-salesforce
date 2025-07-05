public with sharing class CaseTriggerHandler_Good {
    private CaseOwnerAssigner assigner = new CaseOwnerAssigner();
    private CaseNotifier notifier = new CaseNotifier();
    private CaseAuditLogger logger = new CaseAuditLogger();

    public void handleBeforeInsert (Case c) {
        assigner.assignQueue(c);
    }

    public void handleAfterInsert (Case c) {
        notifier.notifySupport(c);
        logger.logCreation(c);
    }
}