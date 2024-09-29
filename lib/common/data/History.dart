import 'package:grades/common/data/GPAData.dart';

class History {
  String name;
  List<GPAData> history;

  History({
    required this.name,
    required this.history,
  });

  // Neat and organized toString method
  @override
  String toString() {
    return '''
Name: $name
    History: 
${history.map((c) => '    ${c.toString()}').join('\n')}
''';
  }

  // Convert History object to a Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'history': history.map((gpaData) => gpaData.toMap()).toList(),
    };
  }

  // Convert Map to a History object
  factory History.fromMap(Map<String, dynamic> map) {
    return History(
      name: map['name'] ?? "",
      history: List<GPAData>.from(
          map['history']?.map((gpaDataMap) => GPAData.fromMap(gpaDataMap)) ?? []
      ),
    );
  }
}
