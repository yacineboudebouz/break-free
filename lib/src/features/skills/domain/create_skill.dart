class CreateSkillModel {
  final String name;
  final DateTime startDate;
  final String description;
  final String color;
  final int targetHours;

  CreateSkillModel({
    required this.name,
    required this.startDate,
    required this.description,
    required this.color,
    required this.targetHours,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'start_date': startDate.toIso8601String(),
      'description': description,
      'color': color,
      'target_hours': targetHours,
    };
  }
}
