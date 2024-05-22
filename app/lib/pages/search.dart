import 'package:app/details/details_page.dart';
import 'package:app/post/field_content.dart';
import 'package:app/service/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPageContent extends StatefulWidget {
  @override
  State<SearchPageContent> createState() => _SearchPageContentState();
}

class _SearchPageContentState extends State<SearchPageContent> {
  TextEditingController nameController = TextEditingController();
  Stream<QuerySnapshot>? fieldStream;
  String searchTerm = '';

  @override
  void initState() {
    super.initState();
    getFieldStream();
  }

  Future<void> getFieldStream() async {
    fieldStream = await DatabaseFields().getFieldDetails();
    setState(() {});
  }

  void searchField(String value) {
    setState(() {
      searchTerm = value;
    });
  }

  List allResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Search Page",
            style: TextStyle(
              color: CupertinoColors.activeOrange,
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    onChanged: searchField,
                    autocorrect: false,
                    autofocus: false,
                    enableSuggestions: true,
                    enableInteractiveSelection: true,
                    decoration: InputDecoration(
                      hintText: "Ayo cari lapangan 🔥 🔥 🔥 🔥",
                      labelText: "Search",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FieldDetails(
                fieldStream: fieldStream,
                searchTerm: searchTerm,
                fieldId: '',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
