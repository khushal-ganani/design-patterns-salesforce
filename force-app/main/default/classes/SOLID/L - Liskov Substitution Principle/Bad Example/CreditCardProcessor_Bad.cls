// Violates LSP - throws unexpected exceptions
public class CreditCardProcessor_Bad extends PaymentProcessor_Bad {
    public override Decimal calculateProcessingFee(Decimal amount) {
        if (amount <= 0) {
            throw new IllegalArgumentException('Amount must be positive');
        }
        return amount * 0.03; // 3% fee
    }
    
    public override Boolean processPayment(Decimal amount) {
        return amount > 0 && amount <= 10000;
    }
    
    public override Boolean validatePayment(Decimal amount) {
        return amount > 0;
    }
}