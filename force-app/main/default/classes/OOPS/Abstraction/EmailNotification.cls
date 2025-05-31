public class EmailNotification implements NotificationStrategy {
    public void sendNotification(Contact c, String message) {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] { c.Email });
        mail.setSubject('Notification');
        mail.setPlainTextBody(message);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}
