Contact contact = [SELECT Id, Email FROM Contact WHERE Email != null LIMIT 1];

ContactNotificationService_Bad service = new ContactNotificationService_Bad(emailNotifier);
service.notifyContact(contact, 'Welcome to our platform!', 'Email');
