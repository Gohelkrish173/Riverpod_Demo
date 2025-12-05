import 'package:riverpod_exercise/Section2/FutureProviderDemo/StudentModel.dart';

class Student_Model extends StudentModel{
  // pass the value in StudentModel Constructor via super keyword
  Student_Model({
    super.id,
    required super.name,
    required super.ENRNO,
    required super.TotalMarks
  });

  // CopyWith Method for create new Instance with Changed value
  Student_Model copyWith({String? id, String? name, String? ENRNO, double? TotalMarks}){
    return Student_Model(
      id: id ?? this.id,
      name: name ?? this.name,
      ENRNO: ENRNO ?? this.ENRNO,
      TotalMarks: TotalMarks ?? this.TotalMarks
    );
  }

}