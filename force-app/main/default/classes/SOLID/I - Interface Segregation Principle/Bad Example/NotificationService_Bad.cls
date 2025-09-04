// Fat interface that violates ISP
public interface NotificationService_Bad {
    void sendEmail(String recipient, String message);
    void sendSMS(String phoneNumber, String message);
    void sendPushNotification(String userId, String message);
}