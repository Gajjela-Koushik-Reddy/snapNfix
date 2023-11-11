import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:snapnfix/card_widgets/damage_report_card.dart';
// import 'package:snapnfix/card_widgets/damage_report_card.dart';
import 'package:snapnfix/views/DamageReporting/damage_report_storage.dart';

class DamageListView extends StatefulWidget {
  DamageListView({Key? key}) : super(key: key);
  final DamageReportStorage damageReportStorage = DamageReportStorage();

  @override
  State<DamageListView> createState() => _DamageListViewState();
}

class _DamageListViewState extends State<DamageListView> {
  late List<Map<String, dynamic>> damagesList = [];
  List<Widget> children = [];
  bool isLoaded = false;

  _readDamages() async {
    var data = await widget.damageReportStorage.readDamageReport();

    setState(() {
      damagesList = data;

      for (var data in damagesList) {
        children.add(DamageReportCard(title: data["data"]["Title"]));
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
