class DirectionMaps {
  DirectionMaps({
    required this.routes,
    required this.waypoints,
    required this.code,
    required this.uuid,
  });

  final List<Route> routes;
  final List<Waypoint> waypoints;
  final String? code;
  final String? uuid;

  factory DirectionMaps.fromJson(Map<String, dynamic> json) {
    return DirectionMaps(
      routes:
          json["routes"] == null
              ? []
              : List<Route>.from(json["routes"].map((x) => Route.fromJson(x))),
      waypoints:
          json["waypoints"] == null
              ? []
              : List<Waypoint>.from(
                json["waypoints"].map((x) => Waypoint.fromJson(x)),
              ),
      code: json["code"],
      uuid: json["uuid"],
    );
  }
}

class Route {
  Route({
    required this.weightName,
    required this.weight,
    required this.duration,
    required this.distance,
    required this.legs,
    required this.geometry,
  });

  final String? weightName;
  final double? weight;
  final double? duration;
  final double? distance;
  final List<Leg> legs;
  final Geometry? geometry;

  factory Route.fromJson(Map<String, dynamic> json) {
    return Route(
      weightName: json["weight_name"],
      weight: json["weight"],
      duration: json["duration"],
      distance: json["distance"],
      legs:
          json["legs"] == null
              ? []
              : List<Leg>.from(json["legs"].map((x) => Leg.fromJson(x))),
      geometry:
          json["geometry"] == null ? null : Geometry.fromJson(json["geometry"]),
    );
  }
}

class Geometry {
  Geometry({required this.coordinates, required this.type});

  final List<List<double>> coordinates;
  final String? type;

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      coordinates:
          json["coordinates"] == null
              ? []
              : List<List<double>>.from(
                json["coordinates"].map(
                  (x) => x == null ? [] : List<double>.from(x.map((x) => x)),
                ),
              ),
      type: json["type"],
    );
  }
}

class Leg {
  Leg({
    required this.viaWaypoints,
    required this.admins,
    required this.weight,
    required this.duration,
    required this.steps,
    required this.distance,
    required this.summary,
  });

  final List<dynamic> viaWaypoints;
  final List<Admin> admins;
  final double? weight;
  final double? duration;
  final List<Step> steps;
  final double? distance;
  final String? summary;

  factory Leg.fromJson(Map<String, dynamic> json) {
    return Leg(
      viaWaypoints:
          json["via_waypoints"] == null
              ? []
              : List<dynamic>.from(json["via_waypoints"].map((x) => x)),
      admins:
          json["admins"] == null
              ? []
              : List<Admin>.from(json["admins"].map((x) => Admin.fromJson(x))),
      weight: json["weight"],
      duration: json["duration"],
      steps:
          json["steps"] == null
              ? []
              : List<Step>.from(json["steps"].map((x) => Step.fromJson(x))),
      distance: json["distance"],
      summary: json["summary"],
    );
  }
}

class Admin {
  Admin({required this.iso31661Alpha3, required this.iso31661});

  final String? iso31661Alpha3;
  final String? iso31661;

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      iso31661Alpha3: json["iso_3166_1_alpha3"],
      iso31661: json["iso_3166_1"],
    );
  }
}

class Step {
  Step({
    required this.intersections,
    required this.maneuver,
    required this.name,
    required this.duration,
    required this.distance,
    required this.drivingSide,
    required this.weight,
    required this.mode,
    required this.geometry,
    required this.destinations,
    required this.ref,
  });

  final List<Intersection> intersections;
  final Maneuver? maneuver;
  final String? name;
  final double? duration;
  final double? distance;
  final String? drivingSide;
  final double? weight;
  final String? mode;
  final Geometry? geometry;
  final String? destinations;
  final String? ref;

