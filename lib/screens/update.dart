
// ignore_for_file: non_constant_identifier_names

import 'dart:io';


import 'package:database/screens/student_list_screen.dart';
import 'package:database/functions/data_functions.dart';

import 'package:database/data_model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

class UpdateScreen extends StatefulWidget {
  int? updateId;
  StudentModel updateData;
 UpdateScreen({Key? key,required this.updateId,required this.updateData}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
File? _imgUpdate;

final _UserupdateNamecontroller = TextEditingController();

final _UserupdateAgecontroller = TextEditingController();

final _UserupdatePhonecontroller = TextEditingController();

final _UserupdateSchoolcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    overrideDetails();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Details'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 145, 22, 13),
      ),
      
      body: Padding(
        
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        child: ListView(
          
          children: [
            const SizedBox(height: 20,),
            const Center(
              child:  Text('Update Student Details',style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Color.fromARGB(255, 145, 22, 13)
              ),),
            ),
            const SizedBox(height: 20,),
            SizedBox(
      height: 190,
      width: 150,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          CircleAvatar(
           backgroundImage: (_imgUpdate != null) ? FileImage(_imgUpdate!) as ImageProvider : FileImage(File(widget.updateData.img.toString()))
          ),
          Positioned(
              right: 100,
              bottom: 0,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 25,
                child: IconButton(onPressed: (){
                  showModalBottomSheet(
                        context: context, builder: ((ctx1) => bottomPopUpUpdate()));
                }, icon: Icon(Icons.camera_alt,size: 30,),color: Colors.teal,),
              )
              )
        ],
      ),),
            // const SizedBox(height: 18,),
            // CircleAvatar(
            //   radius: 80,
            //   backgroundImage: NetworkImage('https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'),
            //   child: IconButton(onPressed: (){

            //   }, icon: const Icon(Icons.camera_alt)),
            // ),
const SizedBox(height: 20,),
            TextField(
              controller: _UserupdateNamecontroller,
              decoration: const InputDecoration(
              
                border: OutlineInputBorder(
                  borderRadius:BorderRadius.all(Radius.circular(4.0))
                ),
                
                helperText: 'Name'
              ),
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: _UserupdateAgecontroller,
              decoration: const InputDecoration(
                
                border: OutlineInputBorder(
                  borderRadius:BorderRadius.all(Radius.circular(4.0))
                ),
                
                helperText: 'Age'
              ),
            ),const SizedBox(height: 20,),
            TextField(
              controller: _UserupdatePhonecontroller,
              decoration: const InputDecoration(
                
                border: OutlineInputBorder(
                  borderRadius:BorderRadius.all(Radius.circular(4.0))
                ),
                
                helperText: 'Phone-Number'
              ),
            ),const SizedBox(height: 20,),
            TextField(
              controller: _UserupdateSchoolcontroller,
              decoration: const InputDecoration(
                
                border: OutlineInputBorder(
                  borderRadius:BorderRadius.all(Radius.circular(4.0))
                ),
               
                helperText: 'school'
              ),
            ),
const SizedBox(height: 20,),
            
            const SizedBox(height: 20,),

            TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 145, 22, 13)
                  ),
                  onPressed: (){
                     bottomSnack(
                          context, "Updated Successfully", Colors.green);
                    UpdatebuttonClick();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
          return const StudentListScreen();
          
        }));
                     
                  }, child: const Text('Update Details',style:TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,

                  ),))

            
          ],
        ),
      ),
    );
  }

  void overrideDetails(){
    _UserupdateNamecontroller.text = widget.updateData.name;
    _UserupdateAgecontroller.text = widget.updateData.age;
    _UserupdatePhonecontroller.text = widget.updateData.phone;
    _UserupdateSchoolcontroller.text = widget.updateData.school;
  }

  Future <void> UpdatebuttonClick() async {
final UpdateName = _UserupdateNamecontroller.text.trim();
final UpdateAge = _UserupdateAgecontroller.text.trim();
final UpdatePhone = _UserupdatePhonecontroller.text.trim();
final UpdateSchool = _UserupdateSchoolcontroller.text.trim();


final Upda_taData = StudentModel(
  id:widget.updateId,
  name: UpdateName, age: UpdateAge, phone: UpdatePhone, school: UpdateSchool, 
  img:_imgUpdate == null ? widget.updateData.img.toString() : _imgUpdate!.path.toString()
  );

  updateStudentDataBase(Upda_taData);
  getAllStudents();

  }

  Future imageGalary() async{
  final imageone = await ImagePicker().pickImage(source: ImageSource.camera);
  if (imageone == null) return;
    final imagetemp = File(imageone.path);

  setState(() {
    _imgUpdate = imagetemp;
  });
    
  }

  Future imageCamera() async{
final Imageone = await ImagePicker().pickImage(source: ImageSource.gallery);
if (Imageone == null) return;
    final imagetemp = File(Imageone.path);

  setState(() {
    _imgUpdate = imagetemp;
  });
  }

Widget bottomPopUpUpdate() {
    return  Container(
      height: 100,
      // width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
        const Text(
            'Choose your Profile Photo',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
               TextButton.icon(
                  onPressed: () {
                    imageGalary();
                    
                  },
                  icon: const Icon(
                    Icons.camera,
                    color: Color.fromARGB(211, 151, 6, 6),
                  ),
                  label: const Text(
                    'Camera',
                    style: TextStyle(color: Colors.black),
                  )),
              TextButton.icon(
                  onPressed: () {
                    imageCamera();
                  },
                  icon: const Icon(
                    Icons.image,
                    color: Color.fromARGB(211, 151, 6, 6),
                  ),
                  label:const Text('Galary', style: TextStyle(color: Colors.black))),
            ],
          )
        ],
      ),
    );
  }

  void bottomSnack(ctx1, String textt, Color clr) {
    ScaffoldMessenger.of(ctx1).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 800),
        content: Text(textt),
        backgroundColor: clr,
      ),
    );
  }
}