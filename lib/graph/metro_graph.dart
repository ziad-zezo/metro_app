import 'dart:collection';
import '../models/station_model.dart';

Map<StationModel, List<StationModel>> buildGraph(
  List<StationModel> line1Stations,
  List<StationModel> line2Stations,
  List<StationModel> line3Stations,
) {
  final graph = <StationModel, List<StationModel>>{};
  final allStations = [...line1Stations, ...line2Stations, ...line3Stations];

  void connectLine(List<StationModel> line) {
    for (int i = 0; i < line.length; i++) {
      final station = line[i];
      graph.putIfAbsent(station, () => []);

      if (i > 0) {
        graph[station]!.add(line[i - 1]);
        graph[line[i - 1]]!.add(station);
      }
    }
  }

  connectLine(line1Stations);
  connectLine(line2Stations);
  connectLine(line3Stations);

  final nameToStations = <String, List<StationModel>>{};
  for (final station in allStations) {
    nameToStations.putIfAbsent(station.name.trim(), () => []).add(station);
  }

  for (final stations in nameToStations.values.where((s) => s.length > 1)) {
    for (final station in stations) {
      for (final other in stations) {
        if (station != other && !graph[station]!.contains(other)) {
          graph[station]!.add(other);
          graph[other]!.add(station);
        }
      }
    }
  }

  return graph;
}

List<StationModel> bfsRoute(
  StationModel start,
  StationModel goal,
  Map<StationModel, List<StationModel>> graph,
) {
  final queue = Queue<StationModel>();
  final visited = <StationModel, StationModel?>{};

  queue.add(start);
  visited[start] = null;

  while (queue.isNotEmpty) {
    final current = queue.removeFirst();

    if (current.name.trim() == goal.name.trim()) {
      final path = <StationModel>[];
      StationModel? step = current;

      while (step != null) {
        path.insert(0, step);
        step = visited[step];
      }
      return path;
    }

    for (final neighbor in graph[current] ?? []) {
      if (!visited.containsKey(neighbor)) {
        visited[neighbor] = current;
        queue.add(neighbor);
      }
    }
  }

  return [];
}
