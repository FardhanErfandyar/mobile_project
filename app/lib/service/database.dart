import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../pages/profile_setting/edit_Profile.dart';

// CREATE
class DatabaseFields {
  Future addFieldDetails(Map<String, dynamic> FieldInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Field Post")
        .doc(id)
        .set(FieldInfoMap);
  }

  // READ
  Future<Stream<QuerySnapshot>> getFieldDetails() async {
    return await FirebaseFirestore.instance
        .collection("Field Post")
        .snapshots();
  }

  // UPDATE
  Future updateFieldDetails(String id, Map<String, dynamic> updateInfo) async {
    return await FirebaseFirestore.instance
        .collection("Field Post")
        .doc(id)
        .update(updateInfo);
  }

  // DELETE
  Future deleteFieldDetails(String id) async {
    return await FirebaseFirestore.instance
        .collection("Field Post")
        .doc(id)
        .delete();
  }

  Future<void> _uploadImages(Map<String, dynamic> fieldinfo, String id) async {
    await FirebaseFirestore.instance
        .collection("Field Post")
        .doc(id)
        .set(fieldinfo);
  }

  Future<Map<String, dynamic>> getUserData() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser?.email)
        .get();
    return snapshot.data() as Map<String, dynamic>;
  }

  Future<void> updateUser(String id, Map<String, dynamic> updateProfile) async {
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(currentUser?.email)
          .update(updateProfile);
      Get.snackbar('Success', 'Profile updated successfully',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}

Future<void> updatePassword(
    String id, Map<String, dynamic> updatePassword) async {
  await FirebaseFirestore.instance
      .collection("Users")
      .doc(currentUser?.email)
      .update(updatePassword);
}


  // Future addFieldImg(Map<String, dynamic> userInfoMap, String name) async {
  //   return await FirebaseFirestore.instance.collection(name).add(userInfoMap);
  // }

