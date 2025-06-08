Account acc = new Account(Name = 'Acme Inc.');

AccountCreationAction_Inheritance action = new AllAcountCReationActions_Inheritance();
action.createAccounts(new List<Account>{ acc });