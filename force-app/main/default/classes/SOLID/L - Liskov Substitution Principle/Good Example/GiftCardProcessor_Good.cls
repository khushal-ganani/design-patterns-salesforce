public class GiftCardProcessor_Good extends PaymentProcessor_Good {
    private Decimal availableBalance;
    
    public GiftCardProcessor_Good(Decimal balance) {
        super('Gift Card');
        this.availableBalance = balance != null ? balance : 0;
    }
    
    public override Decimal calculateProcessingFee(Decimal amount) {
        // Honors parent contract - returns non-negative fee
        return 0; // Gift cards have no processing fees
    }
    
    public override Boolean processPayment(Decimal amount) {
        // Honors parent contract - returns boolean without throwing exceptions
        if (!validatePayment(amount)) {
            return false;
        }
        
        if (amount > availableBalance) {
            System.debug('Insufficient gift card balance');
            return false;
        }
        
        // Deduct from balance and process
        availableBalance -= amount;
        System.debug('Gift card payment processed: ' + amount);
        return true;
    }
    
    public override Boolean validatePayment(Decimal amount) {
        // Maintains parent's validation while adding balance check
        return super.validatePayment(amount) && amount <= availableBalance;
    }
    
    public Decimal getAvailableBalance() {
        return availableBalance;
    }
}