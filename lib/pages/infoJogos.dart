import 'package:flutter/material.dart';

class InfoJogos extends StatefulWidget {
  @override
  _InfoJogosState createState() => _InfoJogosState();
}

class _InfoJogosState extends State<InfoJogos> {
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Informações dos jogos"),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  _body() {
    return SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _textInfo(),
              _textInfo2(),
            ],
          ),
        ));
  }

  _textInfo() {
    return Text(
      "Jogo do Adivinha:\n" +
          "-Tente adivinhar o número secreto com menor número de tentativas possiveis.\n" +
          "-Você tera a dica de que o número é menor ou maior do que o seu chute.\n",
      textAlign: TextAlign.left,
      style: TextStyle(color: Colors.black, fontSize: 19),
    );
  }

  _textInfo2() {
    return Text(
      "\nJogo da Matematica:\n" +
          "-Tente fazer a maior pontuação, com o menor número de erros possiveis.\n" +
          "-Soma e subtração: 5 pontos.\n" "-Multiplicação: 10 pontos.",
      textAlign: TextAlign.left,
      style: TextStyle(color: Colors.black, fontSize: 19),
    );
  }
}
