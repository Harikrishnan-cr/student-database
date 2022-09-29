
import 'dart:io';

import 'package:database/screens/home_add_details_screen.dart';
import 'package:database/functions/data_functions.dart';
import 'package:database/data_model/data_model.dart';
import 'package:database/screens/fulldeatil.dart';
import 'package:database/screens/search.dart';
import 'package:database/screens/update.dart';
import 'package:flutter/material.dart';

// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

class StudentListScreen extends StatelessWidget {
  const StudentListScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context){
    getAllStudents(); 
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Data-Base'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 145, 22, 13),
        actions: [
          IconButton(onPressed: (){
            showSearch(context: context, delegate: NameSearch());
          }, icon: const Icon(Icons.search))
        ]
      ),
      body:ValueListenableBuilder(
        valueListenable: studentListnotifier, 
      builder: (BuildContext ctx, List <StudentModel> studentList , child) => ListView.separated(
        itemBuilder: (ctx, index) {
final data = studentList[index];
return ListTile(
  leading: CircleAvatar(
    // ignore: unnecessary_null_comparison
    backgroundImage: (data.img!=null) ? FileImage(File(data.img)) as ImageProvider : const NetworkImage('https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'),
    // backgroundImage: (data.img !=null) ? FileImage(File(data.img)) as ImageProvider : const NetworkImage('https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'),
  ),
  title: Text(data.name),
  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) =>FullDetailScreen(data: data, id: data.id) )),
  // trailing: IconButton(onPressed: (){
  //   if(data.id != null){
  //     deletStudent(data.id!);
  //   }else{
  //     print('id null');
  //   }
  // }, icon: Icon(Icons.delete))
  trailing: RichText(text: TextSpan(
    children: [
      WidgetSpan(child: IconButton(onPressed: (){
       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
          return UpdateScreen(updateId: data.id, updateData: data);
        }));
      }, icon: const Icon(Icons.edit),color: Colors.blue[900],),),
      WidgetSpan(child:IconButton(onPressed: (){
        deletStudent(data.id!);
      }, icon: const Icon(Icons.delete_forever,),color: Colors.red,), ), 
    ]
  ))
);
        },
        itemCount: studentList.length,
        separatorBuilder: (context, index) => const Divider(),
      )
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 145, 22, 13),
        child: const Text('Add'),
        onPressed: (){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
          return const AddDetails();
        }));
      }),
    );
  }
}



/* Row(
    children: [
      IconButton(onPressed: (){}, icon: const Icon(Icons.delete_forever,),color: Colors.red,),
      IconButton(onPressed: (){}, icon: const Icon(Icons.delete_forever,),color: Colors.blue[900],),
      
    ],
  ),*/