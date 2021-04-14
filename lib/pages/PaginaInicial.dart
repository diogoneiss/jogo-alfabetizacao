import 'package:flutter/material.dart';
import 'package:jogos_app/pages/JogoAdivinha.dart';
import 'package:jogos_app/pages/infoJogos.dart';
import 'package:jogos_app/pages/jogoMat.dart';

class PaginaInicial extends StatefulWidget {
  @override
  _PaginaInicialState createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  void _abrirSobreJogos() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => InfoJogos()));
  }

  void _abrirJogoDoAdivinha() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => JogoAdivinha()));
  }

  void _abrirJogoMat() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => JogoMat()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jogos"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text("Para acessar os jogos clique nas imagens"),
            Padding(
              padding: EdgeInsets.only(top: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: _abrirSobreJogos,
                    child: Image.asset("assets/images/sobre.png"),
                  ),
                  GestureDetector(
                    onTap: _abrirJogoDoAdivinha,
                    child: Image.asset("assets/images/adivinha.png"),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap:
                        _abrirJogoMat, //deve ser criada a função e página e alterado
                    child: Image.asset("assets/images/game.png"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
