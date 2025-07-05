public class CaseAuditLogger {
    public void logCreation(List<Case> newCases) {
        List<CaseAudit__c> audits = new List<CaseAudit__c>();
        for (Case c : newCases) {
            CaseAudit__c audit = new CaseAudit__c(
                Case__c = c.Id,
                Action__c = 'Case Created'
            );

            audits.add(audit);
        }
        insert audits;
    }
}
