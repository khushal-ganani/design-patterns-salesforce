public class PaymentService_Good {
    public static PaymentResult processOrderPayment(Order__c order, PaymentProcessor_Good processor) {
        PaymentResult result = new PaymentResult();
        
        // Thanks to LSP, this method works with ANY PaymentProcessor_Good subclass
        if (processor.validatePayment(order.Amount__c)) {
            Decimal fee = processor.calculateProcessingFee(order.Amount__c);
            Boolean success = processor.processPayment(order.Amount__c);
            
            result.success = success;
            result.processingFee = fee;
            result.paymentType = processor.getPaymentType();
            
            if (success) {
                order.Processing_Fee__c = fee;
                order.Status__c = 'Processed';
                order.Payment_Method__c = processor.getPaymentType();
            } else {
                order.Status__c = 'Failed';
            }
        } else {
            result.success = false;
            result.errorMessage = 'Payment validation failed';
            order.Status__c = 'Invalid';
        }
        
        return result;
    }
    
    // This method can work with ANY payment processor without modification
    public static List<PaymentResult> processBulkPayments(List<Order__c> orders, PaymentProcessor_Good processor) {
        List<PaymentResult> results = new List<PaymentResult>();
        
        for (Order__c order : orders) {
            results.add(processOrderPayment(order, processor));
        }
        
        return results;
    }
}

