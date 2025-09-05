// Anonymous Apex execution
OrderProcessor_Bad processor = new OrderProcessor_Bad();

// Create sample order
Order__c testOrder = new Order__c(
    Customer_Email__c = 'customer@example.com',
    Customer_Phone__c = '+1234567890'
);

processor.processOrder(testOrder, 'EMAIL');
processor.processOrder(testOrder, 'SMS');