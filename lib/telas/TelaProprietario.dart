import 'package:flutter/material.dart';
import 'package:petgo/model/Proprietario.dart';
import 'package:petgo/service/ProprietarioService.dart';


class TelaProprietarios extends StatefulWidget {
  @override
  _TelaProprietariosState createState() => _TelaProprietariosState();
}

class _TelaProprietariosState extends State<TelaProprietarios> {
  late Future<List<Proprietario>> _proprietario;
  final ProprietarioService _proprietarioService = ProprietarioService();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _rgController = TextEditingController();
  final TextEditingController _ruaController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();

  Proprietario? _proprietarioAtual;

  @override
  void initState() {
    super.initState();
    _atualizarProprietarios();
  }

  void _atualizarProprietarios() {
    setState(() {
      _proprietario = _proprietarioService.buscarProprietario();
    });
  }

  void _mostrarFormulario({Proprietario? proprietario}) {
    if (proprietario != null) {
      _proprietarioAtual = proprietario;
      _nomeController.text = proprietario.nome;
      _cpfController.text = proprietario.cpf;
      _rgController.text = proprietario.rg;
      _ruaController.text = proprietario.rua;
      _cepController.text = proprietario.cep;
      _bairroController.text = proprietario.bairro;
      _cidadeController.text = proprietario.cidade;
      _estadoController.text = proprietario.estado;
      _telefoneController.text = proprietario.telefone;



    } else {
      _proprietarioAtual = null;
      _nomeController.clear();
      _cpfController.clear();
      _rgController.clear();
      _ruaController.clear();
      _cepController.clear();
      _bairroController.clear();
      _cidadeController.clear();
      _estadoController.clear();
      _telefoneController.clear();

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
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _cpfController,
              decoration: InputDecoration(labelText: 'CPF'),
            ),
            TextField(
              controller: _rgController,
              decoration: InputDecoration(labelText: 'RG'),
            ),
            TextField(
              controller: _ruaController,
              decoration: InputDecoration(labelText: 'rua'),
            ),
            TextField(
              controller: _cepController,
              decoration: InputDecoration(labelText: 'cep'),
            ),
            TextField(
              controller: _bairroController,
              decoration: InputDecoration(labelText: 'bairro'),
            ),
            TextField(
              controller: _cidadeController,
              decoration: InputDecoration(labelText: 'cidade'),
            ),
            TextField(
              controller: _estadoController,
              decoration: InputDecoration(labelText: 'estado'),
            ),
            TextField(
              controller: _telefoneController,
              decoration: InputDecoration(labelText: 'telefone'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submeter,
              child: Text(_proprietarioAtual == null ? 'Criar' : 'Atualizar'),
            ),
          ],
        ),
      ),
    );
  }

  void _submeter() async {
    final nome = _nomeController.text;
    final cpf = _cpfController.text;
    final rg = _rgController.text;
    final rua = _ruaController.text;
    final cep = _cepController.text;
    final bairro = _bairroController.text;
    final cidade = _cidadeController.text;
    final estado = _estadoController.text;
    final telefone = _telefoneController.text;

    if (_proprietarioAtual == null) {
      final novoProprietario = Proprietario(nome: nome, cpf: cpf, rg: rg, rua: rua, cep: cep, bairro: bairro, cidade: cidade, estado: estado, telefone: telefone,);
      await _proprietarioService.criarProprietario(novoProprietario);
    }
    else {
      final proprietarioAtualizado = Proprietario(
        id_prop: _proprietarioAtual!.id_prop,
        nome: nome,
        cpf: cpf,
        rg: rg,
        rua: rua,
        cep: cep,
        bairro: bairro,
        cidade: cidade,
        estado: estado,
        telefone: telefone,
      );
      await _proprietarioService.atualizarProprietario(proprietarioAtualizado);
    }

    Navigator.of(context).pop();
    _atualizarProprietarios();
  }

  void _deletarProprietario(int id_prop) async {
    try {
      await _proprietarioService.deletarProprietario(id_prop);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Proprietario deletado com sucesso!')));
      _atualizarProprietarios();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Falha ao deletar proprietario: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PROPRIETÁRIO'),
        centerTitle: true,
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _mostrarFormulario(),
          ),
        ],
      ),
      body: FutureBuilder<List<Proprietario>>(
        future: _proprietario,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final proprietario = snapshot.data![index];
                return ListTile(
                  title: Text(proprietario.nome),
                  subtitle: Text('R\$${proprietario.cpf}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _mostrarFormulario(proprietario: proprietario),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deletarProprietario(proprietario.id_prop!),
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
