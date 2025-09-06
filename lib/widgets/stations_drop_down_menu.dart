import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/station_model.dart';

class StationsDropDownMenu extends StatelessWidget {
  const StationsDropDownMenu({
    super.key,
    required this.label,
    this.initialStation,
    required this.onSelected,
    required this.stations,
    required this.focusNode,
  });

  final String label;
  final StationModel? initialStation;
  final Function(StationModel?) onSelected;
  final List<StationModel> stations;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final uniqueStations = {for (var s in stations) s.name: s}.values.toList();
    return DropdownMenu<StationModel>(
      key: UniqueKey(),
      closeBehavior: DropdownMenuCloseBehavior.all,
      menuStyle: MenuStyle(),
      width: double.infinity,
      // or a fixed width like 300
      focusNode: focusNode,
      requestFocusOnTap: true,
      enableSearch: true,
      enableFilter: true,
      // enableFilter: true,
      label: Text(label),
      initialSelection: initialStation,
      menuHeight: 250,
      onSelected: onSelected,
      leadingIcon: Icon((Icons.directions_train_rounded)),
      dropdownMenuEntries: [
        for (var station in uniqueStations)
          DropdownMenuEntry(value: station, label: station.name.tr),
      ],
    );
  }
}
