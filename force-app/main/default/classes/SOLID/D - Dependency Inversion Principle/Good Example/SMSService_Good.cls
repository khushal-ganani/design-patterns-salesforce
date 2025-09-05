public class SMSService_Good implements INotificationService {
    public void sendNotification(Order__c order, String message) {
        String recipient = order.Customer_Phone__c;
        System.debug('Sending SMS to: ' + recipient);
        System.debug('SMS message: ' + message);
        
        // SMS-specific implementation
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://sms-api.com/send');
        req.setMethod('POST');
        req.setBody('{"phone":"' + recipient + '","message":"' + message + '"}');
        // Http http = new Http().send(req);
    }
    
    public NotificationType getServiceType() {
        return NotificationType.SMS;
    }
}