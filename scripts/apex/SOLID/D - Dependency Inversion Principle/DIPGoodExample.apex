// Anonymous Apex execution - Dependency Injection in action

// Create notification service implementations
INotificationService emailService = new EmailService_Good();
INotificationService smsService = new SMSService_Good();

// Create sample order
Order__c testOrder = new Order__c(
    Customer_Email__c = 'customer@example.com',
    Customer_Phone__c = '+1234567890'
);

// Inject dependencies into OrderProcessor
new OrderProcessor_Good(emailService).processOrder(testOrder);
new OrderProcessor_Good(smsService).processOrder(testOrder);