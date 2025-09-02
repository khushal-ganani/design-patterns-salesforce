public class PaymentService_Bad {
    public static void processOrderPayment(Order__c order, PaymentProcessor_Bad processor) {
        try {
            // This code expects consistent behavior from all processors
            if (processor.validatePayment(order.Amount__c)) {
                Decimal fee = processor.calculateProcessingFee(order.Amount__c);
                Boolean success = processor.processPayment(order.Amount__c);
                
                if (success) {
                    order.Processing_Fee__c = fee;
                    order.Status__c = 'Processed';
                } else {
                    order.Status__c = 'Failed';
                }
            }
        } catch (Exception e) {
            // Unexpected exceptions break the flow
            order.Status__c = 'Error';
        }
    }
}