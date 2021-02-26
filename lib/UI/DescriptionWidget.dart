import 'package:flutter/material.dart';

class DescriptionWidget extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<DescriptionWidget> {
  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(alignment: Alignment.topCenter, children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/goststory.jpg",
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    alignment: Alignment.center,
                  )
                ]),
          ),
          Container(
              color: Colors.grey[800],
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Padding(
                  padding:
                      EdgeInsets.only(top: 25, left: 10, right: 10, bottom: 10),
                  child: Text(
                    "Lorem Ipsum is simply dummy text of the "
                    "printing and typesetting industry. Lorem Ipsum has been "
                    "the industry's standard dummy text ever since the 1500s,"
                    " when an unknown printer took a galley of type and "
                    "scrambled it to make a type specimen book. ",
                    // "It has survived not only five centuries, but also the "
                    // "leap into electronic typesetting, remaining "
                    // "essentially unchanged. It was popularised in the 1960s"
                    // " with the release of Letraset sheets containing Lorem Ipsum "
                    // "passages, and more recently with desktop publishing software "
                    // "like Aldus PageMaker including versions of Lorem Ipsum.",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ))),
        ]),
      ],
    )));
  }
}
