public class OrderCommissionCalculator_Good {
    private static Map<String, System.Type> COMMISSION_CALCULATOR_MAP = new Map<String, System.Type>{
        'Online' => OnlineOrderCommissionCalculator.class,
        'Partner' => PartnerOrderCommissionCalculator.class,
        'Internal' => InternalOrderCommissionCalculator.class,
        'Marketplace' => MarketplaceOrderCommissionCalculator.class
    };
    
    public static void calculate(List<Order__c> orders) {
        for (Order__c order : orders) {
            if (COMMISSION_CALCULATOR_MAP.containsKey(order.Channel__c)) {
                ICommissionCalculator commissionCalculator = (ICommissionCalculator) COMMISSION_CALCULATOR_MAP.get(order.Channel__c).newInstance();
                commissionCalculator.applyCommission(order);
            }
        }
        update orders;
    }
}