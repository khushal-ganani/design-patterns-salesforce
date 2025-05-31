public class ContactNotificationService_Bad {
    public void notifyContact(Contact c, String message, String method) {
        if (method == 'Email') {
            if (c.Email != null) {
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(new String[] { c.Email });
                mail.setSubject('Notification');
                mail.setPlainTextBody(message);
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            }
        } else if (method == 'SMS') {
            if (c.Phone != null) {
                // Simulate sending SMS through external API like Twillio
                System.debug('Sending SMS to: ' + c.Phone + ' with message: ' + message);
            }
        } else {
            System.debug('Unsupported notification method: ' + method);
        }
    }
}
