// Helper class for payment results
public class PaymentResult {
    public Boolean success { get; set; }
    public Decimal processingFee { get; set; }
    public String paymentType { get; set; }
    public String errorMessage { get; set; }
    
    public PaymentResult() {
        this.success = false;
        this.processingFee = 0;
    }
}