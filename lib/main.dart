import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _latController = new TextEditingController();
  TextEditingController _longController = new TextEditingController();

  String _country = 'unknown';
  String _postalCode = 'unknown';
  String _locality = 'unknown';
  String _street = 'unknown';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                    width: 100,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _latController,
                      decoration: InputDecoration(
                        helperText: 'Lat',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    )),
                SizedBox(
                    width: 100,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _longController,
                      decoration: InputDecoration(
                        helperText: 'Long',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    )),
              ],
            ),
            Text('Country: $_country'),
            Text('ZipCode: $_postalCode'),
            Text('Locality: $_locality'),
            Text('Street: $_street'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _placemarkFromCoordinates(
            double.parse(_latController.text),
            double.parse(_longController.text)),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> _placemarkFromCoordinates(double lat, double long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    setState(() {
      _country = placemarks[0].country!;
      _postalCode = placemarks[0].postalCode!;
      _locality = placemarks[0].locality!;
      _street = placemarks[0].thoroughfare!;
    });
  }
}
