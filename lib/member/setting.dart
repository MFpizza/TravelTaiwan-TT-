import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("設定"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("製作團隊"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Team();
              }));
            },
          ),
          ListTile(
            title: Text("資料來源"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return DataFrom();
              }));
            },
          ),
          ListTile(
            title: Text("登出"),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}

class DataFrom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Center(
          child: Text('資料來源'),
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('resources').get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> documents = snapshot.data.docs;
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, int index) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '來源網站:${snapshot.data.docs.elementAt(index).data()['name']}',
                          style: TextStyle(fontSize: 20),
                        ),
                        TextButton(
                            onPressed: () => launch(snapshot.data.docs
                                .elementAt(index)
                                .data()['url']),
                            child: Text(
                              snapshot.data.docs.elementAt(index).data()['url'],
                              style: TextStyle(fontSize: 18),
                            )),
                        Divider(),
                      ],
                    ),
                    padding: EdgeInsets.all(20),
                  );
                });
          }
          return Container(child: Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}

class Team extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Center(
          child: Text('製作團隊'),
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('teamMember').get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> documents = snapshot.data.docs;
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black87)),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'name: ${snapshot.data.docs.elementAt(index).data()['name']}',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          'phone: ${snapshot.data.docs.elementAt(index).data()['phone']}',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          'email: ${snapshot.data.docs.elementAt(index).data()['email']}',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(20),
                  );
                });
          }
          return Container(child: Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}
