typedef RouteGuidanceItemProp = ({
  String description,
  RouteGuidanceType routeGuidanceType,
});

enum RouteGuidanceType { straight, turnLeft, turnRight, crosswalk }
