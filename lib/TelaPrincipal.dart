import 'package:flutter/material.dart';
import 'package:petgo/telas/TelaConsulta.dart';
import 'package:petgo/telas/TelaEspecialidade.dart';
import 'package:petgo/telas/TelaPet.dart';
import 'package:petgo/telas/TelaProprietario.dart';
import 'package:petgo/telas/TelaVeterinario.dart';

class TelaPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('PET GO'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
              child: Text(
                'Menu Principal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Proprietário'),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TelaProprietarios()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Pet'),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TelaPet()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Veterinário'),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TelaVeterinario()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Consultas'),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TelaConsultas()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Especialidades'),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TelaEspecialidade()),
                );
              },
            )
          ],
        ),
      ),
      body: Center(
        child: Text('Bem-Vindo à Tela Principal',
          style: TextStyle(color: Colors.purpleAccent, fontSize: 20),
        ),
      ),
    );
  }
}
