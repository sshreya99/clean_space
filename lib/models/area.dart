import 'package:clean_space/errors/failure.dart';

class Location {
  int point;
  String country = "";
  String state = "";
  String city = "";
  String area ="";

  static const String separator = ">";

  Location.fromString(String locationString) {
    List<String> locationStringSeparated = locationString.split(separator);
    if (locationStringSeparated.length != 4)
      throw Failure(message: "Invalid Location String!");
    country = locationStringSeparated[0];
    state = locationStringSeparated[1];
    city = locationStringSeparated[2];
    area = locationStringSeparated[3];
  }

  String toStringForDatabase(){
    return "$country$separator$state$separator$city$separator$area";
  }

  @override
  String toString() {
    return 'Location{point: $point, country: $country, state: $state, city: $city, area: $area}';
  }
}
