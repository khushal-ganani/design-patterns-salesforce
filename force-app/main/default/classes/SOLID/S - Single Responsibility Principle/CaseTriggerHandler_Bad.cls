public with sharing class CaseTriggerHandler_Bad {

    public void handleBeforeInsert (List<Case> newCases) {
        // Assign Queue
        Group supportQueue = [SELECT Id FROM Group WHERE Name = 'Support Queue' LIMIT 1];
        for (Case cs : newCases) {
            cs.OwnerId = supportQueue.Id;
        }
    }

    public void handleAfterInsert (List<Case> newCases) {
        // Send Notification
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();

        for (Case cs : newCases) {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(new String[] { 'support@example.com' });
            mail.setSubject('New Case Created');
            mail.setPlainTextBody('Case created: ' + cs.Subject);

            mails.add(mail);
        }
        Messaging.sendEmail(mails);

        // Log to CaseAudit__c
        List<CaseAudit__c> caseAudits = new List<CaseAudit__c>();
        for (Case cs : newCases) {
            CaseAudit__c audit = new CaseAudit__c(
                Case__c = cs.Id,
                Action__c = 'Case Created'
            );
            caseAudits.add(audit);
        }
        insert caseAudits;
    }
}