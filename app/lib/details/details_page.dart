import 'package:app/service/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FieldDetailPage extends StatelessWidget {
  final Stream<QuerySnapshot>? fieldStream;
  final String searchTerm;
  final String fieldId;

  const FieldDetailPage(
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
          }
          return ListView.builder(
            itemCount: snapshot.data?.docs.length ?? 0,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data!.docs[index];
              String? imageUrl = ds["Image"] != null && ds["Image"].isNotEmpty
                  ? ds["Image"][0]
                  : null;
              return Container(
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
                                  Text(ds["Daerah"],
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Poppins",
                                          fontSize: 17)),
                                  Spacer(),
                                ],
                              ),
                              Text(ds["Nama Lapangan"],
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Poppins",
                                      fontSize: 20)),
                              Text(ds["Jam Operasional"],
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
              );
            },
          );
        });
  }
}
