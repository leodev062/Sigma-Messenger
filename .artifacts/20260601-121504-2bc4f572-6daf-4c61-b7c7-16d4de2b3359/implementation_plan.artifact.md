# Implementation Plan - Identical Signal Android Registration Refactor

Refactor the Flutter registration flow to **identically** match Signal Android's 2025 file structure, naming, and architecture. This is a strict mirroring of the `org.signal.registration.screens` package.

## User Review Required

> [!IMPORTANT]
> - **Identical Structure**: Directories and files will follow the Signal Android organization precisely (e.g., `screens/welcome/WelcomeScreen.dart`).
> - **Architecture Mirroring**: I will implement a Flutter version of `EventDrivenViewModel` to match the Elm-like architecture used in Signal.
> - **File Naming**: All files will use CamelCase matching their Kotlin counterparts (e.g., `WelcomeScreenEvents.dart`).

## Proposed Changes

### [Registration Module]

Create the base architecture components used across registration.

#### [NEW] [EventDrivenViewModel.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/lib/features/registration/screens/EventDrivenViewModel.dart)
- Flutter implementation of Signal's base ViewModel using `StreamController` for event processing.

#### [NEW] [RegistrationScaffold.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/lib/features/registration/screens/RegistrationScaffold.dart)
- Adaptive scaffold matching `RegistrationScaffold.kt`.

---

### [Welcome Screen] - `screens/welcome/`

#### [NEW] [WelcomeScreen.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/lib/features/registration/screens/welcome/WelcomeScreen.dart)
#### [NEW] [WelcomeScreenEvents.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/lib/features/registration/screens/welcome/WelcomeScreenEvents.dart)

---

### [Country Code] - `screens/countrycode/`

#### [NEW] [Country.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/lib/features/registration/screens/countrycode/Country.dart)
#### [NEW] [CountryUtils.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/lib/features/registration/screens/countrycode/CountryUtils.dart)
#### [NEW] [CountryCodeState.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/lib/features/registration/screens/countrycode/CountryCodeState.dart)
#### [NEW] [CountryCodePickerScreen.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/lib/features/registration/screens/countrycode/CountryCodePickerScreen.dart)
#### [NEW] [CountryCodePickerViewModel.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/lib/features/registration/screens/countrycode/CountryCodePickerViewModel.dart)
#### [NEW] [CountryCodePickerRepository.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/lib/features/registration/screens/countrycode/CountryCodePickerRepository.dart)
#### [NEW] [CountryCodePickerScreenEvents.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/lib/features/registration/screens/countrycode/CountryCodePickerScreenEvents.dart)

---

### [Phone Number] - `screens/phonenumber/`

#### [NEW] [PhoneNumberEntryState.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/lib/features/registration/screens/phonenumber/PhoneNumberEntryState.dart)
#### [NEW] [PhoneNumberEntryScreen.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/lib/features/registration/screens/phonenumber/PhoneNumberEntryScreen.dart)
#### [NEW] [PhoneNumberEntryViewModel.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/lib/features/registration/screens/phonenumber/PhoneNumberEntryViewModel.dart)
#### [NEW] [PhoneNumberEntryScreenEvents.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/lib/features/registration/screens/phonenumber/PhoneNumberEntryScreenEvents.dart)

---

### [Verification Code] - `screens/verificationcode/`

#### [NEW] [VerificationCodeState.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/lib/features/registration/screens/verificationcode/VerificationCodeState.dart)
#### [NEW] [VerificationCodeScreen.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/lib/features/registration/screens/verificationcode/VerificationCodeScreen.dart)
#### [NEW] [VerificationCodeViewModel.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/lib/features/registration/screens/verificationcode/VerificationCodeViewModel.dart)
#### [NEW] [VerificationCodeScreenEvents.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/lib/features/registration/screens/verificationcode/VerificationCodeScreenEvents.dart)

---

### [App Integration]

#### [router.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/lib/app/router.dart)
- Update routes to point to the new identical screen structure.

#### [locator.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/lib/app/locator.dart)
- Register all new ViewModels and Repositories.

## Verification Plan

### Manual Verification
- **File System Check**: Ensure directories and files exactly match the Signal Android structure.
- **Architectural Check**: Verify that `EventDrivenViewModel` is correctly implemented and used.
- **Navigation Flow**: Verify the flow: Welcome -> Phone Number -> Verification -> Profile.
- **UI Fidelity**: Compare layouts with Signal Android screens.
