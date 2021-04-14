import 'dart:math';
import 'package:flutter/material.dart';

class JogoAdivinha extends StatefulWidget {
  @override
  _JogoAdivinhaState createState() => _JogoAdivinhaState();
}

class _JogoAdivinhaState extends State<JogoAdivinha> {
  // VARIAVEIS
  final _tLetra = TextEditingController();
  var _infoText = "Tente adivinhar a letra gerada aleatoriamente!";
  var _formKey = GlobalKey<FormState>();
  Random random = new Random();
  //char code utf-16
  int letra;
  int tentativas = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adivinhe a letra"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields)
        ],
      ),
      body: _body(),
    );
  }

  // PROCEDIMENTO PARA LIMPAR OS CAMPOS
  void _resetFields() {
    _tLetra.text = "";
    letra = _novaLetra();
    tentativas = 0;
    setState(() {
      _infoText = "Tente adivinhar a letra gerada aleatoriamente!";
      _formKey = GlobalKey<FormState>();
    });
  }

  _body() {
    return SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _editText("Letra: ", _tLetra),
              _buttonCalcular(),
              _textInfo(),
            ],
          ),
        ));
  }

  // Widget text
  _editText(String field, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: (s) => _validate(s, field),
      keyboardType: TextInputType.name,
      style: TextStyle(
        fontSize: 22,
        color: Colors.greenAccent[500],
      ),
      decoration: InputDecoration(
        labelText: field,
        labelStyle: TextStyle(
          fontSize: 22,
          color: Colors.grey,
        ),
      ),
    );
  }

  // PROCEDIMENTO PARA VALIDAR OS CAMPOS
  String _validate(String text, String field) {
    if (text.isEmpty) {
      return "Digite $field";
    }
    else if(text.length > 1)
      return "Tamanho excedido! $field";
    return null;
  }

  // Widget button
  _buttonCalcular() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 20),
      height: 45,
      child: RaisedButton(
        color: Colors.green[500],
        child: Text(
          "Conferir",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _confere();
          }
        },
      ),
    );
  }

  void _confere() {
    if (letra == null) letra = _novaLetra();
    String letraDigitada = _tLetra.text.toUpperCase();


    print("Letra no código: [" +String.fromCharCode(letra)+ "] letra digitada: ["+letraDigitada+"]");
    print("Letra no código: [" +letra.toString()+ "] letra digitada: ["+letraDigitada.codeUnitAt(0).toString()+"]");


    setState(() {
      if (letraDigitada.codeUnitAt(0) == letra) {
        _infoText = "Acertou em " +
            tentativas.toString() +
            " tentativas!\nUma nova letra secreta foi gerada!";
        letra = _novaLetra();
        tentativas = 0;
      } else {
        tentativas++;

        //trabalhar com strings
        if (letraDigitada.codeUnitAt(0) < "A".codeUnitAt(0) ||letraDigitada.codeUnitAt(0) > "Z".codeUnitAt(0) ) {
          _infoText = "A letra secreta está entre a e z, maiúsculos!!";
        } else if (letraDigitada.codeUnitAt(0) > letra ) {
          _infoText = "Quase! a letra vem antes de " + letraDigitada + "..";
        } else {
          _infoText = "Quase! a letra vem depois de " + letraDigitada + "..";
        }
      }
    });
  }

  int _novaLetra() {

    int num = random.nextInt(26);
    int novoNum = ("A".codeUnitAt(0) + num);
    print("Nova letra aleatoria: "+String.fromCharCode(novoNum));


    return novoNum ;
  }

  // // Widget text
  _textInfo() {
    return Text(
      _infoText,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.green[500], fontSize: 25.0),
    );
  }
}
