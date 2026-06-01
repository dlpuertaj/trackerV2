# Requirements Checklist: Project Foundation

## Functional Requirements

- [ ] FR-001: Project compiles, `flutter analyze` passes with zero errors
- [ ] FR-002: `lib/` has `models/`, `services/`, `widgets/`, `pages/` subdirectories
- [ ] FR-003: `test/` mirrors `lib/` structure
- [ ] FR-004: `analysis_options.yaml` enforces lint rules (snake_case, const, no print)
- [ ] FR-005: Shared `ThemeData` defines primary colour, text theme, button theme
- [ ] FR-006: `ValidationResult` model in `lib/models/validation_result.dart`
- [ ] FR-007: Theme and ValidationResult importable by all features
- [ ] FR-008: Default counter test removed

## Success Criteria

- [ ] SC-001: `flutter analyze` passes in under 30s
- [ ] SC-002: All 5 features (001-005) can import `ValidationResult` and `AppTheme`
- [ ] SC-003: New `lib/widgets/` file + `test/widgets/` test works without config changes
