class ValidationResult {
  final String? typeError;
  final String? amountError;
  final String? descriptionError;
  final String? nameError;

  ValidationResult({
    this.typeError,
    this.amountError,
    this.descriptionError,
    this.nameError,
  });

  bool get isValid =>
      typeError == null &&
      amountError == null &&
      descriptionError == null &&
      nameError == null;
}
