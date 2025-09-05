public class EmailService_Bad {
    public void sendEmail(String recipient, String message) {
        // Direct email sending logic
        System.debug('Sending email to: ' + recipient);
        System.debug('Message: ' + message);
        
        // Simulate email API call
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new String[]{recipient});
        email.setSubject('Order Notification');
        email.setPlainTextBody(message);
        // Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
    }
}