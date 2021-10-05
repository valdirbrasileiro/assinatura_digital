import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class Assinatura extends StatefulWidget {
 final SignatureController _controller;

  // ignore: use_key_in_widget_constructors
  const Assinatura(this._controller);

  @override
  _AssinaturaState createState() => _AssinaturaState();

}

class _AssinaturaState extends State<Assinatura> {
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Campo de assinatura'),
      ),
      body:
       SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.black)),
              child: Signature(
                controller: widget._controller,
                height: 600,
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
          RoundedLoadingButton(
        color: Colors.green,
        child: const Text('Concluir', style: TextStyle(color: Colors.white)),
        controller: _btnController,
        onPressed: () async {
          var data = await widget._controller.toPngBytes();

                Navigator.pop(context, data);
        })
        ],
      ),
    )
    );
  }
}