public class ContactNotificationService_Good {
    private NotificationStrategy notifier;

    // Constructor takes in any notifier implementation
    public ContactNotificationService_Good(NotificationStrategy notifier) {
        this.notifier = notifier;
    }

    public void notifyContact(Contact c, String msg) {
        if (c != null && msg != null) {
            notifier.sendNotification(c, msg);
        }
    }
}
