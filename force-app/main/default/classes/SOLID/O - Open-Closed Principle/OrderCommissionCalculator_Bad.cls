public class OrderCommissionCalculator_Bad {
    public static void calculate(List<Order__c> orders) {
        for (Order__c order : orders) {
            if (order.Channel__c == 'Online') {
                order.Commission__c = calculateOnlineCommission(order);
            } else if (order.Channel__c == 'Partner') {
                order.Commission__c = calculatePartnerCommission(order);
            } else if (order.Channel__c == 'Internal') {
                order.Commission__c = calculateInternalCommission(order);
            } else if (order.Channel__c == 'Marketplace') {
                order.Commission__c = calculateMarketplaceCommission(order);
            } else {
                order.Commission__c = 0;
            }
        }
        update orders;
    }

    private static Decimal calculateOnlineCommission(Order__c order) {
        Decimal commission = 0;
        // Some code logic to calculate the Commission__c
        return commission;
    }

    private static Decimal calculatePartnerCommission(Order__c order) {
        Decimal commission = 0;
        // Some code logic to calculate the Commission__c
        return commission;
    }

    private static Decimal calculateInternalCommission(Order__c order) {
        Decimal commission = 0;
        // Some code logic to calculate the Commission__c
        return commission;
    }

    private static Decimal calculateMarketplaceCommission(Order__c order) {
        Decimal commission = 0;
        // Some code logic to calculate the Commission__c
        return commission;
    }
}
