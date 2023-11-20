void deleteSelected() async {
    FirebaseFirestore db = await FirebaseFirestore.instance;
    List<EventModel> selectedItems =
        details.where((item) => item.is_like).toList();

    for (var item in selectedItems) {
      await db.collection('event_detail').doc(item.id).delete();
    }

    setState(() {
      details.removeWhere((item) => selectedItems.contains(item));
    });
}
