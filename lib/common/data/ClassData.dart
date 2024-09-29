import 'package:studentvueclient/studentvueclient.dart';

class ClassData {
  String durationCode;
  String courseName;
  String gradebookCode;
  List<Assignment> assignments;
  double percent;
  List<AssignmentCategory> categories;

  ClassData({
    required this.durationCode,
    required this.courseName,
    required this.percent,
    required this.gradebookCode,
    required this.assignments,
    required this.categories,
  });

  // Neat and organized toString method
  @override
  String toString() {
    return '''
  Duration Code: $durationCode
      Course Name: $courseName
      Percent: $percent
      Gradebook Code: $gradebookCode
      Categories: 
    ${categories.map((a) => '    ${a.toString()}').join('\n    ')}
      Assignments: 
    ${assignments.map((a) => '    ${a.toString()}').join('\n    ')}
''';
  }

  // Convert ClassData object to a Map
  Map<String, dynamic> toMap() {
    return {
      'durationCode': durationCode,
      'courseName': courseName,
      'gradebookCode': gradebookCode,
      'assignments': assignments.map((a) => a.toMap()).toList(),
      'categories': categories.map((a) => a.toMap()).toList(),
      'percent': percent,
    };
  }

  // Convert Map to a ClassData object
  factory ClassData.fromMap(Map<String, dynamic> map) {
    return ClassData(
      durationCode: map['durationCode'] ?? '',
      courseName: map['courseName'] ?? '',
      gradebookCode: map['gradebookCode'] ?? '',
      assignments: List<Assignment>.from(
          map['assignments']?.map((a) => Assignment.fromMap(a)) ?? []),
      categories: List<AssignmentCategory>.from(
          map['categories']?.map((a) => AssignmentCategory.fromMap(a)) ?? []),
      percent: map['percent'],
    );
  }
}
