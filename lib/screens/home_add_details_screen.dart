// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:database/screens/student_list_screen.dart';
import 'package:database/functions/data_functions.dart';
import 'package:database/data_model/data_model.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

class AddDetails extends StatefulWidget {
  const AddDetails({Key? key}) : super(key: key);

  @override
  State<AddDetails> createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
  File? _imgAdd;

  final _UserNamecontroller = TextEditingController();

  final _UserAgecontroller = TextEditingController();

  final _UserPhonecontroller = TextEditingController();

  final _UserSchoolcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Details'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 145, 22, 13),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            const SizedBox(
              height: 18,
            ),
            const Center(
              child: Text(
                'Add New Student',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Color.fromARGB(255, 145, 22, 13)),
              ),
            ),

            SizedBox(
              height: 190,
              width: 150,
              child: Stack(
                clipBehavior: Clip.none,
                fit: StackFit.expand,
                children: [
                  CircleAvatar(
                    backgroundImage: (_imgAdd != null)
                        ? FileImage(_imgAdd!) as ImageProvider
                        : const NetworkImage(
                            'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'),
                    // backgroundImage: NetworkImage('https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'),
                  ),
                  Positioned(
                      right: 100,
                      bottom: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 25,
                        child: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: ((ctx1) => bottomPopUp()));
                          },
                          icon: const Icon(
                            Icons.camera_alt,
                            size: 30,
                          ),
                          color: Colors.teal,
                        ),
                      ))
                ],
              ),
            ),
            // const SizedBox(height: 18,),
            // CircleAvatar(
            //   radius: 80,
            //   backgroundImage: NetworkImage('https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'),
            //   child: IconButton(onPressed: (){

            //   }, icon: const Icon(Icons.camera_alt),color: Colors.teal),
            // ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              
              controller: _UserNamecontroller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0))),
                  hintText: 'Name',
                
                  labelText: 'Name'),
                  
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: _UserAgecontroller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0))),
                  hintText: 'Age',
                  labelText: 'Age'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _UserPhonecontroller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0))),
                  hintText: 'Phone Number',
                  labelText: 'Phone-Number'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _UserSchoolcontroller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0))),
                  hintText: 'School',
                  labelText: 'School'),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 145, 22, 13)),
                  onPressed: () {
                    clearPage();
                    bottomSnack(context, "Cleared", Colors.red);
                  },
                  child: const Text(
                    'Clear Data',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  )),
              TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 145, 22, 13)),
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (ctx) {
                      return const StudentListScreen();
                    }));
                  },
                  child: const Text(
                    'View Data',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ))
            ]),
            const SizedBox(
              height: 20,
            ),

            TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 145, 22, 13)),
                onPressed: () {
                  // bottomSnack(
                  //       context, "All Fields Requred", Colors.red);
                  onAddButtonClick();
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (ctx) {
                    return const AddDetails();
                  }));
                },
                child: const Text(
                  'Save Data',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ))
          ],
        ),
      ),
    );
  }

  void onAddButtonClick() async {
    final namel = _UserNamecontroller.text.trim();
    final agel = _UserAgecontroller.text.trim();
    final phonel = _UserPhonecontroller.text.trim();
    final schooll = _UserSchoolcontroller.text.trim();
    final Imageprovide = _imgAdd!.path.toString();

    if (namel.isEmpty || agel.isEmpty || phonel.isEmpty || schooll.isEmpty) {
      bottomSnack(context, "Cleared", Colors.red);
    } else {
      final stdlist = StudentModel(
          name: namel,
          age: agel,
          phone: phonel,
          school: schooll,
          img: Imageprovide);
      addStudent(stdlist);
    }
  }

  void clearPage() {
    _UserNamecontroller.clear();
    _UserAgecontroller.clear();
    _UserPhonecontroller.clear();
    _UserSchoolcontroller.clear();
  }

  Future imageGalary() async {
    final imageone = await ImagePicker().pickImage(source: ImageSource.camera);
    if (imageone == null) return;
    final imagetemp = File(imageone.path);

    setState(() {
      _imgAdd = imagetemp;
    });
  }

  Future imageCamera() async {
    final Imageone = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (Imageone == null) return;
    final imagetemp = File(Imageone.path);

    setState(() {
      _imgAdd = imagetemp;
    });
  }

  Widget bottomPopUp() {
    return Container(
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
                  label: const Text('Galary',
                      style: TextStyle(color: Colors.black))),
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
