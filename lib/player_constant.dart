import 'package:assets_audio_player/assets_audio_player.dart';
import 'player_bloc.dart';

enum PlayerState {
  stopped,
  playing,
  paused,
}

class PlayerConstant {
  static final PlayerConstant _instance = PlayerConstant._singleObject();
  PlayerConstant._singleObject();

  factory PlayerConstant() => _instance;

  final assetsAudioPlayer = AssetsAudioPlayer();

  String url;
  PlayerState _playerState = PlayerState.stopped;

  bool get isPlaying => _playerState == PlayerState.playing;

  Duration get position => _position;
  Duration _position = Duration();

  Duration get duration => _duration;
  Duration _duration = Duration();

  Function(Duration) seekTo;


  // final d = assetsAudioPlayer.current.value.audio.duration;
  PlayerBloc playerBloc = PlayerBloc();

  Future play(String url, String author_name, String title, String image) async {

    playerBloc.query.add(true);
    _playerState = PlayerState.playing;
    final audio = Audio.network(url,
      metas: Metas(
        title:  title,
        artist: author_name,
        image: MetasImage.network(image), //can be MetasImage.network
      ),
    );
    await assetsAudioPlayer.open(audio,
      loopMode: LoopMode.single, showNotification: true,);
    assetsAudioPlayer.play();
    // assetsAudioPlayer.next();
    // assetsAudioPlayer.previous();

  }

  Future pause() async {
    await assetsAudioPlayer.pause();
    _playerState = PlayerState.paused;
    playerBloc.query.add(false);
  }

  Future stop() async {
    await assetsAudioPlayer.stop();
    _playerState = PlayerState.stopped;
    playerBloc.query.add(false);
  }


  // Stream<Duration> getLength() {
  //   // var onDurationChanged;
  //   return assetsAudioPlayer.;
  // }
  Stream<Duration> getPosition() {
    return assetsAudioPlayer.currentPosition;
  }

  Future<int> changeSlider(Duration d){
    return assetsAudioPlayer.seek(d);
  }


  Future next() async{
    await assetsAudioPlayer.next();
    _playerState = PlayerState.playing;
    playerBloc.query.add(true);
}
  Future previous() async{
    await assetsAudioPlayer.previous();
    _playerState = PlayerState.playing;
    playerBloc.query.add(true);

  }

}