class Consulta{
  final int? id_consulta;
  final String data;
  final String descricao;
  final String hora;

  Consulta({this.id_consulta, required this.data, required this.descricao, required this.hora});

  factory Consulta.fromJson(Map<String, dynamic> json){
    return Consulta(
      id_consulta: json['id_consulta'],
      data: json['data'],
      descricao: json['descricao'],
      hora: json['hora'],
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'id_consulta': id_consulta,
      'data': data,
      'descricao': descricao,
      'hora': hora,
    };
  }
}