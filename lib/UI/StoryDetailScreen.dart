import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:singleton/DataModal.dart';
import 'package:singleton/UI/FullScreenMusic.dart';
import 'package:singleton/player_constant.dart';

enum PlayerState {
  stopped,
  playing,
  paused,
}

class StoryDetailScreen extends StatefulWidget {
  final String device;
  final Data data;
  StoryDetailScreen(
    this.device,
    this.data,
  );
  @override
  _HomeScreenState createState() => _HomeScreenState(this.device, this.data);
}

class _HomeScreenState extends State<StoryDetailScreen>
    with WidgetsBindingObserver {
  bool _liked = false;
  bool selected = true;
  String device;
  final Data data;
  PlayerConstant playerConstant = PlayerConstant();
  _HomeScreenState(this.device, this.data);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    init();
  }

  init() async {
    if (playerConstant.isPlaying) {
      await playerConstant.stop();
    }
    playerConstant.play(widget.data.audio, widget.data.author_name,
        widget.data.image, widget.data.title);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
              padding: EdgeInsets.only(right: 20),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Now Playing",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: widget.device == "tablet" ? 25 : 20),
                ),
              )),
          backgroundColor: Colors.black,
          elevation: 60.0,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: widget.device == "tablet" ? 30 : 25,
              ),
              onPressed: () {
                // _pause();
                Navigator.pop(context);
              }),
          actions: [
            IconButton(
              icon: new Icon(_liked ? Icons.favorite : Icons.favorite_border,
                  color: _liked ? Colors.red : Colors.white,
                  size: widget.device == "tablet" ? 30 : 25),
              onPressed: () {
                setState(() {
                  _liked = !_liked;
                });
              },
            )
          ],
          brightness: Brightness.dark,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: Stack(children: [
            SingleChildScrollView(
                child: Column(
              children: [
                Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          right: 20,
                          left: 20,
                          top: 20,
                          bottom: MediaQuery.of(context).size.height / 8),
                      child: Text(widget.data.description,
                          style: TextStyle(
                              fontSize: widget.device == "tablet" ? 30 : 15.0,
                              color: Colors.grey)),
                    ),
                  ],
                )),
              ],
            )),
            Positioned(
                bottom: 0.0,
                child: InkWell(
                  child: new Container(
                    // height: 100,
                    height: MediaQuery.of(context).size.height / 8,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black,
                    child: Row(
                      children: [
                        Container(
                          // margin: EdgeInsets.only(bottom: 15),
                          height: MediaQuery.of(context).size.height / 8,
                          // width: 100,
                          width: MediaQuery.of(context).size.width / 4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 1, color: Colors.black),
                              image: DecorationImage(
                                  image: NetworkImage(widget.data.image),
                                  fit: BoxFit.cover)
                              // image: new DecorationImage(image: new Image.network(widget.data.image),
                              //     fit: BoxFit.cover)
                              ),
                        ),
                        Container(
                            alignment: Alignment.centerRight,
                            width: MediaQuery.of(context).size.width / 1.5,
                            margin:
                                EdgeInsets.only(top: 10, left: 10, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(widget.data.title,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                                  device == "tablet" ? 30 : 20,
                                            ),
                                            maxLines: 2),
                                        Text(
                                          widget.data.author_name,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                                  device == "tablet" ? 18 : 12),
                                          maxLines: 2,
                                        ),
                                      ],
                                    )),
                                Container(
                                    height:
                                        MediaQuery.of(context).size.height / 8,
                                    // width: 80,
                                    margin: EdgeInsets.only(right: 10),
                                    child: StreamBuilder(
                                        stream:
                                            playerConstant.playerBloc.counter,
                                        initialData: playerConstant.isPlaying,
                                        builder: (BuildContext context,
                                            AsyncSnapshot<bool> data) {
                                          return IconButton(
                                            icon: Icon(
                                                data.data
                                                    ? Icons
                                                        .pause_circle_filled_outlined
                                                    : Icons
                                                        .play_circle_fill_outlined,
                                                color: Colors.white,
                                                size: widget.device == "tablet"
                                                    ? 90
                                                    : 50),
                                            onPressed: () {
                                              data.data
                                                  ? playerConstant.pause()
                                                  : playerConstant.play(
                                                      widget.data.audio,
                                                      widget.data.author_name,
                                                      widget.data.image,
                                                      widget.data.title);
                                            },
                                          );
                                        })),
                              ],
                            ))
                      ],
                    ),
                  ),
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FullScreenMusic(
                              device = widget.device, data, selected)),
                    )
                  },
                )),
          ]),
        ));
  }
}
