import 'package:flutter_riverpod/legacy.dart';
import 'package:riverpod_exercise/Section2/FutureProviderDemo/student_Api_Service.dart';
import 'package:riverpod_exercise/Section2/StateNotifierDemo/student_api_example/student_model.dart';

// StateNotifier
final studentListProvider = StateNotifierProvider<StudentNotifier,List<Student_Model>>(
   (ref) => StudentNotifier(Student_Service(), []),
);

// class

class StudentNotifier extends StateNotifier<List<Student_Model>>{
  final Student_Service service;

  StudentNotifier(this.service,super.state);

  String API = "https://64fca63a605a026163aeb538.mockapi.io/Student";

  Future<List<Student_Model>> LoadData() async{
    final list = await service.FetchAPI();
    
    List<Student_Model> slist =
    list.map((t)=> Student_Model(id: t.id,name: t.name, ENRNO: t.ENRNO, TotalMarks: t.TotalMarks)).toList();

    state = slist;

    return state;
  }

  Future<void> Insert(Student_Model s) async{
    final newStudent = Student_Model(
      name: s.name,
      ENRNO: s.ENRNO,
      TotalMarks: s.TotalMarks
    );

    final bool result = await service.InsertData(newStudent);

    if(!result){
      return ;
    }

    state = [...state,newStudent];
  }

  Future<void> Update(Student_Model s,String id) async{
    final students = [...state];

    print("${s.id}=${s.ENRNO}=${s.name}=${s.TotalMarks}");

    final index = students.indexWhere((t)=>t.id == id);

    if(index == -1) return;

    final Stu = students[index];

    Student_Model S = Stu.copyWith(id: id,name: s.name,ENRNO: s.ENRNO,TotalMarks: s.TotalMarks);

    print("${S.id}-${S.ENRNO}-${S.name}-${S.TotalMarks}");

    final bool result = await service.UpdateData(S);

    if(!result){
      return;
    }

    students[index] = S;
    state = students;
  }

  Future<void> Delete(String id) async{
    final bool result = await service.DeleteData(id);

    if(!result){
      return ;
    }

    state = state.where((t)=>t.id != id).toList();
  }

}