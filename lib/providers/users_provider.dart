import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/user_model.dart';

class UserProvider {
  final String _url = 'jsonplaceholder.typicode.com';

  int _usersPage = 0;
  bool _loanding = false;

  final List<User> _users = [];

  /// A stream controller that is used to send data to the stream.
  final _usersStreamController = StreamController<List<User>>.broadcast();

  Function(List<User>) get usersSink => _usersStreamController.sink.add;

  Stream<List<User>> get usersStream => _usersStreamController.stream;

  void disposeStreams() {
    _usersStreamController.close();
  }

  Future<List<User>> _procesarResp(Uri url) async {
    final resp = await http.get(url);
    final dataDecoded = json.decode(resp.body);
    final users = User.fromJsonList(dataDecoded[1]);
    return users;
  }

  Future<List<User>> getUser() async {
    if (_loanding) return [];
    _loanding = true;
    _usersPage++;
    final url = Uri.https(_url, '/users', {'page': _usersPage.toString()});

    final List<User> resp = await _procesarResp(url);
    _users.addAll(resp);
    usersSink(_users);
    _loanding = false;
    return resp;
  }
}
