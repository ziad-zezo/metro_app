import 'package:get/get.dart';
import 'package:metro_project/models/station_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  Future<List<StationModel>?> getStationsByLine({required int line}) async {
    try {
      final query = await Supabase.instance.client
          .from('stations')
          .select()
          .eq('line', "Line$line")
          .order("id");
      return query.map((row) => StationModel.fromJson(row)).toList();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
    return null;
  }

  Future<void> upload({required List<StationModel> stations}) async {
    await Supabase.instance.client
        .from('stations')
        .insert(stations.map((station) => station.toJson()).toList());
  }
}
