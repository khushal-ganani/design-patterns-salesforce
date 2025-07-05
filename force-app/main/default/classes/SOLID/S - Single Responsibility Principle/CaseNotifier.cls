public class CaseNotifier {
    public void notifySupport(List<Case> newCases) {
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        for (Case c : newCases) {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(new String[] { 'support@example.com' });
            mail.setSubject('New Case Created');
            mail.setPlainTextBody('Case created: ' + c.Subject);

            mails.add(mail);
        }
        Messaging.sendEmail(mails);
    }
}
