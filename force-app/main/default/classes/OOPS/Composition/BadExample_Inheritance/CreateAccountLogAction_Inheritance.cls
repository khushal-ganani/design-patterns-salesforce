public with sharing class CreateAccountLogAction_Inheritance extends AccountCreationAction_Inheritance {
    public override void createAccounts(List<Account> accounts) {
        super.createAccounts(accounts);
        
        List<AccountLog__c> accountLogs = new List<AccountLog__c>();
        for (Account acc : accounts) {
            accountLogs.add(new AccountLog__c(
                Account__c = acc.Id,
                Action__c = 'Account Created'
            ));
        }

        insert accountLogs;
    }
}