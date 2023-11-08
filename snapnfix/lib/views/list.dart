import 'package:flutter/material.dart';
import 'package:snapnfix/views/DamageReporting/damage_report_storage.dart';

class DamageListView extends StatefulWidget {
  DamageListView({super.key});
  final DamageReportStorage damageReportStorage = DamageReportStorage();

  @override
  State<DamageListView> createState() => _DamageListViewState();
}

class _DamageListViewState extends State<DamageListView> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          await widget.damageReportStorage.readDamageReport();
        },
        icon: const SizedBox(
          child: Text("Submit"),
        ));
  }
}
