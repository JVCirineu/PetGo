class Veterinario{
  final int? id_veterinario;
  final String nome;
  final String cpf;
  final String rg;
  final String rua;
  final String cep;
  final String bairro;
  final String cidade;
  final String estado;
  final String telefone;
  final String crmv;

  Veterinario({this.id_veterinario, required this.nome, required this.cpf, required this.rg, required this.rua, required this.cep, required this.bairro, required this.cidade, required this.estado, required this.telefone, required this.crmv});

  factory Veterinario.fromJson(Map<String, dynamic> json){
    return Veterinario(
      id_veterinario: json['id_veterinario'],
      nome: json['nome'],
      cpf: json['cpf'],
      rg: json['rg'],
      rua: json['rua'],
      cep: json['cep'],
      bairro: json['bairro'],
      cidade: json['cidade'],
      estado: json['estado'],
      telefone: json['telefone'],
      crmv: json['crmv'],
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'id_veterinario': id_veterinario,
      'nome': nome,
      'cpf': cpf,
      'rg': rg,
      'rua': rua,
      'cep': cep,
      'bairro': bairro,
      'cidade': cidade,
      'estado': estado,
      'telefone': telefone,
      'crmv': crmv,
    };
  }
}