public class EmailService_Good implements INotificationService {
    public void sendNotification(Order__c order, String message) {
        String recipient = order.Customer_Email__c;
        System.debug('Sending email to: ' + recipient);
        System.debug('Email message: ' + message);
        
        // Email-specific implementation
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new String[]{recipient});
        email.setSubject('Order Notification');
        email.setPlainTextBody(message);
        // Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
    }
    
    public NotificationType getServiceType() {
        return NotificationType.EMAIL;
    }
}