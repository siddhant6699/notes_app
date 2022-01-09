import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/addnotes/addnotes_bloc.dart';
import 'package:notes_app/addnotes/addnotes_event.dart';
import 'package:notes_app/addnotes/addnotes_state.dart';
import 'package:notes_app/notes_model.dart';
import 'package:flutter/services.dart';
import 'package:notes_app/updatenote/update_bloc.dart';
import 'package:notes_app/updatenote/update_event.dart';

class AddNotes extends StatefulWidget {
  final String? title;
  final String? description;
  final DateTime? createdon;
  final int? id;
  final String? cardColor;
  const AddNotes(
      {Key? key,
      this.title,
      this.id,
      this.description,
      this.createdon,
      this.cardColor})
      : super(key: key);

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
  void initState() {
    // TODO: implement initState
    if (widget.id != null) {
      titleController.text = widget.title.toString();
      descriptionController.text = widget.description.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UpdateNoteBloc>(
      create: (context) => UpdateNoteBloc(),
      child: BlocProvider<AddNoteBloc>(
          create: (context) => AddNoteBloc(),
          child: BlocBuilder<AddNoteBloc, NoteState>(builder: (context, state) {
            return WillPopScope(
              onWillPop: () async {
                if (descriptionController.text.trim().isEmpty ||
                    titleController.text.trim().isEmpty) {
                  Navigator.pop(context);
                } else {
                  if (widget.id == null) {
                    BlocProvider.of<AddNoteBloc>(context).add(AddNoteRequest(
                        noteDate: Note(
                      title: titleController.text,
                      description: descriptionController.text,
                      createdOn: DateTime.now(),
                      cardColor: colorList[random.nextInt(7)],
                    )));
                  } else {
                    BlocProvider.of<UpdateNoteBloc>(context).add(
                        UpdateNoteRequest(
                            noteDate: Note(
                                id: widget.id,
                                title: titleController.text,
                                description: descriptionController.text,
                                createdOn: DateTime.now(),
                                cardColor: widget.cardColor!)));
                  }
                  Navigator.pop(context);
                }
                return false;
              },
              child: Scaffold(
                  backgroundColor: Colors.black,
                  body: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const SizedBox(
                                //height: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (descriptionController.text
                                          .trim()
                                          .isEmpty ||
                                      titleController.text.trim().isEmpty) {
                                    Navigator.pop(context);
                                  } else {
                                    if (widget.id == null) {
                                      BlocProvider.of<AddNoteBloc>(context)
                                          .add(AddNoteRequest(
                                              noteDate: Note(
                                        title: titleController.text,
                                        description: descriptionController.text,
                                        createdOn: DateTime.now(),
                                        cardColor: colorList[random.nextInt(7)],
                                      )));
                                    } else {
                                      BlocProvider.of<UpdateNoteBloc>(context)
                                          .add(UpdateNoteRequest(
                                              noteDate: Note(
                                                  id: widget.id,
                                                  title: titleController.text,
                                                  description:
                                                      descriptionController
                                                          .text,
                                                  createdOn: DateTime.now(),
                                                  cardColor:
                                                      widget.cardColor!)));
                                    }
                                    Navigator.pop(context);
                                  }
                                },
                                child: Icon(
                                  CupertinoIcons.arrow_left_square_fill,
                                  color: Colors.white,
                                  size: 45,
                                ),
                              ),
                              const SizedBox(
                                //height: 15,
                              ),
                              TextField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(50),
                                ],
                                textCapitalization:
                                    TextCapitalization.sentences,
                                maxLines: 1,
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
                              Expanded(
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: TextField(
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    style: const TextStyle(
                                        fontSize: 17.0, color: Colors.white),
                                    controller: descriptionController,
                                    decoration: const InputDecoration.collapsed(
                                      hintText: 'Type something...',
                                      hintStyle: TextStyle(
                                          color: Color(0Xff939393),
                                          fontSize: 17.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))),
            );
          })),
    );
  }
}
