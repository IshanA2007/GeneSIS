import 'ClassData.dart';

class Period {
  int periodNum;
  List<ClassData> classData;

  Period({
    required this.periodNum,
    required this.classData,
  });

  // Neat and organized toString method
  @override
  String toString() {
    return '''
Period: $periodNum
    Class Data: 
${classData.map((c) => '    ${c.toString()}').join('\n')}
''';
  }

  // Convert Period object to a Map
  Map<String, dynamic> toMap() {
    return {
      'periodNum': periodNum,
      'classData': classData.map((c) => c.toMap()).toList(),
    };
  }

  // Convert Map to a Period object
  factory Period.fromMap(Map<String, dynamic> map) {
    return Period(
      periodNum: map['periodNum'] ?? 0,
      classData: List<ClassData>.from(
          map['classData']?.map((c) => ClassData.fromMap(c)) ?? []),
    );
  }
}
