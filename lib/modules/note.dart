import 'package:isar/isar.dart';
// this generated the file
// allows to store these notes in the database
// then run: dart run build_runner build
part 'note.g.dart';

@Collection()
class Note {
  Id id = Isar.autoIncrement;
  late String text;
}

