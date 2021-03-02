import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:singleton/UI/DrawerItem.dart';
import 'package:singleton/UI/homepage.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

class HomePageNew extends StatefulWidget {
  @override
  _HomePageNewState createState() => _HomePageNewState();
}

class _HomePageNewState extends State<HomePageNew> {
  GlobalKey<SliderMenuContainerState> _key =
      new GlobalKey<SliderMenuContainerState>();
  String title;

  var type = [
    'Filter By Author',
    'Short By Alphabetically',
    'Short By Popularity',
    'Short By Heart'
  ];
  String device;

  @override
  void initState() {
    title = "Home";
    super.initState();
    // TODO: implement initState

    getDeviceInfo();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SliderMenuContainer(
            appBarColor: Colors.black,
            key: _key,
            drawerIconColor: Colors.white,
            drawerIconSize: device == "tablet" ? 50 : 25,
            appBarPadding: EdgeInsets.only(left: 10, top: 30),
            sliderMenuOpenSize: MediaQuery.of(context).size.width / 1.5,

            // sliderMenuOpenSize: 200,
            // sliderMenuCloseSize: 100,

            title: Text(
              "title",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            trailing: PopupMenuButton<String>(
              padding: EdgeInsets.only(right: 10),

              // offset: const Offset(10, 0),
              color: Colors.black54,

              // icon: new Image.asset('assets/Group1.png', width: device == "tablet" ? 50:15,
              // height:  device == "tablet" ? 50:15,),

              icon: Icon(Icons.filter_alt,
                  color: Colors.white, size: device == "tablet" ? 50 : 20),
              onSelected: (String value) {},
              itemBuilder: (BuildContext context) {
                return type.map<PopupMenuItem<String>>((String value) {
                  return new PopupMenuItem(
                      child: Container(
                          width: MediaQuery.of(context).size.width / 2.3,
                          child: new Text(
                            value,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: device == "tablet" ? 20 : 15),
                          )),
                      value: value);
                }).toList();
              },
            ),
            sliderMenu: MenuWidget(
              onItemClick: (title) {
                _key.currentState.closeDrawer();
                setState(() {
                  this.title = title;
                });
              },
            ),
            sliderMain: Homepage()),
      ),
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
}
