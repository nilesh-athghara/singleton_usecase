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
  Duration _position = Duration(milliseconds: 0);

  Duration get duration => _duration;
  Duration _duration = Duration(milliseconds: 0);

  PlayerBloc playerBloc = PlayerBloc();

  Future play(String url) async {
    playerBloc.query.add(true);
    _playerState = PlayerState.playing;
    await assetsAudioPlayer.open(Audio.network(url),
        loopMode: LoopMode.single, showNotification: false,);
    assetsAudioPlayer.play();
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
}
