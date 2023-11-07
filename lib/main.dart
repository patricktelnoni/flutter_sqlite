import 'package:flutter/material.dart';
import 'package:sqlite/edit_form.dart';
import 'sqlite_service.dart';
import 'package:sqlite/models/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late DatabaseHandler handler;

  @override
  void initState() {
    super.initState();

    this.handler = DatabaseHandler();
    this.handler.initializeDB().whenComplete(() async {
      await this.addUsers();
      setState(() {});
    });
  }

  Future<int> addUsers() async {
    User firstUser  = User(name: "peter", age: 24, country: "Lebanon");
    User secondUser = User(name: "john", age: 31, country: "United Kingdom");
    User thirdUser = User(name: "mark", age: 28, country: "Canada");

    List<User> listOfUsers = [firstUser, secondUser, thirdUser];

    return await this.handler.insertUser(listOfUsers);
  }

  void editData(User userEdit) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            EditPage(user: userEdit))
    );
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future  : this.handler.retrieveUsers(),
        builder : (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(Icons.delete_forever),
                  ),
                  key: ValueKey<int>(snapshot.data![index].id!),
                  child: Column(
                    children: <Widget>[
                      Card(
                          child: ListTile(
                            contentPadding: EdgeInsets.all(8.0),
                            title: Text(snapshot.data![index].name),
                            subtitle: Text(snapshot.data![index].country),
                            onTap: () => editData(snapshot.data![index]),
                          )
                      ),
                    ],
                  ),
                  onDismissed: (DismissDirection direction) async{
                      await this.handler.deleteUser(snapshot.data![index].id);
                  },

                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
