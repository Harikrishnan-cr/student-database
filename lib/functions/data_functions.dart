
// ignore_for_file: no_leading_underscores_for_local_identifiers, invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:database/data_model/data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';


ValueNotifier<List<StudentModel>>studentListnotifier = ValueNotifier([]);


Future <void> addStudent(StudentModel value) async{
  
  final studentDB = await Hive.openBox<StudentModel>('Student_db');
  final _id = await studentDB.add(value);
  value.id = _id;
 final data = StudentModel(
    id: _id,
    name: value.name, age: value.age, phone: value.phone, school: value.school, img: value.img);
    await studentDB.put(_id, data);
  studentListnotifier.value.add(data);
  studentListnotifier.notifyListeners();
}

Future <void> getAllStudents()async {
final studentDB = await Hive.openBox<StudentModel>('Student_db');
studentListnotifier.value.clear();
studentListnotifier.value.addAll(studentDB.values);
studentListnotifier.notifyListeners();
}


Future <void> deletStudent(int id) async{
final studentDB = await Hive.openBox<StudentModel>('Student_db');
 await studentDB.delete(id);
getAllStudents();
}

Future <void> updateStudentDataBase(StudentModel data) async{
  final studentDB = await Hive.openBox<StudentModel>('Student_db');
  await studentDB.put(data.id,data);
  studentListnotifier.notifyListeners();
  getAllStudents();

}

