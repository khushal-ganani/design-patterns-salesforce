public abstract class PaymentProcessor_Bad {
    public abstract Decimal calculateProcessingFee(Decimal amount);
    public abstract Boolean processPayment(Decimal amount);
    public abstract Boolean validatePayment(Decimal amount);
}