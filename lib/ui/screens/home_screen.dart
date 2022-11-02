import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../model/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<UserModel> data = <UserModel>[];

  Future<List<UserModel>> datos() async {
    var _url = 'jsonplaceholder.typicode.com';
    Uri url = Uri.https(_url, '/users');
    var resp = await http.get(url).timeout(const Duration(seconds: 10));
    var datos = jsonDecode(resp.body);
    var users = <UserModel>[];
    for (datos in datos) {
      users.add(UserModel.fromJson(datos));
    }

    return users;
  }

  @override
  void initState() {
    super.initState();
    datos().then((value) {
      setState(() {
        data.addAll(value);
      });
    });
  }

  final _pageController = PageController(
    initialPage: 0,
    viewportFraction: 0.25,
  );

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 25) {
        datos();
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('TypiCode Users'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Container(
              padding: const EdgeInsets.only(top: 5, left: 12, right: 12),
              width: double.infinity,
              child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 130,
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.blueAccent, width: 1))),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Text(data[index].company.name,
                              style: const TextStyle(
                                  color: Colors.greenAccent,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            leading: Image.asset(
                              'assets/Logo Didier NB.png',
                            ),
                            title: Text(
                              data[index].name,
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            trailing: Text(data[index].address.city,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400)),
                            subtitle: Text(
                              data[index].email,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w300),
                            ),
                          )
                        ],
                      ),
                    );
                  }))),
    );
  }
}
