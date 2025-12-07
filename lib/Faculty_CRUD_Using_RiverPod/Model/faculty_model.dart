
class FacultyModel{
  Object? id;
  String Name;
  int FacId;
  String Dept;
  double Salary;

  FacultyModel({
    this.id,
    required this.Name,
    required this.FacId,
    required this.Dept,
    required this.Salary
  });

  // factory Constructor for json to FacultyModel
  factory FacultyModel.fromJson(Map<String,dynamic> json){
    return FacultyModel(
      id: json['_id'],
      Name: json['Name'],
      FacId: json['FacId'],
      Dept: json['Dept'],
      Salary: json['Salary']
    );
  }

  // Convert MOdel to json
  Map<String,dynamic> toJson(){
    return {
      '_id' : this.id,
      'Name' : this.Name,
      'FacId' : this.FacId,
      'Dept' : this.Dept,
      'Salary' : this.Salary
    };
  }

  //Static list convert jsonList to ModelList
  static List<FacultyModel> ListFaculty(List<dynamic> jsonList){
    return jsonList.map((t)=>FacultyModel.fromJson(t)).toList();
  }

  // CopyWith mehtod
  FacultyModel copyWith({Object? id,String? Name,int? FacId,String? Dept,double? Salary}){
    return FacultyModel(
      id: id ?? this.id,
      Name: Name ?? this.Name,
      FacId: FacId ?? this.FacId,
      Dept: Dept ?? this.Dept,
      Salary: Salary ?? this.Salary,
    );
  }
  
}