public with sharing class SendWelcomeEmailAction_Inheritance extends AccountCreationAction_Inheritance {
    public override void createAccounts (List<Account> accounts) {
        super.createAccounts(accounts);
        for (Account acc : accounts) {
            System.debug('Welcome email send to : ' + acc.Name);
        }
    }
}