public class CreateAccountLogAction implements AccountCreationAction {
    public void createAccounts(List<Account> accounts) {
        List<AccountLog__c> accountLogs = new List<AccountLog__c>();

        for (Account acc : accounts) {
            accountLogs.add(new AccountLog__c(
                Account__c = acc.Id,
                Action__c = 'Account Created'
            ));
        
            System.debug('📝 Log entry created for Account: ' + acc.Name);
        }
        
        insert accountLogs;
    }
}
