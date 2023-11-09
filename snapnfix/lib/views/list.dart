import 'package:flutter/material.dart';
import 'package:snapnfix/card_widgets/damage_report_card.dart';
import 'package:snapnfix/views/DamageReporting/damage_report_storage.dart';

class DamageListView extends StatefulWidget {
  DamageListView({super.key});
  final DamageReportStorage damageReportStorage = DamageReportStorage();

  @override
  State<DamageListView> createState() => _DamageListViewState();
}

class _DamageListViewState extends State<DamageListView> {
  bool onChanged = false;

  List<Widget> buildList() {
    List<Widget> ret = [];

    for (int i = 0; i < 20; i++) {
      ret.add(const DamageReportCard());
    }

    return ret;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: buildList(),
      ),
    ));
  }
}
