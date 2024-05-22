import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/details/details_page.dart';

class FieldDetails extends StatelessWidget {
  final Stream<QuerySnapshot>? fieldStream;
  final String searchTerm;
  final String fieldId;

  const FieldDetails(
      {required this.fieldStream,
      required this.searchTerm,
      required this.fieldId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: fieldStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          var filteredDocs = snapshot.data!.docs.where((doc) {
            String name = doc["Nama Lapangan"] ?? '';
            return name.toLowerCase().contains(searchTerm.toLowerCase());
          }).toList();

          if (filteredDocs.isEmpty) {
            return Center(child: Text('No fields found'));
          }

          return ListView.builder(
            itemCount: filteredDocs.length,
            itemBuilder: (context, index) {
              var doc = filteredDocs[index];
              String? imageUrl = doc["Image"] != null && doc["Image"].isNotEmpty
                  ? doc["Image"][0]
                  : null;

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FieldDetailPage(
                        fieldId: doc.id,
                        fieldStream: fieldStream,
                        searchTerm: '',
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Material(
                    elevation: 2.0,
                    borderRadius: BorderRadius.circular(7.0),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (imageUrl != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                imageUrl,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(doc["Daerah"],
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Poppins",
                                            fontSize: 17)),
                                  ],
                                ),
                                Text(doc["Nama Lapangan"],
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Poppins",
                                        fontSize: 20)),
                                Text(doc["Jam Operasional"],
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Poppins",
                                        fontSize: 17))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