  factory Step.fromJson(Map<String, dynamic> json) {
    return Step(
      intersections:
          json["intersections"] == null
              ? []
              : List<Intersection>.from(
                json["intersections"].map((x) => Intersection.fromJson(x)),
              ),
      maneuver:
          json["maneuver"] == null ? null : Maneuver.fromJson(json["maneuver"]),
      name: json["name"],
      duration: json["duration"],
      distance: json["distance"],
      drivingSide: json["driving_side"],
      weight: json["weight"],
      mode: json["mode"],
      geometry:
          json["geometry"] == null ? null : Geometry.fromJson(json["geometry"]),
      destinations: json["destinations"],
      ref: json["ref"],
    );
  }
}

class Intersection {
  Intersection({
    required this.entry,
    required this.bearings,
    required this.duration,
    required this.mapboxStreetsV8,
    required this.isUrban,
    required this.adminIndex,
    required this.out,
    required this.weight,
    required this.geometryIndex,
    required this.location,
    required this.intersectionIn,
    required this.turnWeight,
    required this.turnDuration,
    required this.trafficSignal,
    required this.yieldSign,
    required this.classes,
  });

  final List<bool> entry;
  final List<int> bearings;
  final double? duration;
  final MapboxStreetsV8? mapboxStreetsV8;
  final bool? isUrban;
  final int? adminIndex;
  final int? out;
  final double? weight;
  final int? geometryIndex;
  final List<double> location;
  final int? intersectionIn;
  final int? turnWeight;
  final double? turnDuration;
  final bool? trafficSignal;
  final bool? yieldSign;
  final List<String> classes;

  factory Intersection.fromJson(Map<String, dynamic> json) {
    return Intersection(
      entry:
          json["entry"] == null
              ? []
              : List<bool>.from(json["entry"].map((x) => x)),
      bearings:
          json["bearings"] == null
              ? []
              : List<int>.from(json["bearings"].map((x) => x)),
      duration: json["duration"],
      mapboxStreetsV8:
          json["mapbox_streets_v8"] == null
              ? null
              : MapboxStreetsV8.fromJson(json["mapbox_streets_v8"]),
      isUrban: json["is_urban"],
      adminIndex: json["admin_index"],
      out: json["out"],
      weight: json["weight"],
      geometryIndex: json["geometry_index"],
      location:
          json["location"] == null
              ? []
              : List<double>.from(json["location"].map((x) => x)),
      intersectionIn: json["in"],
      turnWeight: json["turn_weight"],
      turnDuration: json["turn_duration"],
      trafficSignal: json["traffic_signal"],
      yieldSign: json["yield_sign"],
      classes:
          json["classes"] == null
              ? []
              : List<String>.from(json["classes"].map((x) => x)),
    );
  }
}

class MapboxStreetsV8 {
  MapboxStreetsV8({required this.mapboxStreetsV8Class});

  final String? mapboxStreetsV8Class;

  factory MapboxStreetsV8.fromJson(Map<String, dynamic> json) {
    return MapboxStreetsV8(mapboxStreetsV8Class: json["class"]);
  }
}

class Maneuver {
  Maneuver({
    required this.type,
    required this.instruction,
    required this.bearingAfter,
    required this.bearingBefore,
    required this.location,
    required this.modifier,
  });

  final String? type;
  final String? instruction;
  final int? bearingAfter;
  final int? bearingBefore;
  final List<double> location;
  final String? modifier;

  factory Maneuver.fromJson(Map<String, dynamic> json) {
    return Maneuver(
      type: json["type"],
      instruction: json["instruction"],
      bearingAfter: json["bearing_after"],
      bearingBefore: json["bearing_before"],
      location:
          json["location"] == null
              ? []
              : List<double>.from(json["location"].map((x) => x)),
      modifier: json["modifier"],
    );
  }
}

class Waypoint {
  Waypoint({
    required this.distance,
    required this.name,
    required this.location,
  });

  final double? distance;
  final String? name;
  final List<double> location;

  factory Waypoint.fromJson(Map<String, dynamic> json) {
    return Waypoint(
      distance: json["distance"],
      name: json["name"],
      location:
          json["location"] == null
              ? []
              : List<double>.from(json["location"].map((x) => x)),
    );
  }
}
