import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:typicodept/providers/users_provider.dart';
import 'package:http/http.dart' as http;

import '../../model/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final userProvider = UserProvider();

  List<User> data = <User>[];

  Future<List<User>> datos() async {
    Uri url = 'jsonplaceholder.typicode.com/users' as Uri;
    var resp = await http.post(url).timeout(const Duration(seconds: 10));

    var datos = jsonDecode(resp.body);

    var users = <User>[];
    for (datos in datos) {
      users.add(User.fromJson(datos));
    }

    return users;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    datos().then((value) {
      setState(() {
        data.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    userProvider.getUser();
    return Scaffold(
      appBar: AppBar(
        title: const Text('TypiCode Users'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          child: ListTile(
                            title: Text(data[index].company.name),
                          ),
                        );
                      }))
            ]
            // StreamBuilder(
            //     stream: userProvider.usersStream,
            //     builder: (BuildContext context, AsyncSnapshot snapshot) {
            //       if (snapshot.hasData) {
            //         return Container(
            //           color: Colors.amberAccent,
            //         );
            //         // return MovieHorizontal(
            //         //   movies: snapshot.data,
            //         //   nextPage: userProvider.getUser(),
            //         // );
            //       } else {
            //         return const Center(child: CircularProgressIndicator());
            //       }
            //     })

            ),
        //child: ListView.builder(itemBuilder: itemBuilder),
      )),
    );
  }
}
