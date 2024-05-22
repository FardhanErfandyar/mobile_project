import 'dart:async';
import 'package:app/details/details_page.dart';
import 'package:app/service/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostfieldContent extends StatefulWidget {
  const PostfieldContent({super.key});

  @override
  State<PostfieldContent> createState() => _PostfieldState();
}

class _PostfieldState extends State<PostfieldContent> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController districtcontroller = TextEditingController();
  TextEditingController timecontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController facilitycontroller = TextEditingController();
  Stream<QuerySnapshot>? fieldStream;

  getontheload() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    print("User ID: $userId");
    fieldStream = FirebaseFirestore.instance
        .collection('Field Post')
        .where('userId', isEqualTo: userId)
        .snapshots();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allFieldDetails() {
    return StreamBuilder(
      stream: fieldStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: snapshot.data?.docs.length ?? 0,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data!.docs[index];
              String? imageUrl = ds["Image"] != null && ds["Image"].isNotEmpty
                  ? ds["Image"][0]
                  : null;
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FieldDetailPage(
                        fieldId: ds.id,
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
                                    Text(
                                      ds["Daerah"],
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Poppins",
                                        fontSize: 17,
                                      ),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        namecontroller.text =
                                            ds["Nama Lapangan"];
                                        districtcontroller.text = ds["Daerah"];
                                        timecontroller.text =
                                            ds["Jam Operasional"];
                                        locationcontroller.text = ds["Alamat"];
                                        pricecontroller.text = ds["Harga"];
                                        facilitycontroller.text =
                                            ds["Fasilitas"];
                                        editFieldDetails(ds["Id"]);
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        color: CupertinoColors.activeOrange,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        await DatabaseFields()
                                            .deleteFieldDetails(ds["Id"]);
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: CupertinoColors.activeOrange,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  ds["Nama Lapangan"],
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Poppins",
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  ds["Jam Operasional"],
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Poppins",
                                    fontSize: 17,
                                  ),
                                ),
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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Post Field",
              style: TextStyle(
                color: CupertinoColors.activeOrange,
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 30),
        child: Column(
          children: [Expanded(child: allFieldDetails())],
        ),
      ),
    );
  }

  Future editFieldDetails(String id) => showDialog(
        context: context,
        builder: (context) => SingleChildScrollView(
          child: AlertDialog(
            content: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.cancel),
                  ),
                  const Center(
                    child: Text(
                      "Edit Details",
                      style: TextStyle(
                        color: CupertinoColors.activeOrange,
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  const Text(
                    "Nama Lapangan",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      controller: namecontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Field ini wajib diisi';
                        }
                        return null;
                      },
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(height: 7),
                  const Text(
                    "Daerah",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextField(
                      controller: districtcontroller,
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(height: 7),
                  const Text(
                    "Jam Operasional",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextField(
                      controller: timecontroller,
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(height: 7),
                  const Text(
                    "Alamat",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextField(
                      controller: locationcontroller,
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(height: 7),
                  const Text(
                    "Harga",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextField(
                      controller: pricecontroller,
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(height: 7),
                  const Text(
                    "Fasilitas",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextField(
                      controller: facilitycontroller,
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        Map<String, dynamic> updateInfo = {
                          "Nama Lapangan": namecontroller.text,
                          "Daerah": districtcontroller.text,
                          "Jam Operasional": timecontroller.text,
                          "Alamat": locationcontroller.text,
                          "Harga": pricecontroller.text,
                          "Fasilitas": facilitycontroller.text,
                        };
                        await DatabaseFields()
                            .updateFieldDetails(id, updateInfo)
                            .then((value) {
                          Navigator.pop(context);
                        });
                      },
                      child: Text("Update"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
