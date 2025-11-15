class ProjectSummary {
  final int income;
  final int expense;
  final int workerCost;
  final int payrollPaid;
  final int debt;
  final int budget;

  const ProjectSummary({
    required this.income,
    required this.expense,
    required this.workerCost,
    required this.payrollPaid,
    required this.debt,
    required this.budget,
  });

  int get totalCost => expense + workerCost + debt;
  int get net => income - totalCost;
  double get progress => budget > 0 ? totalCost / budget : 0;
}
