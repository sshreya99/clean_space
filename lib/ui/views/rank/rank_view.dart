import 'package:clean_space/app/locator.dart';
import 'package:clean_space/app/router.gr.dart';
import 'package:clean_space/models/area.dart';
import 'package:clean_space/services/rank_service.dart';
import 'package:clean_space/ui/utils/theme_colors.dart';
import 'package:clean_space/ui/views/rank/rank_widget.dart';
import 'package:clean_space/ui/views/widgets/custom_rounded_rectangular_button.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class RankView extends StatefulWidget {
  @override
  _RankViewState createState() => _RankViewState();
}

class _RankViewState extends State<RankView> {
  RankService _rankService = locator<RankService>();

  Future<List<Location>> getRankedLocations() async {
    return _rankService
        .sortAndFilterLocationsByRank(await _rankService.getAllLocations());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x11000000),
      appBar: AppBar(
        backgroundColor: Colors.white,
        actionsIconTheme: IconThemeData(color: ThemeColors.primary),
        elevation: 0,
        title: Text(
          "Ranking",
          style: TextStyle(
            color: ThemeColors.primary,
          ),
        ),
      ),
      body: FutureBuilder<List<Location>>(
        future: getRankedLocations(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("${snapshot.error}");
            return Text("ERROR");
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<dynamic> rankList = snapshot.data
              .asMap()
              .entries
              .map(
                (locationMap) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: CustomRoundedRectangularButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        Routes.areaFeedView,
                        arguments: AreaFeedViewArguments(
                          location: locationMap.value,
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          child: ClipPath(
                            clipper: StarClipper(10),
                            child: Container(
                              height: 35,
                              color: ThemeColors.primary,
                              child: Center(
                                child: Text(
                                  (locationMap.key + 1).toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                            child: Text(locationMap.value.area +
                                ", " +
                                locationMap.value.city)),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                        ),
                      ],
                    ),
                    color: Colors.white,
                  ),
                ),
              )
              .toList();
          print(rankList);
          return Column(
            children: [
              ///Custom Rank Widget
              Flexible(
                flex: 2,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: showRank(snapshot),
                  // child: Column(
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: [
                  //     Text("City Name"),
                  //     Image.asset(
                  //       "assets/images/rank.png",
                  //       width: MediaQuery.of(context).size.width * 0.8,
                  //     )
                  //   ],
                  // ),
                ),
              ),

              Flexible(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: Color(0xffF9F9F9),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.06),
                        blurRadius: 10.0,
                        offset: Offset(2, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    // padding: EdgeInsets.only(vertical: 20),
                    children: rankList,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget showRank(AsyncSnapshot<List<Location>> snapshot) {
    List locationList = [];
    locationList = snapshot.data.map((l) => l.area).toList();
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 120,
            width: 350,
            child: ClipPath(
              clipper: RankWidget(40),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.06),
                      blurRadius: 10.0,
                      offset: Offset(2, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 24, left: 40),
                      child: Column(
                        children: [
                          Text(
                            locationList[1],
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Image.asset(
                              "assets/images/Silver Medal.png",
                              height: 50,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 24, right: 40),
                      child: Column(
                        children: [
                          Text(
                            locationList[2],
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Image.asset(
                              "assets/images/Bronze Medal.png",
                              height: 50,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 150,
            height: 180,
            child: ClipPath(
              clipper: RankWidget(40),
              child: Material(
                elevation: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        blurRadius: 10.0,
                        offset: Offset(2, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      children: [
                        Text(
                          locationList[0],
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Image.asset(
                            "assets/images/Gold Medal.png",
                            height: 70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class StarClipper extends CustomClipper<Path> {
  StarClipper(this.numberOfPoints);

  /// The number of points of the star
  final int numberOfPoints;

  @override
  Path getClip(Size size) {
    double width = size.width;
    print(width);
    double halfWidth = width / 2;

    double bigRadius = halfWidth;

    double radius = halfWidth / 1.3;

    double degreesPerStep = _degToRad(360 / numberOfPoints);

    double halfDegreesPerStep = degreesPerStep / 2;

    var path = Path();

    double max = 2 * math.pi;

    path.moveTo(width, halfWidth);

    for (double step = 0; step < max; step += degreesPerStep) {
      path.lineTo(halfWidth + bigRadius * math.cos(step),
          halfWidth + bigRadius * math.sin(step));
      path.lineTo(halfWidth + radius * math.cos(step + halfDegreesPerStep),
          halfWidth + radius * math.sin(step + halfDegreesPerStep));
    }

    path.close();
    return path;
  }

  num _degToRad(num deg) => deg * (math.pi / 180.0);

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    StarClipper oldie = oldClipper as StarClipper;
    return numberOfPoints != oldie.numberOfPoints;
  }
}
