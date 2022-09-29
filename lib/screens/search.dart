
import 'dart:io';

import 'package:database/functions/data_functions.dart';
import 'package:database/data_model/data_model.dart';
import 'package:database/screens/fulldeatil.dart';
import 'package:database/screens/update.dart';
import 'package:flutter/material.dart';


class NameSearch extends SearchDelegate<StudentModel> {
  final List<StudentModel> studentName = studentListnotifier.value;
  var abc = studentListnotifier.value.toString();
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList =
        studentName.where((p) => p.name.startsWith(query)).toList();
    return ValueListenableBuilder(
      valueListenable: studentListnotifier,
      builder:
          (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
        studentList = studentList;
        return ListView.separated(
            itemCount: suggestionList.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(height: 3, color: Colors.white),
            itemBuilder: (BuildContext context, int index) {
              final listData = suggestionList[index];
              return ListTile(
                onTap: () {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (ctx) {
                    return FullDetailScreen(data: listData, id: listData.id);
                  }));
                },
                leading: CircleAvatar(
                  backgroundImage:
                      FileImage(File(listData.img.toString())),
                ),
                title: Text(listData.name),
                subtitle: Text(listData.age),
                trailing: RichText(text: TextSpan(
                  children: [
                    WidgetSpan(child: IconButton(
                      color: Colors.blue[900],
                      onPressed: (){
                       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
          return UpdateScreen(updateId: listData.id, updateData: listData);
        }));
                        
                       
                    }, icon: const Icon(Icons.edit))),
                    WidgetSpan(child: IconButton(
                      
                      color: const Color.fromARGB(255, 145, 22, 13),
                      onPressed: () {
                        
                       deletStudent(listData.id!);
                      NameSearch();
                        bottomSnack(
                          context, "Successfully Deleted", Colors.green);

                          
                    }, icon: const Icon(Icons.delete_forever))),
                  ]
                ))

                // IconButton(
                //   onPressed: () {
                //     if (listData.id != null) {
                //       deletStudent(listData.id!);
                    //   bottomSnack(
                    //       context, "Successfully Deleted", Colors.green);
                    // } 
                //     Navigator.pop(context);
                //   },
                //   icon: const Icon(Icons.delete),
                //   color: Colors.red,
                // ),
              );
            });
      },
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
