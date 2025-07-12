class Employee {
  final String name;
  final String? position;
  final String? department;
  final String avatar;

  Employee({
    required this.name,
    required this.avatar,
    this.position,
    this.department,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      name: json['name'],
      avatar: json['avatar'],
      position: json['position'],
      department: json['department'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'avatar': avatar,
      'position': position,
      'department': department,
    };
  }
}