import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FileStatsModel {
  late Timestamp? fileLastOpenedDateTime;
  late Timestamp? fileModifiedDateTime;
  // late Map<String, Timestamp>? file_transfers = {"": Timestamp(0, 0)};
  late List<dynamic>? tracking = [];
  // late List<String?>? admins_uid;

  FileStatsModel({
    this.fileLastOpenedDateTime,
    this.fileModifiedDateTime,
    // this.file_transfers,
    this.tracking,
  });

  FileStatsModel.fromDocumentSnapshot({DocumentSnapshot? documentSnapshot}) {
    fileLastOpenedDateTime = documentSnapshot!["fileLastOpenedDateTime"];
    fileModifiedDateTime = documentSnapshot["fileModifiedDateTime"];
    tracking = documentSnapshot["tracking"];
  }
}

class Transfer {
  String Operation = "Transfer";
  late String From;
  late String To;
  late Timestamp Time;

  Transfer(this.From, this.To, this.Time);
}

class Opened {
  String Operation = "Opened";
  late String User;
  late Timestamp Time;

  Opened(this.User, this.Time);
}
