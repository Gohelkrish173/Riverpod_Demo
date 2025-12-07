import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_exercise/Faculty_CRUD_Using_RiverPod/Model/faculty_model.dart';
import 'package:riverpod_exercise/Faculty_CRUD_Using_RiverPod/Services/faculty_service.dart';
import 'package:riverpod_exercise/Faculty_CRUD_Using_RiverPod/controller/faculty_state_notifier_controller.dart';
import 'package:riverpod_exercise/Faculty_CRUD_Using_RiverPod/providers/faculty_by_id_provider.dart';

// Provider
final faculty_service = Provider((_)=>FacultyService());

// UI Screen

class FacultyFormScreen extends ConsumerStatefulWidget {
  final Object? id;
  const FacultyFormScreen({this.id,super.key});

  @override
  ConsumerState<FacultyFormScreen> createState() => _FacultyFormScreenState();
}

class _FacultyFormScreenState extends ConsumerState<FacultyFormScreen> {
  final nameController = TextEditingController();
  final deptController = TextEditingController();
  final facIdController = TextEditingController();
  final salaryController = TextEditingController();

  String responce = "";

  @override
  void initState() {
    final fac = ref.read(facById_FutureProvider(widget.id!)).maybeWhen(
        data: (data)=>data,
        orElse: ()=>FacultyModel(Name: '', FacId: 0, Dept: '', Salary: 0)
    );
    nameController.text = fac.Name;
    deptController.text = fac.Dept;
    facIdController.text = fac.FacId.toString();
    salaryController.text = fac.Salary.toString();
  }

  @override
  void dispose() {
    nameController.dispose();
    deptController.dispose();
    facIdController.dispose();
    salaryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(faculty_state_notifier_provider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text('Faculty Form'),),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            responce == '' ? Text('') : Text(responce,style: TextStyle(color: Colors.red),),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Enter Name',
              ),
            ),
            SizedBox(height: 8,),
            TextField(
              controller: deptController,
              decoration: InputDecoration(
                labelText: 'Enter Department',
              ),
            ),
            SizedBox(height: 8,),
            TextField(
              controller: facIdController,
              decoration: InputDecoration(
                labelText: 'Enter Faculty Id',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 8,),
            TextField(
              controller: salaryController,
              decoration: InputDecoration(
                labelText: 'Enter Salary',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async {
                    notifier.updateName(nameController.text);
                    notifier.updateDept(deptController.text);
                    notifier.updateFacId(facIdController.text);
                    notifier.updateSalary(salaryController.text);

                    bool result = false;

                    if(widget.id != null){
                      result = await notifier.UpdateFaculty(widget.id!);
                    }
                    else{
                      result = await notifier.InsertFaculty();
                    }

                    if(result){
                      nameController.clear();
                      deptController.clear();
                      facIdController.clear();
                      salaryController.clear();

                      Navigator.of(context).pop();
                    }

                    else{
                      responce = "Operation Failed.";
                    }
                  },
                  icon: Icon(Icons.save,size: 16,),
                ),
                SizedBox(width: 8,),
                IconButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.cancel_outlined,size: 16,),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
