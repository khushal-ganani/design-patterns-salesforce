public class CreditCardProcessor_Good extends PaymentProcessor_Good {
    private static final Decimal PROCESSING_FEE_RATE = 0.03;
    private static final Decimal MAX_AMOUNT = 10000;
    
    public CreditCardProcessor_Good() {
        super('Credit Card');
    }
    
    public override Decimal calculateProcessingFee(Decimal amount) {
        // Always returns non-negative fee, honoring parent contract
        if (amount == null || amount <= 0) {
            return 0;
        }
        return amount * PROCESSING_FEE_RATE;
    }
    
    public override Boolean processPayment(Decimal amount) {
        // Honors parent contract - returns boolean, doesn't throw exceptions
        if (!validatePayment(amount)) {
            return false;
        }
        
        // Simulate credit card processing
        try {
            // Process credit card payment logic here
            System.debug('Processing credit card payment: ' + amount);
            return true;
        } catch (Exception e) {
            System.debug('Credit card processing failed: ' + e.getMessage());
            return false;
        }
    }
    
    public override Boolean validatePayment(Decimal amount) {
        // Maintains parent's validation contract while adding specific rules
        return super.validatePayment(amount) && amount <= MAX_AMOUNT;
    }
}