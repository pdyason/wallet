<a href="https://github.com/pdyason/wallet/actions"><img src="https://github.com/pdyason/wallet/workflows/test-wallet/badge.svg" alt="Build Status"></a>

# Wallet

An example wallet app to capture, validate, and store cards using Flutter and Redux

## Getting Started

- Add cards and banned countries
- Swipe to delete

## Objectives

- Create an app to capture, validate, and store bank cards
- Use Redux for state management
- Limit 3rd party packages
- Apply specified checks on cards

## Notes

- Performace is good enough not to warrent further optimisation
- Comments, exhaustive checks, and tests are kept to a minimum

## Tests

The app was tested on Android

iOS requires additional permissions

Run Tests: `flutter test -r github`

- Unit Test
- Widget Test
- Integration Test

## Dependencies

- Dart: 3.16.4
- Flutter: 3.2.3
- redux: 5.0.0
- flutter_redux: 0.10.0
- shared_preferences: 2.2.2
- flutter_markdown: 0.6.18+3
- credit_card_scanner: 1.0.5
