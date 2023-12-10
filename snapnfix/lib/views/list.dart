import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:snapnfix/card_widgets/damage_report_card.dart';
import 'package:snapnfix/views/DamageReporting/damage_report_storage.dart';

class DamageListView extends StatefulWidget {
  DamageListView({Key? key, required this.userCredential}) : super(key: key);
  final DamageReportStorage damageReportStorage = DamageReportStorage();
  final GoogleSignInAccount userCredential;

  @override
  State<DamageListView> createState() => _DamageListViewState();
}

class _DamageListViewState extends State<DamageListView> {
  late List<Map<String, dynamic>> damagesList = [];
  List<Widget> children = [];
  bool isLoaded = false;

  _readDamages() async {
    var data = await widget.damageReportStorage
        .readDamageReport(widget.userCredential.id);

    if (data.isEmpty) {
      children.add(const Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Text("No Items to Show, please add items"),
            )
          ],
        ),
      ));
    }

    setState(() {
      damagesList = data;

      for (var data in damagesList) {
        children.add(DamageReportCard(
          title: data["data"]["Title"],
          imageUrl: data["data"]["image"] ?? "",
          damageRating: "${data["data"]["DamageRating"]}",
          damagePosition: LatLng(data["data"]["Location"]["latitude"],
              data["data"]["Location"]["longitude"]),
          notes: data["data"]["Notes"],
          moreLocation: data["data"]["moreLocation"],
        ));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _readDamages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: children,
      ),
    ));
  }
}
