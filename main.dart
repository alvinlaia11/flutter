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

// ... (kode yang sama seperti sebelumnya)

class _MyHomeState extends State<MyHome> {
  List<EventModel> details = [];

  // ... (kode yang sama seperti sebelumnya)

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

  @override
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
