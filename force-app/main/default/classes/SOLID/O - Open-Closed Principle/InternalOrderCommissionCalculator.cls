public class InternalOrderCommissionCalculator implements ICommissionCalculator {
    public void applyCommission(Order__c order) {
        order.Commission__c = calculateInternalCommission(order);
    }

    private static Decimal calculateInternalCommission(Order__c order) {
        Decimal commission = 0;
        // Some code logic to calculate the Commission__c
        return commission;
    }
}