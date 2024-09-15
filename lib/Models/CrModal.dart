class ClassReporter {
  final String profilePhoto;
  final String name;
  final String rollNumber;
  final String department;
  final String semester;
  final String session;

  ClassReporter({
    required this.profilePhoto,
    required this.name,
    required this.rollNumber,
    required this.department,
    required this.semester,
    required this.session,
  });

  factory ClassReporter.fromFirestore(Map<String, dynamic> data) {
    return ClassReporter(
      profilePhoto: data['profilePhoto'] ?? '',
      name: data['cr_name'] ?? '',
      rollNumber: data['roll_no'] ?? '',
      department: data['department'] ?? '',
      semester: data['semester'] ?? '',
      session: data['session'] ?? '',
    );
  }
}
