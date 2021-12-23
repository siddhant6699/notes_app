import 'package:flutter/material.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  _AddNotesState createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(17.0),
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
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  // IconButton(
                  //   tooltip: "Go Back",
                  //   onPressed: () {
                  //     Navigator.pop(context);
                  //   },
                  //   icon: const Icon(
                  //     Icons.arrow_back_ios_new_outlined,
                  //     color: Colors.white,
                  //     size: 35,
                  //   ),
                  // ),
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
                height: 12,
              ),
              TextField(
                style: const TextStyle(fontSize: 30.0, color: Colors.white),
                controller: titleController,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Username',
                  hintStyle: TextStyle(color: Color(0Xff939393), fontSize: 30),
                ),
              ),
              const SizedBox(
                height: 17,
              ),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: const TextStyle(fontSize: 16.0, color: Colors.white),
                controller: descriptionController,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Type something...',
                  hintStyle: TextStyle(color: Color(0Xff939393), fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
