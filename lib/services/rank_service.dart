import 'package:clean_space/app/locator.dart';
import 'package:clean_space/models/area.dart';
import 'package:clean_space/services/posts_service.dart';

class RankService {
  PostsService _postsService = locator<PostsService>();

  Future<int> calculatePointsOfArea(Location location) async {
    int numberOfAppreciation =
        await _postsService.getPostsByAreaCount(location, isComplaint: false);
    int numberOfComplaints =
        await _postsService.getPostsByAreaCount(location, isComplaint: true);

    return numberOfAppreciation - numberOfComplaints;
  }

  Future<List<Location>> sortAndFilterLocationsByRank(
      List<Location> locations) async {
    await Future.forEach<Location>(locations, (location) async {
      location.point = await calculatePointsOfArea(location);
    });
    print(locations);
    locations.sort((first, second) => second.point.compareTo(first.point));
    print(locations);
    return locations;
  }

  Future<List<Location>> getAllLocations() async {
    List<String> allLocations =  await _postsService.getAllLocationsFromPost();
    return allLocations.map<Location>((locationString) => Location.fromString(locationString)).toList();
  }
}
