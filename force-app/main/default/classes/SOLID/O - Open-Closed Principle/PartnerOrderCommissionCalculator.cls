public class PartnerOrderCommissionCalculator implements ICommissionCalculator {
    public void applyCommission(Order__c order) {
        order.Commission__c = calculatePartnerCommission(order);
    }

    private static Decimal calculatePartnerCommission(Order__c order) {
        Decimal commission = 0;
        // Some code logic to calculate the Commission__c
        return commission;
    }
}