public class OpportunityValidator extends RecordValidator {
    protected override List<String> validate (SObject record) {
        Opportunity opp = (Opportunity)record;
        List<String> errors = new List<String>();

        if (opp.Amount == null) {
            errors.add('Amount is required for Opportunity.');
        }
        if (opp.CloseDate == null) {
            errors.add('Close Date is required for Opportunity.');
        }

        return errors;
    }
}
