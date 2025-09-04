// Usage in Anonymous Apex
CustomerNotificationService_Bad customerService = new CustomerNotificationService_Bad();

// This works fine
customerService.sendEmail('customer@email.com', 'Your order is ready!');

// These will throw exceptions even though the interface allows them
try {
    customerService.sendSMS('1234567890', 'SMS message'); // Throws exception!
    customerService.sendPushNotification('user123', 'Push message'); // Throws exception!
} catch (UnsupportedOperationException e) {
    System.debug('Error: ' + e.getMessage());
}