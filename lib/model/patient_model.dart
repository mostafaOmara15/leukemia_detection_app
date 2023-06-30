class PatientModel {
  String? name;
  String? age;
  String? nationalId;
  String? gender;
  String? testDate;
  String? testTime;
  String? testResult;
  String? examiner;
  String? examinerComment;
  String? bloodSample;

  PatientModel({
    required this.name,
    required this.age,
    required this.testDate,
    required this.testTime,
    required this.nationalId,
    required this.gender,
    this.testResult,
    this.examiner,
    this.examinerComment,
    this.bloodSample,
  });

  PatientModel.fromJson(Map<String, dynamic>? json){
    name = json!['name'];
    age = json!['age'];
    nationalId = json!['nationalId'];
    testDate = json!['testDate'];
    testTime = json!['testTime'];
    gender = json!['gender'];
    testResult = json!['testResult'];
    examiner = json!['examiner'];
    examinerComment = json!['examinerComment'];
    bloodSample = json!['bloodSample'];
  }

  Map<String, dynamic> toMap(){
    return {
      'name' : name,
      'age' : age,
      'nationalId' : nationalId,
      'testDate' : testDate,
      'testTime' : testTime,
      'gender' : gender,
      'testResult' : testResult,
      'examiner' : examiner,
      'examinerComment' : examinerComment,
      'bloodSample' : bloodSample,
    };
  }
}