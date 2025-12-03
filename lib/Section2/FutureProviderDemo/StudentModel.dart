
class StudentModel{
  int? id;
  String name;
  String ENRNO;
  double TotalMarks;

  StudentModel({
    this.id,
    required this.name,
    required this.ENRNO,
    required this.TotalMarks,
  });

  // create a Student Instance from Json
  factory StudentModel.fromJson(Map<String,dynamic> json){
    return StudentModel(
      id : json['id'],
      name: json['name'],
      ENRNO: json['ENRNO'],
      TotalMarks: json['TotalMarks']
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'id' : this.id,
      'name' : this.name,
      'ENRNO' : this.ENRNO,
      'TotalMarks' : this.TotalMarks
    };
  }

  // static Student List From JsonList
  static List<StudentModel> listStudent(List<dynamic> jsonList){
    return jsonList.map((json)=>StudentModel.fromJson(json)).toList();
  }
}