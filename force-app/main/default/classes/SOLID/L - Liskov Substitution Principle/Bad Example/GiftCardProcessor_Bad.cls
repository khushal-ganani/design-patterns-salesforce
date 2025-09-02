// Violates LSP - changes method behavior expectations
public class GiftCardProcessor_Bad extends PaymentProcessor_Bad {
    private Decimal availableBalance = 500;
    
    public override Decimal calculateProcessingFee(Decimal amount) {
        return 0; // No fees for gift cards - this breaks expectations
    }
    
    // Violates LSP - fails for valid amounts that parent class should handle
    public override Boolean processPayment(Decimal amount) {
        if (amount > availableBalance) {
            throw new PaymentException('Insufficient gift card balance');
        }
        availableBalance -= amount;
        return true;
    }
    
    // Violates LSP - different validation rules than expected
    public override Boolean validatePayment(Decimal amount) {
        return amount > 0 && amount <= availableBalance;
    }
}