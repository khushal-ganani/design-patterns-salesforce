String userId = UserInfo.getUserId();
String message = 'Approval needed.';

NotificationService_Bad.notifyUser('Email', userId, message);
NotificationService_Bad.notifyUser('Chatter', userId, message);
