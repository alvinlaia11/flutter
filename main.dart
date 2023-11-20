import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fab_circular_menu_plus/fab_circular_menu_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  List<EventModel> details = [];

  Future<void> readData() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    var data = await db.collection('event_detail').get();
    setState(() {
      details =
          data.docs.map((doc) => EventModel.fromDocSnapshot(doc)).toList();
    });
  }

  void addRand() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    EventModel insertData = EventModel(
      id: '',
      judul: getRandString(5),
      keterangan: getRandString(30),
      tanggal: getRandString(10),
      is_like: Random().nextBool(),
      pembicara: getRandString(20),
    );
    DocumentReference docRef =
        await db.collection("event_detail").add(insertData.toMap());
    setState(() {
      insertData.id = docRef.id;
      details.add(insertData);
    });
  }

  void deleteLast(String documentId) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    await db.collection('event_detail').doc(documentId).delete();
    setState(() {
      details.removeLast();
    });
  }

  void deleteSelected() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    List<EventModel> selectedItems =
        details.where((item) => item.is_like).toList();

    for (var item in selectedItems) {
      await db.collection('event_detail').doc(item.id).delete();
    }

    setState(() {
      details.removeWhere((item) => selectedItems.contains(item));
    });
  }

  void updateEvent(int pos) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
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

  @override
  Widget build(BuildContext context) {
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
          icon: Icon(Icons.add),
        ),
        IconButton(
          onPressed: () {
            if (details.last.id != null) {
              deleteLast(details.last.id!);
            }
          },
          icon: Icon(Icons.minimize),
        ),
        IconButton(
          onPressed: () {
            deleteSelected();
          },
          icon: Icon(Icons.delete),
        ),
      ]),
    );
  }

  String getRandString(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }
}
