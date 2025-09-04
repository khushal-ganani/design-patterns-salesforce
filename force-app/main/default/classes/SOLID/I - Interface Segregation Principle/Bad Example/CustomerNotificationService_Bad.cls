// Customer service forced to implement methods it doesn't need
public class CustomerNotificationService_Bad implements NotificationService_Bad {
    
    public void sendEmail(String recipient, String message) {
        System.debug('Sending email to customer: ' + recipient);
        // Actual email implementation
    }
    
    // Forced to implement SMS even though customers don't receive SMS
    public void sendSMS(String phoneNumber, String message) {
        throw new UnsupportedOperationException('Customers do not receive SMS notifications');
    }
    
    // Forced to implement push notifications even though customers don't have the app
    public void sendPushNotification(String userId, String message) {
        throw new UnsupportedOperationException('Customers do not receive push notifications');
    }
}