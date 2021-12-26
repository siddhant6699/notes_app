import '../notes_model.dart';

abstract class HomeState{}

class HomeInitial extends HomeState{}

class HomeLoadInProgress extends HomeState{}

class HomeLoadSuccess extends HomeState{
 final List<Note> notesListing;
 HomeLoadSuccess({required this.notesListing});
 }

class HomeLoadFailed extends HomeState{
  final error;
  HomeLoadFailed({required this.error});
}