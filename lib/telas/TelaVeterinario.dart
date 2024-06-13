import 'package:flutter/material.dart';
import 'package:petgo/model/Veterinario.dart';
import 'package:petgo/service/VeterinarioService.dart';


class TelaVeterinario extends StatefulWidget {
  @override
  _TelaVeterinarioState createState() => _TelaVeterinarioState();
}

class _TelaVeterinarioState extends State<TelaVeterinario> {
  late Future<List<Veterinario>> _veterinario;
  final VeterinarioService _veterinarioService = VeterinarioService();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _rgController = TextEditingController();
  final TextEditingController _ruaController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _crmvController = TextEditingController();

  Veterinario? _veterinarioAtual;

  @override
  void initState() {
    super.initState();
    _atualizarVeterinario();
  }

  void _atualizarVeterinario() {
    setState(() {
      _veterinario = _veterinarioService.buscarVeterinario();
    });
  }

  void _mostrarFormulario({Veterinario? veterinario}) {
    if (veterinario != null) {
      _veterinarioAtual = veterinario;
      _nomeController.text = veterinario.nome;
      _cpfController.text = veterinario.cpf;
      _rgController.text = veterinario.rg;
      _ruaController.text = veterinario.rua;
      _cepController.text = veterinario.cep;
      _bairroController.text = veterinario.bairro;
      _cidadeController.text = veterinario.cidade;
      _estadoController.text = veterinario.estado;
      _telefoneController.text = veterinario.telefone;
      _crmvController.text = veterinario.crmv;



    } else {
      _veterinarioAtual = null;
      _nomeController.clear();
      _cpfController.clear();
      _rgController.clear();
      _ruaController.clear();
      _cepController.clear();
      _bairroController.clear();
      _cidadeController.clear();
      _estadoController.clear();
      _telefoneController.clear();
      _crmvController.clear();

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
            TextField(
              controller: _crmvController,
              decoration: InputDecoration(labelText: 'crmv'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submeter,
              child: Text(_veterinarioAtual == null ? 'Criar' : 'Atualizar'),
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
    final crmv = _crmvController.text;

    if (_veterinarioAtual == null) {
      final novoVeterinario = Veterinario(nome: nome, cpf: cpf, rg: rg, rua: rua, cep: cep, bairro: bairro, cidade: cidade, estado: estado, telefone: telefone, crmv: crmv,);
      await _veterinarioService.criarVeterinario(novoVeterinario);
    }
    else {
      final veterinarioAtualizado = Veterinario(
        id_veterinario: _veterinarioAtual!.id_veterinario,
        nome: nome,
        cpf: cpf,
        rg: rg,
        rua: rua,
        cep: cep,
        bairro: bairro,
        cidade: cidade,
        estado: estado,
        telefone: telefone,
        crmv: crmv,
      );
      await _veterinarioService.atualizarVeterinario(veterinarioAtualizado);
    }

    Navigator.of(context).pop();
    _atualizarVeterinario();
  }

  void _deletarVeterinario(int id) async {
    try {
      await _veterinarioService.deletarVeterinario(id);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Veterinario deletado com sucesso!')));
      _atualizarVeterinario();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Falha ao deletar veterinario: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VETERINARIO'),
        centerTitle: true,
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _mostrarFormulario(),
          ),
        ],
      ),
      body: FutureBuilder<List<Veterinario>>(
        future: _veterinario,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final veterinario = snapshot.data![index];
                return ListTile(
                  title: Text(veterinario.nome),
                  subtitle: Text('R\$${veterinario.cpf}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _mostrarFormulario(veterinario: veterinario),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deletarVeterinario(veterinario.id_veterinario!),
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
