import 'package:clean_space/app/locator.dart';
import 'package:clean_space/app/router.gr.dart';
import 'package:clean_space/models/area.dart';
import 'package:clean_space/services/rank_service.dart';
import 'package:clean_space/ui/utils/theme_colors.dart';
import 'package:clean_space/ui/views/rank/rank_widget.dart';
import 'package:clean_space/ui/views/widgets/custom_rounded_rectangular_button.dart';
import 'package:flutter/material.dart';

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
      backgroundColor: Colors.black12,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
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
                  padding: const EdgeInsets.all(8.0),
                  child: CustomRoundedRectangularButton(
                    color: Colors.white,
                    child: ListTile(
                      leading: Text(
                        (locationMap.key + 1).toString(),
                        style: TextStyle(color: ThemeColors.primary),
                      ),
                      title: Text(
                        locationMap.value.area,
                        style: TextStyle(color: ThemeColors.primary),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.areaFeedView,
                          arguments: AreaFeedViewArguments(
                            location: locationMap.value,
                          ));
                    },
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
                  decoration: BoxDecoration(
                      // color: Colors.black12,
                      // gradient: LinearGradient(
                      //   begin: Alignment.topCenter,
                      //   end: Alignment.bottomCenter,
                      //   colors: [
                      //     Colors.white,
                      //     ThemeColors.primary,
                      //   ],
                      // ),
                      ),
                  child: showRank(snapshot),
                ),
              ),

              Flexible(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
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
            height: 140,
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
                      padding: EdgeInsets.only(top: 24, left: 50),
                      child: Column(
                        children: [
                          Text(
                            locationList[1],
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 15),
                          Image.asset(
                            "assets/images/Silver Medal.png",
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 24, right: 50),
                      child: Column(
                        children: [
                          Text(
                            locationList[2],
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 15),
                          Image.asset(
                            "assets/images/Bronze Medal.png",
                            height: 50,
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
            height: 200,
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
                    padding: const EdgeInsets.only(top: 50),
                    child: Column(
                      children: [
                        Text(
                          locationList[0],
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                            alignment: Alignment.topCenter,
                            child: Image.asset(
                              "assets/images/Gold Medal.png",
                              height: 70,
                            )),
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
