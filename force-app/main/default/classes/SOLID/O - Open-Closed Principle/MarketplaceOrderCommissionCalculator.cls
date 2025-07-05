public class MarketplaceOrderCommissionCalculator implements ICommissionCalculator {
    public void applyCommission(Order__c order) {
        order.Commission__c = calculateMarketplaceCommission(order);
    }

    private static Decimal calculateMarketplaceCommission(Order__c order) {
        Decimal commission = 0;
        // Some code logic to calculate the Commission__c
        return commission;
    }
}