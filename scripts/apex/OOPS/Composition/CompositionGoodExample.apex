Account acc = new Account(Name = 'Acme Inc.');

List<AccountCreationAction> postActions = new List<AccountCreationAction>{
    new SendWelcomeEmailAction(),
    new CreateAccountLogAction()
};

AccountCreationService service = new AccountCreationService(postActions);
service.createAccounts(new List<Account>{ acc });