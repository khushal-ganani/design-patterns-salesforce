public class SendWelcomeEmailAction implements AccountCreationAction {
    public void createAccounts(List<Account> accounts) {
        for (Account acc : accounts) {
            // Simulate sending an email
            System.debug('📧 Welcome email sent to Account: ' + acc.Name);
        }
    }
}
