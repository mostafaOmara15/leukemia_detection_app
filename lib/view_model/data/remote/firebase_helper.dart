import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:leukemia_detection_app/model/patient_model.dart';

class FirebaseHelper {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Firebase Authentication methods
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    return await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> createUserWithEmailAndPassword(String email, String password) async {
    return await auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    return await auth.signOut();
  }

  Future<void> setData(String collection, String document, Map<String, dynamic> data) async {
    return await firestore.collection(collection).doc(document).set(data);
  }

  Future<Map<String, dynamic>?> getUserData(String userId) async {
    DocumentSnapshot snapshot = await firestore.collection('users').doc(userId).get();
    return snapshot.exists ? snapshot.data() as Map<String, dynamic> : null;
  }

  Future<Map<String, dynamic>?> getPatientsData(String patients) async {
    DocumentSnapshot snapshot = await firestore.collection('patients').doc(patients).get();
    return snapshot.exists ? snapshot.data() as Map<String, dynamic> : null;
  }

  Future<void> updateData(String collection, String? updateKey, Map<String, dynamic> data) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection(collection)
        .where('nationalId', isEqualTo: updateKey)
        .get();
    querySnapshot.docs.forEach((doc) async {
      return await FirebaseFirestore.instance.collection('patients').doc(doc.id).update(data);
    });
  }

  Future<void> deleteData(String collection, String? deleteKey) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection(collection)
        .where('nationalId', isEqualTo: deleteKey)
        .get();
    querySnapshot.docs.forEach((doc) async {
      await FirebaseFirestore.instance.collection('patients').doc(doc.id).delete();

    });
  }

  Future<List<PatientModel>?> getPatientsByExaminerId(String? examinerId) async {
    try {
      final snapshot = await firestore
          .collection('patients')
          .where('examiner', isEqualTo: examinerId)
          .get();

      final patients = snapshot.docs
          .map((doc) => PatientModel.fromJson(doc.data()))
          .toList();
      return patients;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<String?> uploadImage(File? imageFile) async {
    if (imageFile == null) {
      return null;
    }
    // create a reference to the Firebase Storage location where the image will be stored
    final storageRef = FirebaseStorage.instance.ref().child('images/${DateTime.now().toString()}');

    // upload the image to Firebase Storage
    final uploadTask = storageRef.putFile(imageFile!);
    final snapshot = await uploadTask.whenComplete(() {});

    // retrieve the download URL for the uploaded image
    final downloadURL = await snapshot.ref.getDownloadURL();

    return downloadURL;
  }
}
