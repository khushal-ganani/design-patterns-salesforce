// Usage examples - all work identically due to LSP compliance
PaymentProcessor_Good creditProcessor = new CreditCardProcessor_Good();
PaymentProcessor_Good giftProcessor = new GiftCardProcessor_Good(1000);
PaymentProcessor_Good bankProcessor = new BankTransferProcessor_Good();

// All of these calls work exactly the same way
PaymentResult result1 = PaymentService_Good.processOrderPayment(order1, creditProcessor);
PaymentResult result2 = PaymentService_Good.processOrderPayment(order2, giftProcessor);
PaymentResult result3 = PaymentService_Good.processOrderPayment(order3, bankProcessor);