public class OnlineOrderCommissionCalculator implements ICommissionCalculator {
    public void applyCommission(Order__c order) {
        order.Commission__c = calculateOnlineCommission(order);
    }

    private static Decimal calculateOnlineCommission(Order__c order) {
        Decimal commission = 0;
        // Some code logic to calculate the Commission__c
        return commission;
    }
}