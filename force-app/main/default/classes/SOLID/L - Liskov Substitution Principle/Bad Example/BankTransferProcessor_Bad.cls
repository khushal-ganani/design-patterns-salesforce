// Violates LSP - completely changes expected behavior
public class BankTransferProcessor_Bad extends PaymentProcessor_Bad {
    public override Decimal calculateProcessingFee(Decimal amount) {
        // Returns negative value - completely unexpected behavior
        return -5.00; // Bank transfer gives discount?
    }
    
    public override Boolean processPayment(Decimal amount) {
        // Always returns false - breaks substitutability
        System.debug('Bank transfer queued for batch processing');
        return false; // Doesn't actually process immediately
    }
    
    public override Boolean validatePayment(Decimal amount) {
        return amount >= 1000; // Arbitrary minimum not in parent contract
    }
}