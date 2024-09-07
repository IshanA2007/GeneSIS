class GenesisGradeCalculations {
  static String percentToLetter(double percent) {
    if (percent >= 92.5) return "A";
    if (percent >= 89.5) return "A-";
    if (percent >= 86.5) return "B+";
    if (percent >= 82.5) return "B";
    if (percent >= 79.5) return "B-";
    if (percent >= 76.5) return "C+";
    if (percent >= 72.5) return "C";
    if (percent >= 69.5) return "C-";
    if (percent >= 66.5) return "D+";
    if (percent >= 62.5) return "D";
    if (percent >= 59.5) return "D-";
    return "F";
  }

  static double percentify(double earned, double possible){
    return (earned/possible) * 100;
  }

  static String gpaBoostFromCourse(String course){
    if (course.contains("AP") || course.contains("AV")){
      return "1.0";
    }
    else if (course.contains("HN") || course.contains("Honors")){
      return "0.5";
    }
    return "0.0";
  }
}
