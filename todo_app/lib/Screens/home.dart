// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Model/todo.dart';
import 'package:todo_app/Screens/Service/Service_todo.dart';
import 'package:todo_app/Widgets/todo_item.dart';
import 'package:todo_app/constants/Colors.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TodoService _todoService = TodoService();

  // FirebaseFirestore db = FirebaseFirestore.instance;
  final todosList = ToDo.todoList();
  final _todoController = TextEditingController();

  List<ToDo> _findToDo = [];

  @override
  void initState() {
    _findToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // db.collection("todos").snapshots().listen((snapshot) {});
    // final CollectionReference todosRef =
    //     FirebaseFirestore.instance.collection('todos');

    return StreamBuilder<QuerySnapshot>(
      stream: _todoService.todoStreem(),
      // stream: db.collection("todos").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        var docs = snapshot.data?.docs ?? [];
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: tdBGcolor,
          appBar: _buldAppBar(),
          body: Column(
            children: [
              Container(
                height: 200,
                // color: tdBGcolor,
                // decoration: BoxDecoration(
                //     image: DecorationImage(
                //         image: AssetImage("lib/assets/images/wlpr.jpg"))),
              ),
              Stack(
                children: [
                  SizedBox(
                    height: 500,
                    child: ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, i) {
                        String id = docs[i].id;
                        // DocumentReference docRef = todosRef.doc(docs[i].id);
                        Map<String, dynamic> data =
                            docs[i].data() as Map<String, dynamic>;
                        return ToDoItem(
                          onDeleteItem: (value) {
                            showDialog(
                                context: context,
                                builder: ((context) => AlertDialog(
                                      title: const Text("Are you sure ?"),
                                      content: const Text(
                                          "This todo will delete permenantly"),
                                      actions: [
                                        TextButton(
                                            onPressed: (() {
                                              Navigator.of(context).pop();
                                            }),
                                            child: const Text("Cancel")),
                                        TextButton(
                                            onPressed: (() {
                                              // docRef.delete();

                                              // delete showDialogBox

                                              _todoService.deleteTodo(id);
                                              Navigator.of(context).pop();
                                            }),
                                            child: const Text("Delete"))
                                      ],
                                    )));
                          },
                          onToDoChange: (isDone) {
                            // docRef.update({"isDone": value});
                            _todoService.updateTodo(id, isDone!);
                          },
                          todo: ToDo(
                            id: '1',
                            title: data['title'],
                            isDone: data['isDone'],
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 24,
                    right: 24,
                    child: FloatingActionButton(
                      backgroundColor: Colors.orange,
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            height: 240,
                            // color: Colors.black,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 70,
                                  width: 350,
                                  child: TextField(
                                    controller: _todoController,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Colors.black),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Colors.orange),
                                      ),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    String title = _todoController.text;
                                    // todosRef.add({
                                    //   'title': title,
                                    //   'isDone': false,
                                    // });

                                    // add id
                                    _todoService.addTod(title);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Submit'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: const Icon(Icons.add, size: 36),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) =>
              item.title!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _findToDo = results;
    });
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) {
          _runFilter(value);
        },
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(
            color: tdGrey,
          ),
        ),
      ),
    );
  }

  AppBar _buldAppBar() {
    return AppBar(
      backgroundColor: Colors.orange,
      elevation: 0,
      leading: const Icon(
        Icons.menu,
        color: tdBlack,
        size: 30,
      ),
      title: Center(
        child: Text(
          "ToDo App 🖊️",
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert_outlined,
              size: 32,
              color: Colors.black,
            ))
      ],
    );
  }
}
