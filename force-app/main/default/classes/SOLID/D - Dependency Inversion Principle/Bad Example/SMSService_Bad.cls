public class SMSService_Bad {
    public void sendSMS(String phoneNumber, String message) {
        // Direct SMS sending logic
        System.debug('Sending SMS to: ' + phoneNumber);
        System.debug('Message: ' + message);
        
        // Simulate SMS API call
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://sms-api.com/send');
        req.setMethod('POST');
        // Http http = new Http().send(req);
    }
}