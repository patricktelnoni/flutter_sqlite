import 'package:flutter/material.dart';
import 'models/user.dart';

class EditPage extends StatelessWidget{
  final User user;
  //final String kiriman;
  EditPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit data user : ' + user.name),
      ),
      body: Container(
        child:
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  12.0, 12.0, 12.0, 6.0),
              child: TextFormField(
                initialValue: user.name,
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.normal
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  12.0, 6.0, 12.0, 12.0),
              child: TextFormField(
                initialValue: user.country,
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.normal
                ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  12.0, 6.0, 12.0, 12.0),
              child: TextFormField(
                initialValue: user.age.toString(),
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.normal
                ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                },
                child: const Text('Submit'),
              ),
            ),
          ],

        ),
      ),
      //bottomNavigationBar:  BottomNavigationMenu(),
    );
  }
}