public class BankTransferProcessor_Good extends PaymentProcessor_Good {
    private static final Decimal FLAT_FEE = 5.00;
    private static final Decimal MIN_AMOUNT = 10.00;
    
    public BankTransferProcessor_Good() {
        super('Bank Transfer');
    }
    
    public override Decimal calculateProcessingFee(Decimal amount) {
        // Honors parent contract - returns non-negative fee
        if (amount == null || amount <= 0) {
            return 0;
        }
        return FLAT_FEE;
    }
    
    public override Boolean processPayment(Decimal amount) {
        // Honors parent contract - processes immediately or returns false
        if (!validatePayment(amount)) {
            return false;
        }
        
        try {
            // Simulate bank transfer processing
            System.debug('Processing bank transfer: ' + amount);
            return true;
        } catch (Exception e) {
            System.debug('Bank transfer failed: ' + e.getMessage());
            return false;
        }
    }
    
    public override Boolean validatePayment(Decimal amount) {
        // Maintains parent's validation contract
        return super.validatePayment(amount) && amount >= MIN_AMOUNT;
    }
}