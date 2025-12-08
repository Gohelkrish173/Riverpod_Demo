
import 'dart:convert';
import 'dart:ui';

import 'package:flutter_riverpod/legacy.dart';
import 'package:riverpod_exercise/Faculty_CRUD_Using_RiverPod/Model/faculty_model.dart';
import 'package:riverpod_exercise/Faculty_CRUD_Using_RiverPod/Services/faculty_service.dart';
import 'package:riverpod_exercise/Faculty_CRUD_Using_RiverPod/controller/faculty_async_controller.dart';

// Create StateNotifier

final faculty_state_notifier_provider = StateNotifierProvider<FacultyStateNotifier,FacultyModel>(
    (ref){
      return FacultyStateNotifier(ref,FacultyService(),
          FacultyModel(Name: "", FacId: 0, Dept: "", Salary: 0)
      );
    }
);

// FacultyStateNotifier Contoller Logic
// in StateNotifier ref not directly like AsyncNotifier
class FacultyStateNotifier extends StateNotifier<FacultyModel>{
  final FacultyService service;
  final ref;

  FacultyStateNotifier(this.ref,this.service,super.state);

  void updateName(String name){
    state = state.copyWith(Name: name.trim());
  }

  void updateDept(String dept){
    state = state.copyWith(Dept: dept.trim());
  }

  void updateFacId(String FacId){
    state = state.copyWith(FacId: int.parse(FacId.trim()));
  }

  void updateSalary(String salary){
    state = state.copyWith(Salary: double.parse(salary.trim()));
  }

  bool _validate(){
    if(state.Name.trim().isEmpty){
      return false;
    }
    if(state.Dept.trim().isEmpty){
      return false;
    }
    if(state.FacId < 0 || state.FacId == null){
      return false;
    }
    if(state.Salary < 0 || state.Salary == null){
      return false;
    }

    return true;
  }

  Future<bool> InsertFaculty() async {
    if(!_validate()) return false;

    try{
      final model = FacultyModel(
        Name: state.Name,
        FacId: state.FacId,
        Dept: state.Dept,
        Salary: state.Salary
      );

      dynamic json = model.toJson();

      String encoded = jsonEncode(json);

      final result = await service.InsertData(encoded);

      if(result) {

        await ref.watch(faculty_async_notifier_provider.notifier)
        .AddFaculty_In_AsyncList();

        state = FacultyModel(Name: "", FacId: 0, Dept: "", Salary: 0);

        return true;
      }

      return false;
    }
    catch(e){
      print("======================================================$e");
      return false;
    }
  }

  Future<bool> UpdateFaculty(Object id) async{
    if(!_validate()) return false;

    try{
      final model = FacultyModel(
          id: id,
          Name: state.Name,
          FacId: state.FacId,
          Dept: state.Dept,
          Salary: state.Salary
      );

      dynamic json = model.toJson();

      String encoded = jsonEncode(json);

      final result = await service.UpdateData(id, encoded);

      if(result) {
        // clear the State
        await ref.watch(faculty_async_notifier_provider.notifier)
            .UpdateFaculty_In_AsyncList(model);
        state = FacultyModel(Name: "", FacId: 0, Dept: "", Salary: 0);
        return true;
      }

      return false;
    }
    catch(e){
      print("======================================================$e");
      return false;
    }
  }
}