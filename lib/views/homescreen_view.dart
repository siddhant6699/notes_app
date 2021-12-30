import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app/delete/delete_bloc.dart';
import 'package:notes_app/delete/delete_event.dart';
import 'package:notes_app/homescreen/homescreen_bloc.dart';
import 'package:notes_app/homescreen/homescreen_event.dart';
import 'package:notes_app/homescreen/homescreen_state.dart';
import 'package:notes_app/views/addnotes_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var position;
  var _visible = false;
  int selectedCard = -1;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DeleteNoteBloc>(
      create: (context) => DeleteNoteBloc(),
      child: BlocProvider<HomeBloc>(
        create: (context) => HomeBloc()..add(HomeDatabaseRequest()),
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          if (state is HomeLoadInProgress) {
            return Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is HomeLoadSuccess) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedCard = -1;
                });
              },
              child: Scaffold(
                backgroundColor: Colors.black,
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Notes',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: Colors.white),
                              ),
                              IconButton(
                                  tooltip: "Profile",
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.person_pin_rounded,
                                    color: Colors.white,
                                    size: 35,
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          StaggeredGridView.countBuilder(
                              shrinkWrap: true, //
                              physics: const ScrollPhysics(),
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 12,
                              itemCount: state.notesListing.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => AddNotes(
                                                  id: state
                                                      .notesListing[index].id,
                                                  title: state
                                                      .notesListing[index]
                                                      .title,
                                                  description: state
                                                      .notesListing[index]
                                                      .description,
                                                  createdon: state
                                                      .notesListing[index]
                                                      .createdOn,
                                                  cardColor: state
                                                      .notesListing[index]
                                                      .cardColor,
                                                )))
                                        .then((value) => setState(() {
                                              BlocProvider.of<HomeBloc>(context)
                                                  .add(HomeDatabaseRequest());
                                            }));
                                  },
                                  onLongPress: () {
                                    setState(() {
                                      selectedCard = index;
                                    });
                                    HapticFeedback.heavyImpact();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color(int.parse(state
                                            .notesListing[index].cardColor)),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      state.notesListing[index]
                                                          .title,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: 23,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Visibility(
                                                      visible:
                                                          selectedCard == index
                                                              ? true
                                                              : false,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            _visible = false;
                                                          });
                                                        },
                                                        child: InkWell(
                                                          onTap: () {
                                                            BlocProvider.of<
                                                                        DeleteNoteBloc>(
                                                                    context)
                                                                .add(DeleteNoteRequest(
                                                                    id: state
                                                                        .notesListing[
                                                                            index]
                                                                        .id!));
                                                            setState(() {
                                                              selectedCard = -1;
                                                            });
                                                            BlocProvider.of<
                                                                        HomeBloc>(
                                                                    context)
                                                                .add(
                                                                    HomeDatabaseRequest());
                                                          },
                                                          child: Icon(
                                                            Icons.delete,
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                      )),
                                                ],
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                state.notesListing[index]
                                                    .description,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            (DateFormat.yMMMd().format(state
                                                    .notesListing[index]
                                                    .createdOn))
                                                .toString(),
                                            //(state.notesListing[index].createdOn).toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black45),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              staggeredTileBuilder: (index) {
                                return StaggeredTile.count(
                                    1, index.isEven ? 1.03 : 0.89);
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  backgroundColor: Colors.white,
                  tooltip: "Add Note",
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (context) => const AddNotes()))
                        .then((value) => setState(() {
                              BlocProvider.of<HomeBloc>(context)
                                  .add(HomeDatabaseRequest());
                            }));
                  },
                  child: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                ),
              ),
            );
          } else if (state is HomeLoadFailed) {
            return Scaffold(
                backgroundColor: Colors.black,
                body: Text(state.error.toString()));
          } else {
            return Center(
              child: Text('No Note Created Till Now'),
            );
          }
        }),
      ),
    );
  }
}
