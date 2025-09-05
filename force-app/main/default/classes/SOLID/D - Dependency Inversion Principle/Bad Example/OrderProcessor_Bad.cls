public class OrderProcessor_Bad {
    private EmailService_Bad emailService;
    private SMSService_Bad smsService;
    
    public OrderProcessor_Bad() {
        // Tight coupling - creating dependencies inside the class
        this.emailService = new EmailService_Bad();
        this.smsService = new SMSService_Bad();
    }
    
    public void processOrder(Order__c order, String notificationType) {
        // Process order logic
        System.debug('Processing order: ' + order.Id);
        
        // Notification logic tightly coupled to concrete classes
        if (notificationType == 'EMAIL') {
            emailService.sendEmail(order.Customer_Email__c, 'Your order has been processed');
        } else if (notificationType == 'SMS') {
            smsService.sendSMS(order.Customer_Phone__c, 'Your order has been processed');
        }
        
        System.debug('Order processed successfully');
    }
}