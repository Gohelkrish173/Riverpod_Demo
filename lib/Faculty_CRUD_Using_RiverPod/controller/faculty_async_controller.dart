
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_exercise/Faculty_CRUD_Using_RiverPod/Model/faculty_model.dart';
import 'package:riverpod_exercise/Faculty_CRUD_Using_RiverPod/Services/faculty_service.dart';

final faculty_service_provider = Provider((_)=>FacultyService());

final faculty_async_notifier_provider = AsyncNotifierProvider<FacultyAsyncNotifier,List<FacultyModel>>(
  (){
    return FacultyAsyncNotifier();
  }
);

class FacultyAsyncNotifier extends AsyncNotifier<List<FacultyModel>>{
  late List<FacultyModel> list;

  @override
  FutureOr<List<FacultyModel>> build() async{
    list = await ref.read(faculty_service_provider).FetchData();
    return list;
  }

  Future<void> DeleteFaculty(Object id) async{
    try{
      bool res = await ref.read(faculty_service_provider).DeleteData(id);

      if(res){
        state = AsyncValue.data(list.where((t)=>t.id != id).toList());
        list = state.maybeWhen(
          data: (data)=> data,
          orElse: ()=>[]
        );
      }
    }
    catch(e){
      state = AsyncValue.error(e,StackTrace.current);
    }
  }

  // when FacultyUpdated change that object using this method
  Future<void> UpdateFaculty_In_AsyncList(FacultyModel fac) async{
    try{
      list = list.map((t)=>t.id == fac.id ? fac : t).toList();

      state = AsyncValue.data(list);
    }
    catch(e){
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  // when FacultyInserted then add that Faculty in AsyncList using this method
  Future<void> AddFaculty_In_AsyncList() async{
    try{
      list = await ref.read(faculty_service_provider).FetchData();

      state = AsyncValue.data(list);
    }
    catch(e){
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

}