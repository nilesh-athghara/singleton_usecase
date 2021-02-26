import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:singleton/DataModal.dart';
import 'package:singleton/UI/StoryDetailScreen.dart';

class Homepage extends StatefulWidget {
  final Data data;

  const Homepage({Key key, this.data}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState(this.data);
}

class _HomepageState extends State<Homepage> {
  bool showtextfield = true;
  bool _liked = false;
  String device;
  String audio;
  String title;
  String description;
  String image;
  String author_name;
  String other;
  String categoryId;

  final Data data;
  final databaseReference = FirebaseDatabase.instance.reference();

  final dbRef = FirebaseDatabase.instance.reference().child("Stories");
  QuerySnapshot querySnapshot;

  _HomepageState(this.data);

  @override
  void initState() {
    super.initState();
    getDeviceInfo();
    getAudioData().then((results) {
      setState(() {
        querySnapshot = results;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (querySnapshot != null) {
      return ListView.builder(
          primary: false,
          itemCount: querySnapshot.docs.length,
          padding: EdgeInsets.all(12),
          itemBuilder: (context, i) {
            return Column(children: <Widget>[
              InkWell(
                child: Container(
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 4,
                          color: Colors.transparent,
                          width: MediaQuery.of(context).size.width,
                          child: Image.network(
                            querySnapshot.docs[i].get('image'),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        new Positioned(
                            bottom: 0.0,
                            // left: 10,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    height:
                                        MediaQuery.of(context).size.height / 11,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: new BoxDecoration(
                                        image: new DecorationImage(
                                      image: new AssetImage(
                                        'assets/Rectangle.png',
                                      ),
                                      fit: BoxFit.cover,
                                    )),
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, bottom: 10, right: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  querySnapshot.docs[i]
                                                      .get('title'),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: device == "tablet"
                                                        ? 25
                                                        : 20,
                                                  ),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10)),
                                                Text(
                                                  querySnapshot.docs[i]
                                                      .get('author_name'),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: device == "tablet"
                                                        ? 16
                                                        : 11,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(right: 30),
                                                child: IconButton(
                                                  icon: new Icon(
                                                    _liked
                                                        ? Icons.favorite
                                                        : Icons.favorite_border,
                                                    color: _liked
                                                        ? Colors.red
                                                        : Colors.white,
                                                    size: device == "tablet"
                                                        ? 35
                                                        : 25,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      _liked = !_liked;
                                                    });
                                                  },
                                                ))
                                          ],
                                        ))),
                              ],
                            ))
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    shadowColor: Colors.grey,
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                  ),
                ),
                onTap: () {
                  Data data = Data(
                    querySnapshot.docs[i].get('audio'),
                    querySnapshot.docs[i].get('author_name'),
                    querySnapshot.docs[i].get('categoryId'),
                    querySnapshot.docs[i].get('description'),
                    querySnapshot.docs[i].get('image'),
                    querySnapshot.docs[i].get('title'),
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StoryDetailScreen(
                              device,
                              data,
                            )),
                  );
                },
              ),
              // )
            ]);
          });
    } else
      return Center(
        child: CircularProgressIndicator(),
      );
  }

  Future<void> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo info = await deviceInfo.iosInfo;
    if (info.name.toLowerCase().contains("ipad") && Device.get().isTablet) {
      device = "tablet";
    } else if (Device.get().isPhone &&
        info.name.toLowerCase().contains("iphone")) {
      device = "phone";
    }
  }

  getAudioData() async {
    return await FirebaseFirestore.instance
        .collection('Stories')
        .where('categoryId', isEqualTo: "VoHKjfbSDjI1hxH12lXC")
        .get();
  }
}
