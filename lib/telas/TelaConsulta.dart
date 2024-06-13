import 'package:flutter/material.dart';
import 'package:petgo/model/Consulta.dart';
import 'package:petgo/service/ConsultaService.dart';


class TelaConsultas extends StatefulWidget {
  @override
  _TelaConsultasState createState() => _TelaConsultasState();
}

class _TelaConsultasState extends State<TelaConsultas> {
  late Future<List<Consulta>> _consulta;
  final ConsultaService _consultaService = ConsultaService();

  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _horaController = TextEditingController();

  Consulta? _consultaAtual;

  @override
  void initState() {
    super.initState();
    _atualizarConsultas();
  }

  void _atualizarConsultas() {
    setState(() {
      _consulta = _consultaService.buscarConsulta();
    });
  }

  void _mostrarFormulario({Consulta? consulta}) {
    if (consulta != null) {
      _dataController.text = consulta.data;
      _descricaoController.text = consulta.descricao;
      _horaController.text = consulta.hora;


    } else {
      _consultaAtual = null;
      _dataController.clear();
      _descricaoController.clear();
      _horaController.clear();


    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 20,
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _dataController,
              decoration: InputDecoration(labelText: 'Data'),
            ),
            TextField(
              controller: _descricaoController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            TextField(
              controller: _horaController,
              decoration: InputDecoration(labelText: 'Hora'),
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submeter,
              child: Text(_consultaAtual == null ? 'Criar' : 'Atualizar'),
            ),
          ],
        ),
      ),
    );
  }

  void _submeter() async {
    final data = _dataController.text;
    final descricao = _descricaoController.text;
    final hora = _horaController.text;


    if (_consultaAtual == null) {
      final novoConsulta = Consulta(data: data, descricao: descricao, hora: hora,);
      await _consultaService.criarConsulta(novoConsulta);
    }
    else {
      final consultaAtualizado = Consulta(
        id_consulta: _consultaAtual!.id_consulta,
        data: data,
        descricao: descricao,
        hora: hora,
      );
      await _consultaService.atualizarConsulta(consultaAtualizado);
    }

    Navigator.of(context).pop();
    _atualizarConsultas();
  }

  void _deletarConsulta(int id) async {
    try {
      await _consultaService.deletarConsulta(id);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Consulta deletado com sucesso!')));
      _atualizarConsultas();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Falha ao deletar consulta: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CONSULTA'),
        centerTitle: true,
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _mostrarFormulario(),
          ),
        ],
      ),
      body: FutureBuilder<List<Consulta>>(
        future: _consulta,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final consulta = snapshot.data![index];
                return ListTile(
                  title: Text(consulta.data),
                  subtitle: Text('R\$${consulta.descricao}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _mostrarFormulario(consulta: consulta),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deletarConsulta(consulta.id_consulta!),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
