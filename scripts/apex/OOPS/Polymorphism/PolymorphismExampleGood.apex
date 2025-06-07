String userId = UserInfo.getUserId();
String message = 'Your approval is required.';

// Polymorphic behavior
new NotificationService_Good(new EmailNotificationSender()).notifyUser(userId, message);
new NotificationService_Good(new ChatterNotificationSender()).notifyUser(userId, message);
