# Walkthrough: Professional Job System (Chaining & Concurrency)

This document summarizes the refactoring of the **SigmaJobManager** to support advanced job chaining and robust concurrency control, bringing it to a level of resilience comparable to Signal/Telegram.

## Changes Overview

### 1. Job Chaining (Job Chains)
We implemented a fluent API to chain background tasks, ensuring they run in a specific order only after the previous task succeeds.

- **[JobChain](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/packages/sigma_core/lib/src/jobs/job_chain.dart)**: A new class that allows building sequences like `JobA.then(JobB).then(JobC)`.
- **[SigmaJobManager.addChain](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/packages/sigma_core/lib/src/jobs/job_manager.dart)**: Processes a chain by linking jobs via `nextJobKey` and `nextJobData`.
- **Login Flow Example**: In **[LoginInteractor](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/packages/sigma_auth/lib/src/domain/interactors/login_interactor.dart)**, we now use a chain: `PushKeysUploadJob -> FetchProfileJob -> SyncContactsJob`.

### 2. Concurrency Control (Single Queue)
To prevent database locks and race conditions when multiple developers add jobs simultaneously, we improved the execution loop.

- **Sequential Execution**: The job manager now uses a strictly sequential loop (`await _runJob(...)`) instead of firing multiple futures in parallel.
- **Processing Lock**: A boolean flag `_isProcessing` ensures only one instance of the processing loop runs at any time, even if `_processPendingJobs` is called frequently.
- **Robust Error Handling**: Added a `try-catch` around the entire loop to prevent the manager from crashing due to unexpected database errors.

### 3. New Background Tasks
- **[SyncContactsJob](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/packages/sigma_contacts/lib/src/data/jobs/contacts/sync_contacts_job.dart)**: A new job to handle contact synchronization, integrated into the login chain.

## Technical Justification
- **Atomicity**: By chaining jobs, we ensure that critical setup steps (like uploading keys) happen before secondary steps (like fetching profiles).
- **Database Integrity**: SQLite/Drift performs better with sequential writes. The "Single Queue" pattern eliminates "database is locked" errors during high activity.
- **Scalability**: This architecture allows developers to add complex multi-step background processes without worrying about race conditions.

## Verification Summary
- **Dependency Injection**: Registered `SyncContactsJob` in [locator.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/lib/app/locator.dart).
- **Exports**: Updated `sigma_contacts.dart` to export the new job.
- **Consistency**: Verified that existing jobs (Text/Media send) still work within the new sequential framework.
