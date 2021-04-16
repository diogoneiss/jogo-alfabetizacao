import 'dart:math';
import 'package:flutter/material.dart';

class JogoMat extends StatefulWidget {
  @override
  _JogoMatState createState() => _JogoMatState();
}

class _JogoMatState extends State<JogoMat> {
  // VARIAVEIS
  final _tNumero = TextEditingController();
  var _equacaoText = "Aperte enviar para começar!";
  var _formKey = GlobalKey<FormState>();
  Random random = new Random();
  int pontos = 0;
  int acertos = 0;
  int erros = 0;
  int numero1 = 0;

  String operacao = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jogo da sequência"),
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
    _tNumero.text = "";
    pontos = 0;
    acertos = 0;
    erros = 0;
    numero1 = 0;

    setState(() {
      _equacaoText = "Aperte enviar para começar!";
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
              _textEquacao(),
              _editText("Resposta:", _tNumero),
              _buttonCalcular(),
              _textPontos(),
              _textAcertos(),
              _textErros(),
            ],
          ),
        ));
  }

  // Widget text
  _editText(String field, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: (s) => _validate(s, field),
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontSize: 22,
        color: Colors.green[500],
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
          "Enviar",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        onPressed: () {
          _confere();
        },
      ),
    );
  }

  void _confere() {
    setState(() {
      if (_equacaoText == "Aperte enviar para começar!")
        _novaEquacao();
      else {
        int resposta = _getResposta();

        if (resposta == int.parse(_tNumero.text)) {
          acertos++;
          pontos++;
        } else
          erros++;
        print(pontos);
        _novaEquacao();
        _tNumero.text = "";
      }
    });
  }

  int _novoNumero(int x) {
    return random.nextInt(x);
  }

  int _getResposta() {
    int resposta;

    resposta = numero1 + 1;

    return resposta;
  }

  void _novaEquacao() {
    int x = _novoNumero(10);
    // use isso apenas para testar uma operacao especifica sempre.
    //x = 0;


    setState(() {
      numero1 = x;
      _equacaoText = "Seguinte ao " + x.toString() + " ?";
    });
  }

  // // Widget text

  _textEquacao() {
    return Text(
      _equacaoText,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.greenAccent[300], fontSize: 25.0),
    );
  }

  _textPontos() {
    return Text(
      "Pontos:\n " + pontos.toString() + "\n",
      textAlign: TextAlign.left,
      style: TextStyle(color: Colors.black, fontSize: 19),
    );
  }

  _textAcertos() {
    return Text(
      "Acertos:\n " + acertos.toString() + "\n",
      textAlign: TextAlign.left,
      style: TextStyle(color: Colors.black, fontSize: 19),
    );
  }

  _textErros() {
    return Text(
      "Erros:\n " + erros.toString() + "\n",
      textAlign: TextAlign.left,
      style: TextStyle(color: Colors.black, fontSize: 19),
    );
  }
}
