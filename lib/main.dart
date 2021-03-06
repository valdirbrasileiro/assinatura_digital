import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'assinatura.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 4,
    penColor: Colors.black,
    exportBackgroundColor: Colors.transparent,
  );
  // ignore: prefer_typing_uninitialized_variables
  var data;

  Future<void> _criarImagem(context) async {
    var result = await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (BuildContext context) => Assinatura(_controller)),
    );
    setState(() {
      data = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.black,
              title: const Text('Assinatura Digital')),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    _criarImagem(context);
                  },
                  child: Card(
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Colors.black87, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: data != null
                            ? Image.memory(data)
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const <Widget>[
                                      Text("Clique aqui para assinar"),
                                      Icon(Icons.create),
                                    ]),
                              ),
                      )),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                setState(() {
                  _controller.clear();
                  data = null;
                });
              },
              child: const Icon(Icons.delete_forever, size: 40,)),
        ),
      ),
    );
  }
}
