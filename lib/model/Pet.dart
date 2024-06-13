class Pet{
  final int? id_pet;
  final String nome;
  final String tipo_pet;
  final String data_nascimento;
  final String documento;
  final String raca;
  final String cor;

  Pet({this.id_pet, required this.nome, required this.tipo_pet, required this.data_nascimento, required this.documento, required this.raca, required this.cor});

  factory Pet.fromJson(Map<String, dynamic> json){
    return Pet(
      id_pet: json['id_pet'],
      nome: json['nome'],
      tipo_pet: json['tipo_pet'],
      data_nascimento: json['data_nascimento'],
      documento: json['documento'],
      raca: json['raca'],
      cor: json['cor'],
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'id_prop': id_pet,
      'nome': nome,
      'tipo_pet': tipo_pet,
      'data_nascimento': data_nascimento,
      'documento': documento,
      'raca': raca,
      'cor': cor,
    };
  }
}