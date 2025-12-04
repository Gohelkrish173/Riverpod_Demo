
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_exercise/Section2/FutureProviderDemo/student_Api_Service.dart';


// Riverpod Provider
final studentApiProvider = Provider((Ref ref)=>Student_Service());

final studentFutureProvider = FutureProvider((Ref ref) async{
  final service = ref.read(studentApiProvider);
  return await service.FetchAPI();
});

// UI

// ConsumerWidget is StatelessWidget
class StudentData_FutureProvider extends ConsumerWidget {
  const StudentData_FutureProvider({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final AsyncStudent = ref.watch(studentFutureProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Student Data"),),
      body: AsyncStudent.when(
        skipLoadingOnReload: false,
        data: (stu) => ListView.builder(
          padding: EdgeInsets.all(2),
          itemBuilder: (context, index) {
            final item = stu[index];
            return Card(
              child: Column(
                children: [
                  Text("${item.id}"),
                  Text(item.name),
                  Text(item.ENRNO),
                  Text("${item.TotalMarks}"),
                ],
              ),
            );
          },
          itemCount: stu.length,
        ),
        error: (error,stackTrace) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Error: $error',style: const TextStyle(color: Colors.red),),
            const SizedBox(height: 12,),
            ElevatedButton(
              // it is re-run the a Provider and reset it's state.
              onPressed: () => ref.refresh(studentFutureProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
        loading: ()=> CircularProgressIndicator()
      ),
    );
  }
}
