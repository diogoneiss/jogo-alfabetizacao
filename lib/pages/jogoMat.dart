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
  int numero2 = 0;
  String operacao = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jogo da tabuada"),
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
    numero2 = 0;
    operacao = "";
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
          if (operacao == "*" || operacao == '/')
            pontos = pontos + 10;
          else
            pontos = pontos + 5;
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

    switch (operacao) {
      case "+":
        resposta = numero1 + numero2;
        break;
      case "-":
        resposta = numero1 - numero2;
        break;
      case "*":
        resposta = numero1 * numero2;
        break;
      case "/":
        resposta = numero1 ~/ numero2;
        break;
      default:
    }

    return resposta;
  }

  void _novaEquacao() {
    int x = _novoNumero(4);
    // use isso apenas para testar uma operacao especifica sempre.
    //x = 0;

    switch (x) {
      case 0:
        operacao = "+";
        break;
      case 1:
        operacao = "-";
        break;
      case 2:
        operacao = "*";
        break;
      case 3:
        operacao = "/";
        break;
      default:
        operacao = "+";
    }

    //tenho que tomar cuidado para ter apenas divisoes inteiras no joguinho
    if(operacao == '/'){
      //resposta = numero 1 / numero 2
      numero2 = _novoNumero(10);

      int temp = _novoNumero(11);
      if(temp == 1 || temp == 2)
        temp = 3;

      if(numero2 == 0 ||numero2 == 1){
        numero2 = 2;
      }
      numero1 = numero2 * temp;

    }

    else if (operacao == "*") {
      numero1 = _novoNumero(10) + 1;
      numero2 = _novoNumero(10) + 1;
    }
    else {
      numero1 = _novoNumero(30) + 1;
      numero2 = _novoNumero(30) + 1;

      //swappar se um for menor que o outro, resultando em numeros negativos ( que nao queremos)
      if (numero1 < numero2 && operacao == "-") {
        int aux = numero1;
        numero1 = numero2;
        numero2 = aux;
      }
    }

    setState(() {
      _equacaoText = numero1.toString() +
          " " +
          operacao +
          " " +
          numero2.toString() +
          " = ?";
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
