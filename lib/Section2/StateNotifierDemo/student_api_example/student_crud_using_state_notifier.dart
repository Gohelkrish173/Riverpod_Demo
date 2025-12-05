
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_exercise/Section2/StateNotifierDemo/student_api_example/student_model.dart';
import 'package:riverpod_exercise/Section2/StateNotifierDemo/student_api_example/student_provider_controller.dart';

class StudentCrudUsingStateNotifier extends ConsumerStatefulWidget {
  const StudentCrudUsingStateNotifier({super.key});

  @override
  ConsumerState<StudentCrudUsingStateNotifier> createState() => _StudentCrudUsingStateNotifierState();
}

class _StudentCrudUsingStateNotifierState extends ConsumerState<StudentCrudUsingStateNotifier> {
  final nameController = TextEditingController();
  final enrController = TextEditingController();
  final tmController = TextEditingController();
  String Id = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      ref.read(studentListProvider.notifier).LoadData();
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    enrController.dispose();
    tmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final studentList = ref.watch(studentListProvider);
    final notifier = ref.read(studentListProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text("Student CRUD"),),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text Fields
            Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Name"),
                ),
                SizedBox(height: 5,),
                TextField(
                  controller: enrController,
                  decoration: const InputDecoration(labelText: "ENRNO"),
                ),
                SizedBox(height: 5,),
                TextField(
                  controller: tmController,
                  decoration: const InputDecoration(labelText: "TotalMarks"),
                ),
                SizedBox(height: 5,),
                IconButton(
                  onPressed: () {
                    Student_Model S = Student_Model(
                      name: nameController.text.trim(),
                      ENRNO: enrController.text.trim(),
                      TotalMarks: double.parse(tmController.text.trim())
                    );

                    //Insert Method
                    Id == "" ? notifier.Insert(S) : notifier.Update(S,Id);

                    //Clean All Controller after add or update
                    nameController.clear();
                    tmController.clear();
                    enrController.clear();
                    Id = "";
                  },
                  icon: Icon(Icons.add)
                ),
              ],
            ),

            SizedBox(height: 10,),

            Expanded(
              child: ListView.builder(
                itemCount: studentList.length,
                itemBuilder: (_, i) {
                  final student = studentList[i];
                  return Card(
                    child: Column(
                      children: [
                        Text(
                          "${student.name}",
                          style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 4,),
                        Text(
                          "ENR No : ${student.ENRNO}",
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(height: 4,),
                        Row(
                          children: [
                            Text(
                              "TotalMarks : ${student.TotalMarks}",
                              style: TextStyle(fontSize: 12),
                            ),
                            IconButton(
                                onPressed: () {
                                  print(student.id);
                                  Id = student.id ?? "";
                                  nameController.text = student.name;
                                  enrController.text = student.ENRNO;
                                  tmController.text = student.TotalMarks.toString();
                                },
                                icon: Icon(Icons.edit,color: Colors.orangeAccent,)
                            ),
                            IconButton(
                                onPressed: () {
                                  notifier.Delete(student.id!);
                                },
                                icon: Icon(Icons.delete,color: Colors.red,),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              )
            ),
          ],
        ),
      ),
    );
  }
}
