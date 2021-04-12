import 'package:clean_space/app/locator.dart';
import 'package:clean_space/models/area.dart';
import 'package:clean_space/services/complaints_service.dart';
import 'package:clean_space/services/posts_service.dart';

class RankService {
  PostsService _postsService = locator<PostsService>();
  ComplaintsService _complaintsService = locator<ComplaintsService>();

  Future<int> calculatePointsOfArea(Location location) async {
    int numberOfAppreciation =
        await _postsService.getPostsByAreaCount(location);
    int numberOfComplaints =
        await _complaintsService.getComplaintsByAreaCount(location);

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
    List<String> allLocations =  await _postsService.getAllLocationsFromPost() +
        await _complaintsService.getAllLocationsFromComplaints();

    return allLocations.toSet().map<Location>((locationString) => Location.fromString(locationString)).toList();
  }
}
