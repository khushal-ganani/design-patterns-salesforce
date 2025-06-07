public class NotificationService_Bad {
    public static void notifyUser(String notificationType, String userId, String message) {
        if (notificationType == 'Email') {
            sendEmail(userId, message);
        } else if (notificationType == 'Chatter') {
            postToChatter(userId, message);
        } else {
            System.debug('❌ Unknown notification type');
        }
    }

    private static void sendEmail(String userId, String message) {
        System.debug('📧 Email sent to UserId: ' + userId + ' with message: ' + message);
    }

    private static void postToChatter(String userId, String message) {
        System.debug('💬 Chatter post created for UserId: ' + userId + ' with message: ' + message);
    }
}
