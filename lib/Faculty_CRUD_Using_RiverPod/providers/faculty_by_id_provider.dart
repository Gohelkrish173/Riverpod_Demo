
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_exercise/Faculty_CRUD_Using_RiverPod/Model/faculty_model.dart';
import 'package:riverpod_exercise/Faculty_CRUD_Using_RiverPod/Services/faculty_service.dart';

final facultyService = Provider((_)=>FacultyService());

final facById_FutureProvider = FutureProvider.family<FacultyModel,Object>((ref,id){
  return ref.read(facultyService).FetchDataById(id);
});