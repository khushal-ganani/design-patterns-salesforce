public with sharing abstract class RecordValidator {
    protected abstract List<String> validate(SObject record);

    public List<String> validateRecord (SObject record) {
        List<String> errors = basicValidation(record);
        errors.addAll(validate(record));

        return errors;
    }

    private List<String> basicValidation (SObject record) {
        List<String> errors = new List<String>();

        // Generic 'Name' check
        if (record.get('Name') == null || String.isBlank((String)record.get('Name'))) {
            errors.add('Name is required.');
        }

        return errors;
    }
}