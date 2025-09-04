public class ManagerNotificationService_Good implements EmailNotifier_Good, SMSNotifier_Good, PushNotifier_Good {
    public void sendEmail(String recipient, String message) {
        System.debug('Sending email to manager: ' + recipient);
        // Email implementation for managers
    }
    
    public void sendSMS(String phoneNumber, String message) {
        System.debug('Sending SMS to manager: ' + phoneNumber);
        // SMS implementation for managers
    }
    
    public void sendPushNotification(String userId, String message) {
        System.debug('Sending push notification to manager: ' + userId);
        // Push notification implementation for managers
    }
}