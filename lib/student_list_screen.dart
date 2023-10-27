import 'package:flutter/material.dart';
import 'package:students_details_form/database_helper.dart';
import 'package:students_details_form/edit_student_form_screen.dart';
import 'package:students_details_form/main.dart';
import 'package:students_details_form/optimized_student_form_screen.dart';
import 'package:students_details_form/student_details_model.dart';
import 'package:students_details_form/student_form_screen.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  late List<StudentDetailsModel> _studentDetailsList;

  @override
  void initState() {
    super.initState();
    getAllStudentDetails();
  }

  getAllStudentDetails() async {
    _studentDetailsList = <StudentDetailsModel>[];
    var studentDetailRecords =
        await dbHelper.queryAllRows(DatabaseHelper.studentDetailsTable);

    studentDetailRecords.forEach((studentDetail) {
      setState(() {
        print(studentDetail['_id']);
        print(studentDetail['_studentName']);
        print(studentDetail['_mobileNo']);
        print(studentDetail['_emailId']);

        var studentDetailsModel = StudentDetailsModel(
            studentDetail['_id'],
            studentDetail['_studentName'],
            studentDetail['_mobileNo'],
            studentDetail['_emailId']
      );
      _studentDetailsList.add(studentDetailsModel);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Student Details'),
      ),
      body: Container(
        child: ListView.builder(itemCount:_studentDetailsList.length,
            itemBuilder: (BuildContext context,int index){
          return InkWell(
            onTap: (){
              print('---------->Edit or Deleted Invoked : Send Data');
              print(_studentDetailsList[index].id);
              print(_studentDetailsList[index].studentName);
              print(_studentDetailsList[index].studentMobileNo);
              print(_studentDetailsList[index].studentEmailID);

              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>OptimizedStudentFormScreen(),
              settings: RouteSettings(
                arguments: _studentDetailsList[index],
              ),));
            },
            child: ListTile(
              title: Text(_studentDetailsList[index].studentName),

            ),
          );

        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('--------------> Launch Student Details Form Screen');
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => OptimizedStudentFormScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
