import 'dart:async';

class PlayerBloc {
  bool status = false;
  final StreamController<bool> _counter = StreamController.broadcast();
  Stream<bool> get counter => _counter.stream;


  final _query = StreamController<bool>();
  Sink<bool> get query => _query.sink;
  Stream<bool> get result => _query.stream;

  PlayerBloc() {
    result.listen((value) {
      status = value;
      _counter.add(status);
    });
  }

  void dispose() {
    _query.close();
    _counter.close();
  }

}