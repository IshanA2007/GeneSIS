class GPAData {
  DateTime dataDate;
  double gpa;

  GPAData(this.gpa) : dataDate = DateTime.now();

  @override
  String toString(){
    return '$gpa earned at $dataDate';
  }

  // Method to serialize the object into a Map
  Map<String, dynamic> toMap() {
    return {
      'dataDate': dataDate.toIso8601String(),
      'gpa': gpa,
    };
  }

  // Factory constructor to create GPAData from a Map (i have no idea what a factory is)
  factory GPAData.fromMap(Map<String, dynamic> map) {
    return GPAData(
      map['gpa'],
    )..dataDate = DateTime.parse(map['dataDate']);
  }
}