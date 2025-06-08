public with sharing class AllAcountCReationActions_Inheritance extends AccountCreationAction_Inheritance {
    public override void createAccounts (List<Account> accounts) {
        super.createAccounts(accountsl);

        List<AccountLog__c> accountLogs = new List<AccountLog__c>();
        for (Account acc : accounts) {
            System.debug('Welcome email send to : ' + acc.Name);
            accountLogs.add(new AccountLog__c(
                Account__c = acc.Id,
                Action__c = 'Account Created'
            ));
        }

        insert accountLogs;

        //! Allot of code duplication here which violates the Single Responsibility Principle (a SOLID Principle)
    }
}