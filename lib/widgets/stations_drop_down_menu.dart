import 'package:flutter/material.dart';

import '../models/station_model.dart';

class StationsDropDownMenu extends StatelessWidget {
  const StationsDropDownMenu({
    super.key,
    required this.label,
    this.initialStation,
    required this.onSelected,
    required this.stations,
  });
  final String label;
  final StationModel? initialStation;
  final Function(StationModel?) onSelected;
  final List<StationModel> stations;
  @override
  Widget build(BuildContext context) {
    return DropdownMenu<StationModel>(
      width: double.infinity, // or a fixed width like 300
      // focusNode: fromFocusNode,
      label: Text(label),
      initialSelection: initialStation,
      menuHeight: 250,
      onSelected: onSelected,
      leadingIcon: Icon((Icons.directions_train_rounded)),
      dropdownMenuEntries: [
        for (var station in stations)
          DropdownMenuEntry(value: station, label: station.name),
      ],
    );
  }
}
