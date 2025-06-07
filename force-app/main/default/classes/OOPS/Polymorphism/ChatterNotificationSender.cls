public class ChatterNotificationSender implements NotificationSender {
    public void sendNotification(String userId, String message) {
        // Simulate posting to Chatter
        System.debug('💬 Chatter post created for UserId: ' + userId + ' with message: ' + message);
    }
}
