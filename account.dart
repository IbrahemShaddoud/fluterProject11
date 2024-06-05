//import 'package:app/compount/changeaccount.dart';
import 'package:flutter/material.dart';
import 'package:mastershop/compount/supplyRequest.dart';
import 'package:mastershop/pages/changeaccount.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AccountPage extends StatelessWidget {
  final email;
  AccountPage({this.email});

  Future getEmailEnfo() async {
    var url = Uri.parse('http://10.0.2.2/mastershop/email_enfo.php');
    var data = {"email": email.toString()};
    var response = await http.post(url, body: data);
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getEmailEnfo(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                body: Container(
              height: double.infinity,
              color: Color.fromARGB(255, 210, 217, 223),
              child: Container(
                height: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Positioned(
                      child: Transform.translate(
                        offset:
                            Offset(0, -MediaQuery.of(context).size.width / 2),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color.fromARGB(255, 114, 145, 236),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: Transform.translate(
                        offset: Offset(
                            0, -MediaQuery.of(context).size.width / 2 - 50),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color.fromARGB(255, 48, 97, 244),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      child: SingleChildScrollView(
                          child: Center(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.width / 2 -
                                      110),
                              child: CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 222, 226, 237),
                                maxRadius: 50,
                                minRadius: 50,
                                child: Icon(
                                  Icons.person,
                                  size: 60,
                                  color: Color.fromARGB(255, 48, 97, 244),
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            Text(
                              "${snapshot.data[0]['firstname'].toString()} ${snapshot.data[0]['lastname'].toString()}",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 90),
                            Container(
                                color: Color.fromARGB(92, 255, 255, 255),
                                height: 250,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.all(10),
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        leading: Icon(Icons.face,
                                            color: Color.fromARGB(
                                                255, 48, 97, 244)),
                                        title: Text("Name"),
                                        subtitle: Text(
                                          "${snapshot.data[0]['firstname'].toString()} ${snapshot.data[0]['lastname'].toString()}",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      Divider(
                                          color:
                                              Color.fromARGB(255, 48, 97, 244)),
                                      ListTile(
                                        leading: Icon(Icons.email,
                                            color: Color.fromARGB(
                                                255, 48, 97, 244)),
                                        title: Text("E-Mail"),
                                        subtitle: Text(
                                          snapshot.data[0]['email'].toString(),
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      Divider(
                                          color:
                                              Color.fromARGB(255, 48, 97, 244)),
                                      ListTile(
                                        leading: Icon(Icons.phone,
                                            color: Color.fromARGB(
                                                255, 48, 97, 244)),
                                        title: Text("Phone Number"),
                                        subtitle: Text(
                                          snapshot.data[0]['mobile'].toString(),
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            SizedBox(height: 50),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChangeAccount(
                                        email: snapshot.data[0]['email']
                                            .toString(),
                                        password: snapshot.data[0]['password']
                                            .toString(),
                                      ),
                                    ));
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Text(
                                  "Change Account Information",
                                  style: TextStyle(color: Colors.white),
                                ),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 48, 97, 244),
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                            SizedBox(height: 20),
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return SuppRequest();
                                    });
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Text(
                                  "Want to be a supplier ?",
                                  style: TextStyle(color: Colors.white),
                                ),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 48, 97, 244),
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            )
                          ],
                        ),
                      )),
                    ),
                  ],
                ),
              ),
            ));
          } else {
            return Container(
                color: Color.fromARGB(255, 230, 203, 203),
                child: Center(child: CircularProgressIndicator()));
          }
        });
  }
}
