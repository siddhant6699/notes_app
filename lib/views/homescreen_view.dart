import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
  Random random = Random();
  List<Color> colorList = const [
    Color(0xffFFAB91),
    Color(0xffFFCC80),
    Color(0xffE4EBA5),
    Color(0xff81DEEA),
    Color(0xffCF94DA),
    Color(0xffF48FB1),
    Color(0xff80CCC5),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(HomeDatabaseRequest()),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          if (state is HomeLoadInProgress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HomeLoadSuccess) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
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
                        height: 8,
                      ),
                      StaggeredGridView.countBuilder(
                          shrinkWrap: true, //
                          physics: const ScrollPhysics(),
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 12,
                          itemCount: state.notesListing.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                  color: colorList[random.nextInt(7)],
                                  //color: Colors.pinkAccent,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15))),
                            );
                          },
                          // itemBuilder: (context, index) {
                          //   state.notesListing.isEmpty
                          //       ? Text(
                          //           'No Notes',
                          //           style: TextStyle(
                          //               color: Colors.white, fontSize: 25),
                          //         )
                          //       : Container(
                          //           decoration: BoxDecoration(
                          //               color: colorList[random.nextInt(7)],
                          //               //color: Colors.pinkAccent,
                          //               borderRadius: const BorderRadius.all(
                          //                   Radius.circular(15))),
                          //         );
                          //   throw {};
                          // },
                          staggeredTileBuilder: (index) {
                            return StaggeredTile.count(
                                1, index.isEven ? 1.2 : 1.8);
                          }),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is HomeLoadFailed) {
            return Text(state.error.toString());
          } else {
            return Center(
              child: Text('No Note Created Till Now'),
            );
          }
        }),
        // SafeArea(
        //   child: Padding(
        //     padding: const EdgeInsets.all(15.0),
        //     child: SingleChildScrollView(
        //       child: Column(
        //         children: [
        //           const SizedBox(
        //             height: 5,
        //           ),
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               const Text(
        //                 'Notes',
        //                 style: TextStyle(
        //                     fontWeight: FontWeight.bold,
        //                     fontSize: 30,
        //                     color: Colors.white),
        //               ),
        //               IconButton(
        //                   tooltip: "Profile",
        //                   onPressed: () {},
        //                   icon: const Icon(
        //                     Icons.person_pin_rounded,
        //                     color: Colors.white,
        //                     size: 35,
        //                   ))
        //             ],
        //           ),
        //           const SizedBox(
        //             height: 8,
        //           ),
        //           StaggeredGridView.countBuilder(
        //               shrinkWrap: true, //
        //               physics: const ScrollPhysics(),
        //               crossAxisCount: 2,
        //               crossAxisSpacing: 10,
        //               mainAxisSpacing: 12,
        //               itemCount: 10,
        //               itemBuilder: (context, index) {
        //                 return Container(
        //                   decoration: BoxDecoration(
        //                       color: colorList[random.nextInt(7)],
        //                       //color: Colors.pinkAccent,
        //                       borderRadius:
        //                           const BorderRadius.all(Radius.circular(15))),
        //                 );
        //               },
        //               staggeredTileBuilder: (index) {
        //                 return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
        //               }),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          tooltip: "Add Note",
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddNotes()));
          },
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
