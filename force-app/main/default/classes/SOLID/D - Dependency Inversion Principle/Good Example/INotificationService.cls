public interface INotificationService {
    void sendNotification(Order__c order, String message);
    NotificationType getServiceType();
}