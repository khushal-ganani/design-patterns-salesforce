public class ContactValidator extends RecordValidator {
    protected override List<String> validate (SObject record) {
        List<String> errors = new List<String>(); // Inherit default checks
        Contact c = (Contact) record;

        if (String.isBlank(c?.Email)) {
            errors.add('Email is required for Contact.');
        }

        return errors;
    }
}
