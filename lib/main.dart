import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:localjson/Detalles.dart';
import 'package:splashscreen/splashscreen.dart';
void main() => runApp(new MaterialApp(
    home: new MyApp(),
    theme: ThemeData.dark(),
    debugShowCheckedModeBanner: false,
  ));

class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SplashScreen(
        title: Text("Bienvenido", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black87),),
        backgroundColor: Colors.white,
        photoSize: 150,
        seconds: 7,
        image: Image.network("https://gobiznext.com/wp-content/uploads/2019/04/hipertextual-maraton-previo-avengers-endgame-peliculas-marvel-que-ver-antes-su-estreno-2019543598-1-1200x500.jpg"),
        navigateAfterSeconds: HomePage());
  }
}
class HomePage extends StatefulWidget {
  @override
  homePageState createState() => new homePageState();
}
class homePageState extends State<HomePage> {
  Future<String> _loadAsset() async {
    return await rootBundle.loadString('assets/personajes.json');
  }
  Future<List<Superx>> _getHeroes() async {
    String jsonString = await _loadAsset();
    var jsonData = jsonDecode(jsonString);

    List<Superx> heroes = [];
    for (var i in jsonData) {
      Superx he = Superx(i["img"], i["superheroe"], i["identidad"],
          i["edad"], i["altura"], i["genero"], i["descripcion"]);
      heroes.add(he);
    }
    return heroes;
  }
// Busqueda
  String searchString = "";
  bool _isSearching = false;
  final searchController = TextEditingController();
  AudioPlayer audioPlayer;
  AudioCache audioCache;
  final audio = "audio.mp3";
  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    audioCache = AudioCache();
    var loop = 1;
    setState(() {
      audioCache.play(audio);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: _isSearching
            ? TextField(
          decoration: InputDecoration(
              hintText: "Buscar",
              icon: Icon(Icons.search)),
          onChanged: (value) {
            setState(() {
              searchString = value;
            });
          },
          controller: searchController,
        )
            : Text("Personajes"),
        actions: <Widget>[
          !_isSearching
              ? IconButton(icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                searchString = "";
                this._isSearching = !this._isSearching;
              });
            },
          )
              : IconButton(icon: Icon(Icons.cancel),
            onPressed: () {
              setState(() {
                this._isSearching = !this._isSearching;
              });
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          child: FutureBuilder(
            future: _getHeroes(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text(""),
                  ),
                );
              } else {
                return ListView.builder(scrollDirection: Axis.vertical, itemCount: snapshot.data.length, itemBuilder: (BuildContext context, int index){
                  print(" $snapshot.data[index].img.toStrng()");
                      return snapshot.data[index].superheroe.contains(searchString) ?
                      ListTile(
                        leading: CircleAvatar(minRadius: 30.0, maxRadius:  30.0, backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(snapshot.data[index].img.toString(),),),
                        title: new Text(snapshot.data[index].superheroe.toString(), style: TextStyle(fontSize: 20),),
                        subtitle: new Text(snapshot.data[index].identidad.toString(), style: TextStyle(fontSize: 18),),
                        onTap: (){
                          Navigator.push(context,
                              new MaterialPageRoute(builder: (context)=> VerDetalles(snapshot.data[index])));
                        },
                      )
                          :Container();
                    }
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class Superx {
  final String img;
  final String superheroe;
  final String identidad;
  final String edad;
  final String altura;
  final String genero;
  final String descripcion;
  Superx(this.img, this.superheroe, this.identidad, this.edad,
      this.altura, this.genero, this.descripcion);
}
