class Lista {
  int? id;
  String? nome;
  int? lotes;

  Lista({this.id, this.nome, this.lotes});

  Lista.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    lotes = json['lotes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['nome'] = nome;
    data['lotes'] = lotes;
    return data;
  }
}