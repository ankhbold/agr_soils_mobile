import 'package:flutter/material.dart';
import 'package:mvvm/screen/insight%20screen/insight_screen.dart';
import 'package:mvvm/screen/notes%20screen/todo/models/todo_model.dart';
import 'package:mvvm/screen/profile%20screen/profile_screen.dart';

// ignore: must_be_immutable
class Todocard extends StatefulWidget {
  // create varibles that a todocard will receive data for
  final int id;
  final String title;
  final DateTime creationDate;
  bool isChecked;
  final Function insertFunction;
  final Function deleteFunction;
  Todocard(
      {required this.id,
      required this.title,
      required this.creationDate,
      required this.isChecked,
      required this.insertFunction, // it will handle the changes in checkbox
      required this.deleteFunction, // it will handle the delete button function
      Key? key})
      : super(key: key);

  @override
  _TodocardState createState() => _TodocardState();
}

class _TodocardState extends State<Todocard> {
  @override
  Widget build(BuildContext context) {
    // create a local todo
    var anotherTodo = Todo(
        id: widget.id,
        title: widget.title,
        creationDate: widget.creationDate,
        isChecked: widget.isChecked);
    //
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.92,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   "${posts![index].createdAt}",
                        //   style: const TextStyle(
                        //     fontSize: 18,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                        Text(
                          formattedDate,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const Text(
                          'усалгаатай - 1',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        // Text(
                        //   posts![index].name,
                        //   style: const TextStyle(
                        //     fontSize: 14,
                        //     fontWeight: FontWeight.w400,
                        //     color: Color.fromARGB(255, 127, 127, 127),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.16,
                    width: MediaQuery.of(context).size.width * 0.92,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage(
                        'assets/images/note.jpeg',
                      )),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Text(
                    widget.title,
                  ) // Text(
                  //   posts![index].name,
                  // )
                ],
              ),
            ),
          ),
          const Line3(),
        ],
      ),
    );
  }
}
