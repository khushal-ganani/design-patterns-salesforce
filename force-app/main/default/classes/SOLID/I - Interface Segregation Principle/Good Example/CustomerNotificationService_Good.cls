public class CustomerNotificationService_Good implements EmailNotifier_Good {
    public void sendEmail(String recipient, String message) {
        System.debug('Sending email to customer: ' + recipient);
        // Actual email implementation for customers
    }
}