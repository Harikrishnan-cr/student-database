



import 'dart:io';

import 'package:database/functions/data_functions.dart';
import 'package:database/data_model/data_model.dart';
import 'package:flutter/material.dart';


class FullDetailScreen extends StatelessWidget {
  int? id;
  StudentModel data;
  // 
  FullDetailScreen({Key? key, required this.data, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 145, 22, 13),
      ),
      body:ValueListenableBuilder(
        valueListenable: studentListnotifier, 
      builder: (BuildContext ctx, List <StudentModel> studentList , child) => Padding(
        
        padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 25),
        child: ListView(
          
          children: [
            SizedBox(height: 20,),
Row(

  mainAxisAlignment: MainAxisAlignment.start,

  children: [

      

CircleAvatar (

  radius: 80,

  backgroundImage: (data.img!=null) ? FileImage(File(data.img)) as ImageProvider : const NetworkImage('https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'),

),


  ],


),
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 28,vertical: 20),
  child:   Column(
  
    crossAxisAlignment: CrossAxisAlignment.start,
  
    children:[
  
     Text('Name    :  ${data.name}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
     const SizedBox(height: 10,),
      Text('Age       :  ${data.age}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
     const SizedBox(height: 30,),
      const Text('School',style:  TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
      const Divider(
        color: Colors.black,
        thickness: 1,
      ),
      Text(data.school,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
     const SizedBox(height: 10,),
     const Divider(
        color: Colors.black,
        thickness: 1,
      ),
      const SizedBox(height: 20,),
      const Text('Phone',style:  TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
      const Divider(
        color: Colors.black,
        thickness: 1,
      ),
      Text(data.phone,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
     const SizedBox(height: 10,),
     const Divider(
        color: Colors.black,
        thickness: 1,
      ),
     
     
     
     
  
 
  
    ],
  
  ),
)


            
          ],
        ),
      )  ));

  }
}