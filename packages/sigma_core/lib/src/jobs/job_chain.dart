import 'job.dart';

/// JobChain - Permite o encadeamento fluente de tarefas.
/// Ex: LoginJob().then(FetchProfileJob()).then(SyncContactsJob())
class JobChain {
  final List<Job> _jobs = [];

  JobChain(Job initialJob) {
    _jobs.add(initialJob);
  }

  JobChain then(Job nextJob) {
    _jobs.add(nextJob);
    return this;
  }

  List<Job> build() => List.unmodifiable(_jobs);
}

extension JobChainExtension on Job {
  JobChain then(Job nextJob) => JobChain(this).then(nextJob);
}
