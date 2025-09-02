public abstract class PaymentProcessor_Good {
    protected String paymentType;
    
    public PaymentProcessor_Good(String paymentType) {
        this.paymentType = paymentType;
    }
    
    // Contract: Always returns non-negative fee or 0
    public abstract Decimal calculateProcessingFee(Decimal amount);
    
    // Contract: Returns true if payment processed successfully, false otherwise
    // Should not throw exceptions for business logic failures
    public abstract Boolean processPayment(Decimal amount);
    
    // Contract: Returns true if amount is valid for this payment type
    public virtual Boolean validatePayment(Decimal amount) {
        return amount != null && amount > 0;
    }
    
    // Common behavior that all subclasses inherit
    public String getPaymentType() {
        return this.paymentType;
    }
}