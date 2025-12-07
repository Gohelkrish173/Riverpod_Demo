
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_exercise/Faculty_CRUD_Using_RiverPod/controller/faculty_async_controller.dart';
import 'package:riverpod_exercise/Faculty_CRUD_Using_RiverPod/providers/filter_by_name_provider.dart';

// UI Screen
class FacultyListScreen extends ConsumerWidget {
  const FacultyListScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final FacultyAsync = ref.watch(filtered_Faculty_List);
    final FaculyAsync = ref.watch(faculty_async_notifier_provider);
    final notifier = ref.watch(faculty_async_notifier_provider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text('Faculty List',),),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: "Search Name"
                    ),
                    onChanged: (t){
                      ref.read(filterTextProvider.notifier).state = t;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Expanded(
              child: ListView.builder(
                itemCount: FacultyAsync.length,
                itemBuilder: (_, i) {
                  final faculty = FacultyAsync[i];
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.only(top: 4,bottom: 4,left: 20,right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${faculty.Name}',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('FacultyId : ${faculty.FacId}',
                                style: TextStyle(fontSize: 12),
                              ),
                              Text('Department : ${faculty.Dept}',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Salary : ${faculty.Salary}',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              IconButton(
                                onPressed: (){
                                  notifier.DeleteFaculty(faculty.id!);
                                },
                                icon: Icon(Icons.delete,color: Colors.red,),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


