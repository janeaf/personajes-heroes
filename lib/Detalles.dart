import 'package:flutter/material.dart';
import 'main.dart';

class VerDetalles extends StatelessWidget{
  final Superx heroe;
  VerDetalles(this.heroe);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          title: Text(heroe.superheroe.toString(),),
          centerTitle: true, backgroundColor: Colors.purple[500],),
        body: Stack(
          children: <Widget>[
            Positioned(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width - 20,
              left: 10.0, top: MediaQuery.of(context).size.height * 0.10,
              child: Container(
                child: SingleChildScrollView(
                  child: Card(
                    color: Colors.transparent, shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(height: 30.0,),
                        Container(height: 250.0, width: 250.0, decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(heroe.img.toString()))),),
                        new Padding(padding: EdgeInsets.all(15.0),),
                        Text(heroe.superheroe.toString(), style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
                        Text("Identidad: ${heroe.identidad}", style: TextStyle(fontSize: 20.0, color: Colors.blue[200]),),
                        new Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text("Edad: ${heroe.edad}", style: TextStyle(color: Colors.purpleAccent, fontSize: 18.0, fontWeight: FontWeight.bold),),
                            Text("Altura: ${heroe.altura}", style: TextStyle(color: Colors.blue[200], fontSize: 18.0, fontWeight: FontWeight.bold),),
                            Text("Género: ${heroe.genero}", style: TextStyle(color: Colors.purpleAccent, fontSize: 18.0, fontWeight: FontWeight.bold),)],),
                            Text("Descripción: ${heroe.descripcion}", textAlign: TextAlign.justify, style: TextStyle(color: Colors.blue[200], fontSize: 20.0),),
                        new Padding(padding: EdgeInsets.all(15.0),),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}