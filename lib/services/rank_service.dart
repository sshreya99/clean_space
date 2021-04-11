import 'package:clean_space/models/area.dart';
import 'package:clean_space/services/complaints_service.dart';
import 'package:clean_space/services/posts_service.dart';

class RankService{
  PostsServiceBase _postsService;
  ComplaintsServiceBase _complaintsService;

  Future<int> calculatePointsOfArea(Location area) async {
    int numberOfAppreciation = await _postsService.getPostsByAreaCount(area);
    int numberOfComplaints = await _complaintsService.getComplaintsByAreaCount(area);

    return numberOfAppreciation - numberOfComplaints;
  }

  Future<List<Location>> sortAreasByRank(List<Location> areas) async {
     areas.forEach((area) async {
      area..point = await calculatePointsOfArea(area);
    });

     areas.sort((first, second) => first.point.compareTo(second.point));
     print(areas);
  }
}