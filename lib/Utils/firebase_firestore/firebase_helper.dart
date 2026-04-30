


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_key/firebase_key.dart';

String docId = "";



class FirebaseHelper
{

  static var collection = FirebaseFirestore.instance.collection("User");

    Future<bool> checkIfNumberExists(String targetNumber) async {
    final querySnapshot = await collection
        .where(FirebaseKey.phoneNumber, isEqualTo: targetNumber)
        .limit(1)
        .get();
    return querySnapshot.docs.isEmpty;
  }


  static Future<List<QueryDocumentSnapshot<Object?>>> searchUsersByNumber({required TextEditingController controller})async
  {
    QuerySnapshot userNumber = await collection.
    orderBy(FirebaseKey.phoneNumber).startAt([controller.text]).endAt([controller.text + "\uf8ff"]).get();
  return userNumber.docs;
  }

  Future<void> createData({required Map<String,dynamic> data})
  async {
    try{
      SharedPreferences pref = await SharedPreferences.getInstance();
      collection.add(
          data
      ).then((value) {
        print(value.id);
        docId =value.id ;
        pref.setString("docId", docId);
      },);
    }
    catch(e)
    {
      print("Exception in CreateDate Method$e");

    }

  }

  void  updateData({required Map<String ,dynamic> data,})
  {
     try{
       print("data::::::::::::::::${data}");
       collection.doc(docId).update(data);
     }
     catch(e)
    {
      print("Exception in UpdateData Method$e");
    }
  }

  void  deleteData({required Map<String ,dynamic> data,})
  {
    collection.doc(docId).update(data);
  }


  Future<DocumentSnapshot<Map<String, dynamic>>?>  getData()
  async {

    try{
print("object::::::::::::::::::::::::::;; $docId");
      DocumentSnapshot<Map<String, dynamic>> userData;
      userData= await collection.doc(docId).get();
      return userData;

    }
    catch(e)
    {
      print("Exception in getDataMethod $e");
      return null;
    }


  }



}