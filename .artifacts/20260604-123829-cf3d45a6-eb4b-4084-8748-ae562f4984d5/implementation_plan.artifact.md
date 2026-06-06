# Implementation Plan: Pure Use Cases & UI-Only ViewModels

This plan outlines the refactoring of ViewModels to remove business logic, moving it into pure Interactors/Use Cases. This ensures that ViewModels only handle UI state (loading, error, data) and facilitates expansion to other platforms (App, Web, Tablet).

## User Review Required

- **New Interactors**: I will create several new interactors in `sigma_auth` to handle logic previously residing in `AuthViewModel` and `PhoneNumberEntryViewModel`.
- **AuthViewModel Simplification**: `AuthViewModel` will be significantly reduced in complexity, delegating account creation, verification handling, and initialization to specialized interactors.

## Proposed Changes

---

### [sigma_auth] Domain Layer (Interactors)

Create pure Use Case classes to handle business logic.

#### [NEW] [login_interactor.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/packages/sigma_auth/lib/src/domain/interactors/auth/login_interactor.dart)
- Handle post-login logic:
    - Connecting to Socket.
    - Key generation.
    - Enqueuing `PushKeysUploadJob`.

#### [NEW] [logout_interactor.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/packages/sigma_auth/lib/src/domain/interactors/auth/logout_interactor.dart)
- Handle logout logic:
    - Disconnecting socket (optional).
    - Repository logout.

#### [NEW] [verify_code_interactor.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/packages/sigma_auth/lib/src/domain/interactors/auth/verify_code_interactor.dart)
- Handle verification code check logic:
    - Calling repository.
    - Deciding between new user or returning user.

#### [NEW] [create_account_interactor.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/packages/sigma_auth/lib/src/domain/interactors/auth/create_account_interactor.dart)
- Handle new account registration logic:
    - Calling `RegistrationRepository`.
    - Saving session.
    - Updating profile via `UpdateProfileInteractor`.

---

### [sigma_auth] Presentation Layer (ViewModels)

Refactor ViewModels to focus only on UI state management.

#### [auth_viewmodel.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/packages/sigma_auth/lib/src/presentation/screens/profilesetup/viewmodels/auth_viewmodel.dart)
- Delegate login, logout, and account creation to new Interactors.
- Keep state for `AuthStatus`, `Recipient`, and setup flags.

#### [phone_number_entry_view_model.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/packages/sigma_auth/lib/src/presentation/screens/phonenumber/phone_number_entry_view_model.dart)
- Move phone submission logic (session creation + SMS request) to a new `RequestVerificationInteractor`.

#### [verification_code_view_model.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/packages/sigma_auth/lib/src/presentation/screens/verificationcode/verification_code_view_model.dart)
- Move code verification and resend logic to Interactors.

---

### [sigma_chat] Presentation Layer (ViewModels)

#### [chat_viewmodel.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/packages/sigma_chat/lib/src/presentation/viewmodels/chat_viewmodel.dart)
- Review for any direct repository calls that should be interactors (e.g., `markAsRead`, `archiveThread`, `pinThread`).
- Create specialized interactors for these actions.

---

### [sigma_core] Dependency Injection

#### [locator.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/lib/app/locator.dart)
- Register all new Interactors and update ViewModel registrations.

## Verification Plan

### Automated Tests
- Since there are no existing unit tests for these ViewModels/Interactors, I will verify by ensuring the project builds and runs.
- `flutter build apk` (or similar build command for the module).

### Manual Verification
1. **Authentication Flow**: Run the app and go through the login flow. Ensure that session creation, verification, and profile setup still work correctly.
2. **Chat Operations**: Perform operations like pinning, archiving, and marking as read in the chat list. Verify that the UI reflects these changes instantly and the database is updated.
3. **Username Availability**: Verify that the username check still works during profile setup.
