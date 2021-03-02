import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:singleton/DataModal.dart';
import 'package:singleton/player_constant.dart';

enum PlayerState {
  stopped,
  playing,
  paused,
}

class FullScreenMusic extends StatefulWidget {
  final String device;
  final Data data;
  final bool selected;
  FullScreenMusic(this.device, this.data, this.selected);

  @override
  _HomeScreenState createState() =>
      _HomeScreenState(this.device, this.data, this.selected);
}

class _HomeScreenState extends State<FullScreenMusic> {
  String device;
  final Data data;
  bool selected;
  bool _liked = false;

  _HomeScreenState(this.device, this.data, this.selected);
  PlayerConstant playerConstant = PlayerConstant();

  @override
  void initState() {
    super.initState();
    device = widget.device;
    selected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: NetworkImage(widget.data.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppBar(
                            title: Padding(
                                padding: EdgeInsets.only(right: 30),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Now Playing",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: widget.device == "tablet"
                                            ? 30
                                            : 20),
                                  ),
                                )),
                            backgroundColor: Colors.transparent,
                            elevation: 60.0,
                            leading: IconButton(
                                icon: Icon(Icons.arrow_back_ios,
                                    color: Colors.white,
                                    size: widget.device == "tablet" ? 33 : 25),
                                onPressed: () => {Navigator.pop(context)}),
                            brightness: Brightness.dark,
                          ),

                          // )
                        ],
                      ),
                      Positioned(
                          bottom: 0.0,
                          child: Container(
                              alignment: Alignment.bottomCenter,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                        right: 20,
                                        left: 20,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        //change here don't //worked
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                widget.data.title,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    // fontSize: 20.0,
                                                    fontSize: widget.device ==
                                                            "tablet"
                                                        ? 30
                                                        : 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                top: 5,
                                              )),
                                              Text(
                                                widget.data.author_name,
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: widget.device ==
                                                            "tablet"
                                                        ? 18
                                                        : 14.0),
                                              )
                                            ],
                                          ),
                                          IconButton(
                                            icon: new Icon(
                                                _liked
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                                color: _liked
                                                    ? Colors.red
                                                    : Colors.white,
                                                // size: 30,
                                                size: widget.device == "tablet"
                                                    ? 40
                                                    : 30),
                                            onPressed: () {
                                              setState(() {
                                                _liked = !_liked;
                                              });
                                            },
                                          )
                                          // This Icon
                                        ],
                                      )),

                                  // AudioWidget(),
                                  slider(),
                                  Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, right: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            // "1.0",
                                            playerConstant.position.inSeconds
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize:
                                                    widget.device == "tablet"
                                                        ? 17
                                                        : 12),
                                          ),
                                          Text(
                                            "10.0",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize:
                                                    widget.device == "tablet"
                                                        ? 17
                                                        : 12),
                                          )
                                        ],
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(
                                        top: 0,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                              icon: new Image.asset(
                                                'assets/backword.png',
                                              ),
                                              onPressed: () =>
                                                  {playerConstant.previous()},
                                              // iconSize: 50,
                                              iconSize:
                                                  widget.device == "tablet"
                                                      ? 70
                                                      : 50),
                                          StreamBuilder(
                                              stream: playerConstant
                                                  .playerBloc.counter,
                                              initialData:
                                                  playerConstant.isPlaying,
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
                                                  ),
                                                  iconSize:
                                                      widget.device == "tablet"
                                                          ? 90
                                                          : 70,
                                                  onPressed: () {
                                                    data.data
                                                        ? playerConstant.pause()
                                                        : playerConstant.play(
                                                            widget.data.audio,
                                                            widget.data
                                                                .author_name,
                                                            widget.data.image,
                                                            widget.data.title);
                                                  },
                                                );
                                              }),
                                          IconButton(
                                              icon: new Image.asset(
                                                  'assets/forward.png'),
                                              onPressed: () =>
                                                  {playerConstant.next()},
                                              iconSize:
                                                  widget.device == "tablet"
                                                      ? 70
                                                      : 50),
                                        ],
                                      )),
                                ],
                              )))
                    ],
                  )
                ]))));
  }

  Widget slider() {
    return SliderTheme(
        data: SliderTheme.of(context).copyWith(
          activeTrackColor: Colors.white,
          inactiveTrackColor: Colors.grey[500],
          trackHeight: 3.0,
          thumbColor: Colors.white,
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5.0),
        ),
        child: StreamBuilder<Duration>(
            initialData: Duration(seconds: 0),
            stream: playerConstant.assetsAudioPlayer.currentPosition,
            builder: (BuildContext context, AsyncSnapshot<Duration> snapshot) {
              print(snapshot.data.inSeconds.toDouble().toString());
              return Slider(
                  value: snapshot.data.inSeconds.toDouble(),
                  max: playerConstant
                      .assetsAudioPlayer.current.value.audio.duration.inSeconds
                      .toDouble(),
                  min: 0.0,
                  onChanged: (value) {
                    playerConstant.assetsAudioPlayer
                        .seek(Duration(seconds: value.toInt()));
                  });
            }));
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);

    playerConstant.assetsAudioPlayer.seek(newDuration);
  }
}
