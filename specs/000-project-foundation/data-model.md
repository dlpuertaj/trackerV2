# Data Model: Project Foundation

## Entity: ValidationResult

A reusable result type returned by all form validators.

| Field             | Type     | Required | Notes                                   |
|-------------------|----------|----------|-----------------------------------------|
| `isValid`         | bool     | Yes      | True if all error fields are null       |
| `typeError`       | String?  | No       | Type selection error message            |
| `amountError`     | String?  | No       | Amount validation error message         |
| `descriptionError`| String?  | No       | Description validation error message    |
| `nameError`       | String?  | No       | Name validation error message           |

### Usage
- Each validator creates a `ValidationResult` with only the fields it
  validates. Unused fields remain null.
- `isValid` is computed: true when ALL error fields are null.

## Entity: AppTheme

A static class providing the app's `ThemeData`.

| Constant           | Type      | Purpose                       |
|--------------------|-----------|-------------------------------|
| `primaryColor`     | `Color`   | Primary brand colour          |
| `light`            | `ThemeData`| Full theme for MaterialApp   |

### Design Tokens
- Primary: Indigo/blue tone
- Surface: White with standard elevation
- Text: Dark grey for body, near-black for headlines
- Error: Standard Material red
