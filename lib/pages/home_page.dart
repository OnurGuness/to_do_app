

import 'package:flutter/material.dart';
import 'package:to_do_app/utils/todo_list.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _controller = TextEditingController();
  List toDoList = [
    ['Flutter Öğren',false],
    ['Çay İç',false],
    ['Evi Temizle',false],
  ];

  void checkBoxChanged(int index){
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  void saveNewTask(){
   setState(() {
     toDoList.add([_controller.text, false]);
     _controller.clear();
   });
  }

  void deleteTask(int index){
    final deletedTask = toDoList[index];
    setState(() {
      toDoList.removeAt(index);
    });

    //SnackBar ile bildirim göster
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text("${deletedTask[0]} silindi"),
          action: SnackBarAction(
            label: "Geri Al",
            onPressed: () {
              // Geri Al butonu ile işlemi geri alma
              setState(() {
                toDoList.insert(index, deletedTask);
              });
            },
          ),
      duration: Duration(seconds: 3),  // SnackBarın süresi
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      appBar: AppBar(title:
      const Text('To Do App'), // Text
      centerTitle: true,
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.white,
      ),
      body: ListView.builder(itemCount: toDoList.length,itemBuilder: (BuildContext context, index){
          return TodoList(
            taskName: toDoList[index][0],
            taskCompleted:  toDoList[index][1],
            onChanged: (value) => checkBoxChanged(index),
            deleteFunction: (contex) => deleteTask(index),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Expanded(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Yeni bir yapılacak iş ekleyin',
                  filled: true,
                  fillColor: Colors.white54,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.indigo,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.indigo,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                  ),
                ),
              ),
            ),
                FloatingActionButton(
                  onPressed: saveNewTask,
                  child: const Icon(Icons.add),
                ),
          ],
        ),
      ),
    );
  }
}

