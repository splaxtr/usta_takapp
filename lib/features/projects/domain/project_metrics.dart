class ProjectSummaryStats {
  final int income;
  final int expense;

  const ProjectSummaryStats({required this.income, required this.expense});

  int get netBalance => income - expense;
}

class WorkerProjectStats {
  final int totalDays;
  final int totalCost;

  const WorkerProjectStats({required this.totalDays, required this.totalCost});
}
