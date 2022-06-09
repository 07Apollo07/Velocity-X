import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          textAlign: TextAlign.justify,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        shadowColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: <Widget>[
          Card(
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'data:image/jpeg;base64,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'))),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR63KoribGVDB_dswx8iUX99udIebJK_EsaYYTwg2vJoIeIECXhO8iWnI5VBU64wLJ-8gg&usqp=CAU')),
                    Text(
                      'Nouveautés',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 40),
                    ),
                  ],
                ),
              ),
            ),
            margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
          )
        ],
      ),
    );
  }
}
