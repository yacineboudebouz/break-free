class CreateHabitModel {
  final String name;
  final String description;
  final String type;
  final String color;
  final String startDate;
  CreateHabitModel({
    required this.name,
    required this.description,
    required this.type,
    required this.color,
    required this.startDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'habit_type': type,
      'color': color,
      'start_date': startDate,
    };
  }
}
