public class SalesRepNotificationService_Good implements EmailNotifier_Good, SMSNotifier_Good {
    public void sendEmail(String recipient, String message) {
        System.debug('Sending email to sales rep: ' + recipient);
        // Email implementation for sales reps
    }
    
    public void sendSMS(String phoneNumber, String message) {
        System.debug('Sending SMS to sales rep: ' + phoneNumber);
        // SMS implementation for sales reps
    }
}