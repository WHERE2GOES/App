typedef RouteGuidanceItemProp = ({
  String description,
  RouteGuidanceType routeGuidanceType,
  int distance,
});

enum RouteGuidanceType { straight, turnLeft, turnRight, crosswalk }
