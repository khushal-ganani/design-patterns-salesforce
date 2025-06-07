public class EmailNotificationSender implements NotificationSender {
    public void sendNotification(String userId, String message) {
        // Simulate sending email
        System.debug('📧 Email sent to UserId: ' + userId + ' with message: ' + message);
    }
}
