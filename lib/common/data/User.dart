import 'package:grades/common/data/GPAData.dart';
import 'package:studentvueclient/studentvueclient.dart';

import 'History.dart';
import 'Period.dart';

class User {
  String name;
  List<Period> periods;
  List<Assignment> assignments;
  double? initialCumGPA;
  double? creditsTaken;
  int absences;
  List<History> history; // Assuming history can be any dynamic type

  User({
    required this.name,
    required this.periods,
    required this.assignments,
    required this.history,
    required this.absences,
    this.initialCumGPA,
    this.creditsTaken,

  });

  // Neat and organized toString method
  @override
  String toString() {
    return '''
User: 
  Name: $name
  Absences: $absences
  Initial GPA: $initialCumGPA
  Credits Taken: $creditsTaken
  Periods: 
${periods.map((p) => '    ${p.toString()}').join('\n')}
  Assignments: 
${assignments.map((a) => '    ${a.toString()}').join('\n')}
  Assignments: 
${history.map((h) => '    ${h.toString()}').join('\n')}
''';
  }

  // Convert User object to a Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'absences': absences,
      'initialCumGPA': initialCumGPA,
      'creditsTaken': creditsTaken,
      'periods': periods.map((p) => p.toMap()).toList(),
      'assignments': assignments.map((a) => a.toMap()).toList(),
      'history': history.map((h) => h.toMap()).toList(),
    };
  }

  // Convert Map to a User object
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] ?? '',
      absences: map['absences'] ?? 0,
      initialCumGPA: map['initialCumGPA'] ?? -1.0,
      creditsTaken: map['creditsTaken'] ?? -1.0,
      periods: List<Period>.from(
          map['periods']?.map((p) => Period.fromMap(p)) ?? []),
      assignments: List<Assignment>.from(
          map['assignments']?.map((a) => Assignment.fromMap(a)) ?? []),
      history: List<History>.from(
          map['history']?.map((h) => History.fromMap(h)) ?? []),
    );
  }
}
