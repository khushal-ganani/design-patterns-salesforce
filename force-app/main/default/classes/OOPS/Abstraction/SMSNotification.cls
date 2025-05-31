public class SMSNotification implements NotificationStrategy {
    public void sendNotification(Contact c, String message) {
        // Imagine this is an API call to external API like Twilio or similar to send SMS
        System.debug('Sending SMS to: ' + c.Phone + ' with message: ' + message);
    }
}
