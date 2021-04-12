import 'package:clean_space/app/locator.dart';
import 'package:clean_space/models/area.dart';
import 'package:clean_space/services/rank_service.dart';
import 'package:flutter/material.dart';

class RankTest extends StatefulWidget {
  @override
  _RankTestState createState() => _RankTestState();
}

class _RankTestState extends State<RankTest> {
  RankService _rankService = locator<RankService>();
  @override
  void initState() {

    super.initState();
  }

  Future<List<Location>> getRankedLocations()async{
    return _rankService.sortAndFilterLocationsByRank(await _rankService.getAllLocations()) ;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ranks"),
      ),
      body: Center(
        child: FutureBuilder<List<Location>>(
          future: getRankedLocations(),
          builder: (context, snapshot){
            if(snapshot.hasError){
              print("${snapshot.error}");
              return Text("ERROR");
            }

            if(!snapshot.hasData){
              return CircularProgressIndicator();
            }

            return ListView(
              padding: EdgeInsets.symmetric(vertical: 20),
              children: snapshot.data.map((l) => ListTile(
                leading: CircleAvatar(
                  child: Text(l.point.toString()),
                ),
                title: Text(l.toStringForDatabase()),
              )).toList(),
            );
          },
        ),
      ),
    );
  }
}
