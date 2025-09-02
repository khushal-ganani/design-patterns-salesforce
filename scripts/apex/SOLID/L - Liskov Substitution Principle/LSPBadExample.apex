// Usage that demonstrates the problems
Order__c order1 = new Order__c(Amount__c = -100); 
Order__c order2 = new Order__c(Amount__c = 1000);
Order__c order3 = new Order__c(Amount__c = 1000);

PaymentService_Bad.processOrderPayment(order1, new CreditCardProcessor_Bad()); // Might throw unexpected exception
PaymentService_Bad.processOrderPayment(order2, new GiftCardProcessor_Bad()); // Might fail due to balance check
PaymentService_Bad.processOrderPayment(order3, new BankTransferProcessor_Bad()); // Always returns false