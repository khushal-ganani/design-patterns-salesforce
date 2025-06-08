public with sharing class AccountCreationService {
    private List<AccountCreationAction> actions;

    public AccountCreationService(List<AccountCreationAction> actions) {
        this.actions = actions;
    }

    public void createAccounts(List<Account> accounts) {
        insert accounts;

        // Post craation actions : 
        for (AccountCreationAction action : actions) {
            action.createAccounts(accounts);
        }
    }
}