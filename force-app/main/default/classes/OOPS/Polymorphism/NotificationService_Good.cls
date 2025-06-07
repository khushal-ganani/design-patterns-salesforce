public with sharing class NotificationService_Good {
    private NotificationSender sender;

    public NotificationService_Good(NotificationSender sender) {
        this.sender = sender;
    }

    public void notifyUser (String userId, String message) {
        sender.sendNotification(userId, message);
    }
}