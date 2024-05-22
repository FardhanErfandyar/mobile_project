import 'dart:io';

import 'package:app/service/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class Addfield extends StatefulWidget {
  const Addfield({Key? key}) : super(key: key);

  @override
  State<Addfield> createState() => _AddfieldState();
}

class _AddfieldState extends State<Addfield> {
  Map<String, dynamic> FieldInfoMap = {};

  String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

  TextEditingController namecontroller = TextEditingController();
  TextEditingController districtcontroller = TextEditingController();
  TextEditingController timecontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController facilitycontroller = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  List<File> selectedImage = [];

  Future<void> getImage() async {
    final List<XFile>? image = await _picker.pickMultiImage();

    if (image != null) {
      setState(() {
        selectedImage = image.map((image) => File(image.path)).toList();
      });
    }
  }

  Future<List<String>?> uploadFieldImg() async {
    if (selectedImage == null ||
        namecontroller.text.isEmpty ||
        districtcontroller.text.isEmpty ||
        timecontroller.text.isEmpty ||
        locationcontroller.text.isEmpty ||
        pricecontroller.text.isEmpty ||
        facilitycontroller.text.isEmpty) {
      return null;
    }

    List<String> downloadUrls = [];
    for (File image in selectedImage) {
      String addId = randomAlphaNumeric(10);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child("fieldImages").child(addId);
      final UploadTask task = firebaseStorageRef.putFile(image);
      var downloadUrl = await (await task).ref.getDownloadURL();
      downloadUrls.add(downloadUrl);
    }
    return downloadUrls;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Add Field",
              style: TextStyle(
                  color: CupertinoColors.activeOrange,
                  fontSize: 27,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 20, top: 25, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Upload the Field Pictures",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                  onTap: () {
                    getImage();
                  },
                  child: Center(
                    child: Material(
                      elevation: 2.0,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: selectedImage.isEmpty
                            ? const Center(
                                child: Icon(Icons.camera_alt_outlined),
                              )
                            : SizedBox(
                                height: 10,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: selectedImage.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.all(5),
                                      width: 150,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.5),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.file(
                                          selectedImage[index],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ),
                    ),
                  )),
              const SizedBox(height: 10),
              const Text(
                "Nama Lapangan",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5)),
                child: TextFormField(
                  controller: namecontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                "Daerah",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5)),
                child: TextFormField(
                  controller: districtcontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                "Jam Operasional",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5)),
                child: TextFormField(
                  controller: timecontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                "Alamat",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5)),
                child: TextFormField(
                  controller: locationcontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                "Harga",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5)),
                child: TextFormField(
                  controller: pricecontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                "Fasilitas",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5)),
                child: TextFormField(
                  controller: facilitycontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                    onPressed: () async {
                      List<String>? imageUrl = await uploadFieldImg();
                      if (imageUrl != null) {
                        String id = randomAlphaNumeric(10);
                        Map<String, dynamic> FieldInfoMap = {
                          "userId": userId,
                          "Nama Lapangan": namecontroller.text,
                          "Daerah": districtcontroller.text,
                          "Jam Operasional": timecontroller.text,
                          "Alamat": locationcontroller.text,
                          "Harga": pricecontroller.text,
                          "Fasilitas": facilitycontroller.text,
                          "Image": imageUrl,
                          "Id": id,
                        };
                        await DatabaseFields()
                            .addFieldDetails(FieldInfoMap, id)
                            .then((value) {
                          Fluttertoast.showToast(
                            msg: "Lapangan Berhasil Ditambahkan",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.SNACKBAR,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 15.0,
                          );
                        });
                      } else {
                        Fluttertoast.showToast(
                          msg: "Please complete all fields and upload an image",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.SNACKBAR,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 15.0,
                        );
                      }
                    },
                    child: const Text(
                      "Add Field!",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
