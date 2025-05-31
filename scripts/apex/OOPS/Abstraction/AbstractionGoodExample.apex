Contact contact = [SELECT Id, Email FROM Contact WHERE Email != null LIMIT 1];

NotificationStrategy emailNotifier = new EmailNotification();
ContactNotificationService_Good service = new ContactNotificationService_Good(emailNotifier);
service.notifyContact(contact, 'Welcome to our platform!');
