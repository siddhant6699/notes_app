import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/addnotes/addnotes_bloc.dart';
import 'package:notes_app/addnotes/addnotes_event.dart';
import 'package:notes_app/addnotes/addnotes_state.dart';
import 'package:notes_app/notes_model.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  _AddNotesState createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  Random random = Random();
  List colorList = const [
    "0xffFFAB91",
    "0xffFFCC80",
    "0xffE4EBA5",
    "0xff81DEEA",
    "0xffCF94DA",
    "0xffF48FB1",
    "0xff80CCC5",
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddNoteBloc>(
        create: (context) => AddNoteBloc(),
        child: Scaffold(
            backgroundColor: Colors.black,
            body:
                BlocBuilder<AddNoteBloc, NoteState>(builder: (context, state) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 40,
                            height: 35,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: const Icon(
                                Icons.arrow_left,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                if (descriptionController.text.isEmpty ||
                                    titleController.text.isEmpty) {
                                  Navigator.pop(context);
                                } else {
                                  BlocProvider.of<AddNoteBloc>(context)
                                      .add(AddNoteRequest(
                                          noteDate: Note(
                                    title: titleController.text,
                                    description: descriptionController.text,
                                    createdOn: DateTime.now(),
                                    cardColor: colorList[random.nextInt(7)],
                                  )));
                                  Navigator.pop(context);
                                }
                              },
                            ),
                          ),
                          IconButton(
                            tooltip: "Save Note",
                            onPressed: () {},
                            icon: const Icon(
                              Icons.check_box,
                              color: Colors.white,
                              size: 41,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        textCapitalization: TextCapitalization.sentences,
                        maxLines: null,
                        style: const TextStyle(
                            fontSize: 31.0, color: Colors.white),
                        controller: titleController,
                        decoration: const InputDecoration.collapsed(
                          hintText: 'Title',
                          hintStyle: TextStyle(
                              color: Color(0Xff939393), fontSize: 31.0),
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      TextField(
                        textCapitalization: TextCapitalization.sentences,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: const TextStyle(
                            fontSize: 17.0, color: Colors.white),
                        controller: descriptionController,
                        decoration: const InputDecoration.collapsed(
                          hintText: 'Type something...',
                          hintStyle: TextStyle(
                              color: Color(0Xff939393), fontSize: 17.0),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            })));
  }
}
