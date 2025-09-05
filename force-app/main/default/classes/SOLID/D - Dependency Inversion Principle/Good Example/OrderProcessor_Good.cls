public class OrderProcessor_Good {
    private INotificationService notificationService;
    
    // Constructor Injection - Dependencies injected from outside
    public OrderProcessor_Good(INotificationService service) {
        this.notificationService = service;
    }
    
    public void processOrder(Order__c order) {
        // Process order logic
        System.debug('Processing order: ' + order);
        
        // Find appropriate service based on type
        notificationService.sendNotification(order, 'Your order has been processed successfully!');
        System.debug('Order processing done!');
    }
}