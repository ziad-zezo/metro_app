import 'package:geolocator/geolocator.dart';
import 'package:metro_project/models/station_model.dart';

List<StationModel>? line1Stations;
List<StationModel>? line2Stations;
List<StationModel>? line3Stations;

List<StationModel> getAllStations() {
  if(line1Stations==null||line2Stations==null||line3Stations==null) {
    return [...line1StationsTemp, ...line2StationsTemp, ...line3StationsTemp];
  } else {
    return [...line1Stations!, ...line2Stations!, ...line3Stations!];
  }
}

Future<StationModel> getNearestStation(
  final double latitude,
  final double longitude,
  final List<StationModel> stations,
) async {
  StationModel? nearestStation;
  for (var station in stations) {
    double distance = Geolocator.distanceBetween(
      latitude,
      longitude,
      double.parse(station.address.latitude),
      double.parse(station.address.longitude),
    );

    if (nearestStation == null || distance < nearestStation.distance!) {
      nearestStation = station;
      nearestStation.distance = distance;
    }
  }

  return nearestStation!;
}





 final List<StationModel> line1StationsTemp = [
    StationModel(
      'Line1',
      name: 'New El Marg',
      address: Address(latitude: '30.163659', longitude: '31.338369'),
    ),
    StationModel(
      'Line1',
      name: 'El Marg',
      address: Address(latitude: '30.163659', longitude: '31.338369'),
    ),
    StationModel(
      'Line1',
      name: 'Ezbet El Nakhl',
      address: Address(latitude: '30.139324', longitude: '31.324424'),
    ),
    StationModel(
      'Line1',
      name: 'Ain Shams',
      address: Address(latitude: '30.130787', longitude: '31.319652'),
    ),
    StationModel(
      'Line1',
      name: 'El Matarya',
      address: Address(latitude: '30.121344', longitude: '31.313725'),
    ),
    StationModel(
      'Line1',
      name: 'Helmeyet El Zaitoun',
      address: Address(latitude: '30.113254', longitude: '31.313964'),
    ),
    StationModel(
      'Line1',
      name: 'Hadayeq El Zaitoun',
      address: Address(latitude: '30.105894', longitude: '31.310488'),
    ),
    StationModel(
      'Line1',
      name: 'Saray El Qobba',
      address: Address(latitude: '30.097649', longitude: '31.304569'),
    ),
    StationModel(
      'Line1',
      name: 'Hammamat El Qobba',
      address: Address(latitude: '30.091243', longitude: '31.298917'),
    ),
    StationModel(
      'Line1',
      name: 'Kobri El Qobba',
      address: Address(latitude: '30.087205', longitude: '31.294111'),
    ),
    StationModel(
      'Line1',
      name: 'Manshiet El Sadr',
      address: Address(latitude: '30.081992', longitude: '31.287536'),
    ),
    StationModel(
      'Line1',
      name: 'El Demerdash',
      address: Address(latitude: '30.076785', longitude: '31.277275'),
    ),
    StationModel(
      'Line1',
      name: 'Ghamra',
      address: Address(latitude: '30.069033', longitude: '31.264620'),
    ),
    StationModel(
      'Line1',
      name: 'El Shohadaa',
      address: Address(latitude: '30.060613', longitude: '31.246424'),
    ),
    StationModel(
      'Line1',
      name: 'Orabi',
      address: Address(latitude: '30.056691', longitude: '31.242051'),
    ),
    StationModel(
      'Line1',
      name: 'Nasser',
      address: Address(latitude: '30.053506', longitude: '31.238730'),
    ),
    StationModel(
      'Line1',
      name: 'Sadat',
      address: Address(latitude: '30.044143', longitude: '31.234426'),
    ),
    StationModel(
      'Line1',
      name: 'Saad Zaghloul',
      address: Address(latitude: '30.037038', longitude: '31.238362'),
    ),
    StationModel(
      'Line1',
      name: 'Sayeda Zeinab',
      address: Address(latitude: '30.029292', longitude: '31.235434'),
    ),
    StationModel(
      'Line1',
      name: 'El Malek El Saleh',
      address: Address(latitude: '30.017708', longitude: '31.231213'),
    ),
    StationModel(
      'Line1',
      name: 'Mar Girgis',
      address: Address(latitude: '30.006106', longitude: '31.229628'),
    ),
    StationModel(
      'Line1',
      name: 'El Zahraa',
      address: Address(latitude: '29.995488', longitude: '31.231182'),
    ),
    StationModel(
      'Line1',
      name: 'Dar El Salam',
      address: Address(latitude: '29.982071', longitude: '31.242175'),
    ),
    StationModel(
      'Line1',
      name: 'Hadayek El Maadi',
      address: Address(latitude: '29.982071', longitude: '31.242175'),
    ),
    StationModel(
      'Line1',
      name: 'Maadi',
      address: Address(latitude: '29.960307', longitude: '31.257647'),
    ),
    StationModel(
      'Line1',
      name: 'Sakanat El Maadi',
      address: Address(latitude: '29.952906', longitude: '31.263417'),
    ),
    StationModel(
      'Line1',
      name: 'Tora El Balad',
      address: Address(latitude: '29.946769', longitude: '31.272985'),
    ),
    StationModel(
      'Line1',
      name: 'Kozzika',
      address: Address(latitude: '29.936264', longitude: '31.281820'),
    ),
    StationModel(
      'Line1',
      name: 'Tora El Asmant',
      address: Address(latitude: '29.925972', longitude: '31.287547'),
    ),
    StationModel(
      'Line1',
      name: 'El Maasara',
      address: Address(latitude: '29.906083', longitude: '31.299515'),
    ),
    StationModel(
      'Line1',
      name: 'Hadayek Helwan',
      address: Address(latitude: '29.906083', longitude: '31.299515'),
    ),
    StationModel(
      'Line1',
      name: 'Wadi Hof',
      address: Address(latitude: '29.879095', longitude: '31.313610'),
    ),
    StationModel(
      'Line1',
      name: 'Ain Helwan',
      address: Address(latitude: '29.862617', longitude: '31.324882'),
    ),
    StationModel(
      'Line1',
      name: 'Helwan',
      address: Address(latitude: '29.854133', longitude: '31.331596'),
    ),
  ];
  final List<StationModel> line2StationsTemp = [
    StationModel(
      'Line2',
      name: 'Shubra El Kheima',
      address: Address(latitude: '30.124148', longitude: '31.243305'),
    ),
    StationModel(
      'Line2',
      name: 'Kolyat El Zeraa',
      address: Address(latitude: '30.113689', longitude: '31.248673'),
    ),
    StationModel(
      'Line2',
      name: 'Mezallat',
      address: Address(latitude: '30.104177', longitude: '31.245645'),
    ),
    StationModel(
      'Line2',
      name: 'Khalafawy',
      address: Address(latitude: '30.097235', longitude: '31.245497'),
    ),
    StationModel(
      'Line2',
      name: 'St. Teresa',
      address: Address(latitude: '30.087959', longitude: '31.245497'),
    ),
    StationModel(
      'Line2',
      name: 'Rod El Farag',
      address: Address(latitude: '30.101906', longitude: '31.184425'),
    ),
    StationModel(
      'Line2',
      name: 'Masarra',
      address: Address(latitude: '30.070899', longitude: '31.245105'),
    ),
    StationModel(
      'Line2',
      name: 'El Shohadaa',
      address: Address(latitude: '30.061366', longitude: '31.246164'),
    ), // shared with Line 1
    StationModel(
      'Line2',
      name: 'Attaba',
      address: Address(latitude: '30.052349', longitude: '31.246798'),
    ),
    StationModel(
      'Line2',
      name: 'Naguib',
      address: Address(latitude: '30.045323', longitude: '31.244163'),
    ),
    StationModel(
      'Line2',
      name: 'Sadat',
      address: Address(latitude: '30.044146', longitude: '31.234434'),
    ), // shared with Line 1
    StationModel(
      'Line2',
      name: 'Opera',
      address: Address(latitude: '30.041951', longitude: '31.224981'),
    ),
    StationModel(
      'Line2',
      name: 'Dokki',
      address: Address(latitude: '30.038439', longitude: '31.212231'),
    ),
    StationModel(
      'Line2',
      name: 'Bohooth',
      address: Address(latitude: '30.035599', longitude: '31.200139'),
    ),
    StationModel(
      'Line2',
      name: 'Cairo University',
      address: Address(latitude: '30.025341', longitude: '31.201789'),
    ),
    StationModel(
      'Line2',
      name: 'Faisal',
      address: Address(latitude: '30.017054', longitude: '31.203978'),
    ),
    StationModel(
      'Line2',
      name: 'Giza',
      address: Address(latitude: '30.011233', longitude: '31.206567'),
    ),
    StationModel(
      'Line2',
      name: 'Omm El Misryeen',
      address: Address(latitude: '30.005657', longitude: '31.208125'),
    ),
    StationModel(
      'Line2',
      name: 'Sakiat Mekki',
      address: Address(latitude: '29.995491', longitude: '31.208656'),
    ),
    StationModel(
      'Line2',
      name: 'El Monib',
      address: Address(latitude: '29.981090', longitude: '31.212322'),
    ),
  ];
  final List<StationModel> line3StationsTemp = [
    StationModel(
      'Line3',
      name: 'Adly Mansour',
      address: Address(latitude: '30.1470178', longitude: '31.4212334'),
    ),
    StationModel(
      'Line3',
      name: 'El Nozha',
      address: Address(latitude: '24.7481415', longitude: '46.7123377'),
    ),
    StationModel(
      'Line3',
      name: 'Hisham Barakat',
      address: Address(latitude: '30.1308273', longitude: '31.3729342'),
    ),
    StationModel(
      'Line3',
      name: 'Omar Ibn El Khattab',
      address: Address(latitude: '30.1403777', longitude: '31.3943449'),
    ),
    StationModel(
      'Line3',
      name: 'Qobaa',
      address: Address(latitude: '30.1348259', longitude: '31.3837468'),
    ),
    StationModel(
      'Line3',
      name: 'Haykestep',
      address: Address(latitude: '31.1438512', longitude: '31.4046952'),
    ),
    StationModel(
      'Line3',
      name: 'El Shams Club',
      address: Address(latitude: '30.1258187', longitude: '31.3487936'),
    ),
    StationModel(
      'Line3',
      name: 'Alf Maskan',
      address: Address(latitude: '30.1187129', longitude: '31.3400513'),
    ),
    StationModel(
      'Line3',
      name: 'Heliopolis Square',
      address: Address(latitude: '30.1084161', longitude: '31.3383119'),
    ),
    StationModel(
      'Line3',
      name: 'Haroun',
      address: Address(latitude: '30.1013792', longitude: '31.3329857'),
    ),
    StationModel(
      'Line3',
      name: 'Al Ahram',
      address: Address(latitude: '30.0916945', longitude: '31.3262949'),
    ),
    StationModel(
      'Line3',
      name: 'Kolleyet El Banat',
      address: Address(latitude: '30.0834405', longitude: '31.3288437'),
    ),
    StationModel(
      'Line3',
      name: 'Stadium',
      address: Address(latitude: '30.0731738', longitude: '31.3172864'),
    ),
    StationModel(
      'Line3',
      name: 'Fair Zone',
      address: Address(latitude: '30.0737976', longitude: '31.3015079'),
    ),
    StationModel(
      'Line3',
      name: 'Abbassia',
      address: Address(latitude: '30.0720747', longitude: '31.2833390'),
    ),
    StationModel(
      'Line3',
      name: 'Abdou Pasha',
      address: Address(latitude: '30.0649168', longitude: '31.2749135'),
    ),
    StationModel(
      'Line3',
      name: 'El Geish',
      address: Address(latitude: '30.0617275', longitude: '31.2670282'),
    ),
    StationModel(
      'Line3',
      name: 'Bab El Shaaria',
      address: Address(latitude: '30.0541670', longitude: '31.2563801'),
    ),
    StationModel(
      'Line3',
      name: 'Attaba',
      address: Address(latitude: '30.0523497', longitude: '31.2468097'),
    ),
    // shared with Line 2
    StationModel(
      'Line3',
      name: 'Nasser',
      address: Address(latitude: '30.0534978', longitude: '31.2387352'),
    ),
    // shared with Line 1
    StationModel(
      'Line3',
      name: 'Maspero',
      address: Address(latitude: '30.0557230', longitude: '31.2321125'),
    ),
    StationModel(
      'Line3',
      name: 'Zamalek',
      address: Address(latitude: '30.0627367', longitude: '31.2219355'),
    ),
    StationModel(
      'Line3',
      name: 'Kit Kat',
      address: Address(latitude: '30.0665499', longitude: '31.2130259'),
    ),
    StationModel(
      'Line3',
      name: 'Sudan',
      address: Address(latitude: '30.070066', longitude: '31.2044574'),
    ),
    StationModel(
      'Line3',
      name: 'Imbaba',
      address: Address(latitude: '30.0758672', longitude: '31.2071985'),
    ),
    StationModel(
      'Line3',
      name: 'EL_Bohy',
      address: Address(latitude: '30.0821697', longitude: '31.2103768'),
    ),
    StationModel(
      'Line3',
      name: 'EL-Qwamia',
      address: Address(latitude: '30.093279', longitude: '31.2088594'),
    ),
    StationModel(
      'Line3',
      name: 'Ring Road',
      address: Address(latitude: '30.0964655', longitude: '31.199314'),
    ),
  ];