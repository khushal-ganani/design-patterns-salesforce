// Usage in Anonymous Apex
CustomerNotificationService_Good customerService = new CustomerNotificationService_Good();
SalesRepNotificationService_Good repService = new SalesRepNotificationService_Good();
ManagerNotificationService_Good managerService = new ManagerNotificationService_Good();

// Each service only has methods it actually supports
customerService.sendEmail('customer@email.com', 'Order update');

repService.sendEmail('rep@company.com', 'New lead assigned');
repService.sendSMS('1234567890', 'Urgent: Follow up needed');

managerService.sendEmail('manager@company.com', 'Monthly report');
managerService.sendSMS('0987654321', 'Team meeting reminder');
managerService.sendPushNotification('mgr123', 'Approval needed');

// Can work with services through specific interfaces
EmailNotifier_Good emailService = customerService;
emailService.sendEmail('test@email.com', 'Test message');