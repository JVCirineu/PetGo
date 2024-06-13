class Proprietario{
  final int? id_prop;
  final String nome;
  final String cpf;
  final String rg;
  final String rua;
  final String cep;
  final String bairro;
  final String cidade;
  final String estado;
  final String telefone;

  Proprietario({this.id_prop, required this.nome, required this.cpf, required this.rg, required this.rua, required this.cep, required this.bairro, required this.cidade, required this.estado, required this.telefone});

  factory Proprietario.fromJson(Map<String, dynamic> json){
    return Proprietario(
      id_prop: json['id_prop'],
      nome: json['nome'],
      cpf: json['cpf'],
      rg: json['rg'],
      rua: json['rua'],
      cep: json['cep'],
      bairro: json['bairro'],
      cidade: json['cidade'],
      estado: json['estado'],
      telefone: json['telefone'],
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'id_prop': id_prop,
      'nome': nome,
      'cpf': cpf,
      'rg': rg,
      'rua': rua,
      'cep': cep,
      'bairro': bairro,
      'cidade': cidade,
      'estado': estado,
      'telefone': telefone,
    };
  }
}