
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:riverpod_exercise/Faculty_CRUD_Using_RiverPod/Model/faculty_model.dart';
import 'package:riverpod_exercise/Faculty_CRUD_Using_RiverPod/Services/faculty_service.dart';
import 'package:riverpod_exercise/Faculty_CRUD_Using_RiverPod/controller/faculty_async_controller.dart';

final faculty_service = Provider((_)=>FacultyService());

// final Faculty_List_Provider = FutureProvider<List<FacultyModel>>(
//     (ref){
//       return ref.watch(faculty_service).FetchData();
//     }
// );

final Faculty_List_Provider = Provider<AsyncValue<List<FacultyModel>>>(
    (ref){
      return ref.watch(faculty_async_notifier_provider);
    }
);

final filterTextProvider = StateProvider<String>((_){
  return '';
});

final filtered_Faculty_List = Provider<List<FacultyModel>>((ref){
  // for continues watching Faculty_List_Provider therefore if any change in
  // Faculty_List_Provider then it auto Change in Screen.
  final list = ref.watch(Faculty_List_Provider);
  final filter = ref.watch(filterTextProvider);

  if(filter.isEmpty){
    return list.maybeWhen(
      data: (data)=>data,
      orElse: () => []
    );
  }

  return list.maybeWhen(
    data: (data) => data.where((t) => t.Name.toLowerCase().contains(filter.toLowerCase())).toList(),
    orElse: () => []
  );

});