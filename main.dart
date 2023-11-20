import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fab_circular_menu_plus/fab_circular_menu_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'database.dart';
import 'dart:convert';
import 'dart:math';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

Future testData() async {
  await Firebase.initializeApp();
  print('init Done');
  FirebaseFirestore db = await FirebaseFirestore.instance;
  print('init Firestore Done');

  await db.collection('event_detail').get().then((event) {
    for (var doc in event.docs) {
      print("${doc.id} => ${doc.data()}");
    }
  });
}

class _MyHomeState extends State<MyHome> {
  List<EventModel> details = [];

  Future readData() async {
    await Firebase.initializeApp();
    FirebaseFirestore db = await FirebaseFirestore.instance;
    var data = await db.collection('event_detail').get();
    setState(() {
      details =
          data.docs.map((doc) => EventModel.fromDocSnapshot(doc)).toList();
    });
  }

  void addRand() async {
    FirebaseFirestore db = await FirebaseFirestore.instance;
    EventModel InsertData = EventModel(
        judul: getRandString(5),
        keterangan: getRandString(30),
        tanggal: getRandString(10),
        is_like: Random().nextBool(),
        pembicara: getRandString(20));
    DocumentReference docRef =
        await db.collection("event_detail").add(InsertData.toMap());
    setState(() {
      InsertData.id = docRef.id;
      details.add(InsertData);
    });
  }

  void deleteLast(String documentId) async {
    FirebaseFirestore db = await FirebaseFirestore.instance;
    await db.collection('event_detail').doc(documentId).delete();
    setState(() {
      details.removeLast();
    });
  }

  void deleteSelected() async {
    FirebaseFirestore db = await FirebaseFirestore.instance;

    // Filter items yang dicentang
    List<EventModel> selectedItems = details.where((item) => item.is_like).toList();

    // Hapus item yang dicentang dari Firestore
    for (var item in selectedItems) {
      await db.collection('event_detail').doc(item.id).delete();
    }

    // Perbarui state untuk menghilangkan item yang dicentang dari UI
    setState(() {
      details.removeWhere((item) => item.is_like);
    });
  }

  void updateEvent(int pos) async {
    FirebaseFirestore db = await FirebaseFirestore.instance;
    await db
        .collection('event_detail')
        .doc(details[pos].id)
        .update({'is_like': !details[pos].is_like});
    setState(() {
      details[pos].is_like = !details[pos].is_like;
    });
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  Widget build(BuildContext context) {
    testData();
    return Scaffold(
      appBar: AppBar(title: Text("Cloud Firestore")),
      body: ListView.builder(
        itemCount: details.length,
        itemBuilder: (context, position) {
          return CheckboxListTile(
            value: details[position].is_like,
            onChanged: (bool? value) {
              updateEvent(position);
            },
            title: Text(details[position].judul),
            subtitle: Text("${details[position].keterangan}" +
                "\nHari : ${details[position].tanggal}" +
                "\nPembicara : ${details[position].pembicara}"),
            isThreeLine: true,
          );
        },
      ),
      floatingActionButton: FabCircularMenuPlus(children: <Widget>[
        IconButton(
            onPressed: () {
              addRand();
            },
            icon: Icon(Icons.add)),
        IconButton(
            onPressed: () {
              if (details.last.id != null) {
                deleteLast(details.last.id!);
              }
            },
            icon: Icon(Icons.minimize)),
        IconButton(
          onPressed: () {
            deleteSelected();
          },
          icon: Icon(Icons.delete),
        ),
      ]),
    );
  }
}
