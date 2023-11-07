import 'package:geolocator/geolocator.dart';
import 'package:snapnfix/firebase_options.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DamageReportStorage {
  bool _initialized = false;

  Future<void> initializeDefault() async {
    FirebaseApp app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _initialized = true;
    if (kDebugMode) {
      print("Initialized default Firebase app $app");
    }
  }

  DamageReportStorage();

  bool get isInitialized => _initialized;

  Future<bool> writeDamageReport(String damageRating, Position position,
      String notes, String title, String moreLocation) async {
    try {
      if (!isInitialized) {
        await initializeDefault();
      }
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      final documentReference = await firestore.collection("damages").add({
        "DamageRating": damageRating,
        "Location": {
          "latitude": position.latitude,
          "longitude": position.longitude,
        },
        "Notes": notes,
        "Title": title,
        "moreLocation": moreLocation,
      });
      if (kDebugMode) {
        print("Damage Report Value: $damageRating");
        print("Location: $position");
        print("Notes: $notes");
        print("Title: $title");
        print("Value: ${documentReference.id}");
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print("Failed to set text: $e");
      }
      return false; // Return false in case of an error
    }
  }
}
