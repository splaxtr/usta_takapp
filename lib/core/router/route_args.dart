class EmployerFormArgs {
  final int? employerId;

  const EmployerFormArgs({this.employerId});
}

class EmployerDetailArgs {
  final int employerId;

  const EmployerDetailArgs({required this.employerId});
}

class ProjectFormArgs {
  final int? projectId;
  final int? employerId;

  const ProjectFormArgs({this.projectId, this.employerId});
}

class ProjectDetailArgs {
  final int projectId;

  const ProjectDetailArgs({required this.projectId});
}

class DebtFormArgs {
  final int? debtId;
  final int? employerId;
  final int? projectId;

  const DebtFormArgs({this.debtId, this.employerId, this.projectId});
}

class DebtDetailArgs {
  final int debtId;

  const DebtDetailArgs({required this.debtId});
}

class WorkerFormArgs {
  final int? workerId;

  const WorkerFormArgs({this.workerId});
}

class WorkerDetailArgs {
  final int workerId;

  const WorkerDetailArgs({required this.workerId});
}

class TransactionFormArgs {
  final int? transactionId;

  const TransactionFormArgs({this.transactionId});
}

class PaymentFormArgs {
  final int? paymentId;
  final int workerId;
  final int? projectId;

  const PaymentFormArgs({
    this.paymentId,
    required this.workerId,
    this.projectId,
  });
}
