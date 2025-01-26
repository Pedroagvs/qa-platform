class AplicationDto {
  int? id;
  final String title;
  final Plataforma plataforma;
  AplicationDto({
    this.id,
    required this.title,
    required this.plataforma,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'titulo': title,
      'plataforma': setPlataforma(plataforma),
    };
  }

  factory AplicationDto.fromJson(Map<String, dynamic> map) {
    return AplicationDto(
      id: map['id'] != null ? int.parse(map['id']) : null,
      title: map['titulo'] as String,
      plataforma: getPlataforma(map['plataforma'] as String),
    );
  }
}

Plataforma getPlataforma(String plataforma) {
  final map = <String, Plataforma>{
    'web': Plataforma.web,
    'mobile': Plataforma.mobile,
  };
  return map[plataforma] ?? Plataforma.mobile;
}

String setPlataforma(Plataforma plataforma) {
  final map = <Plataforma, String>{
    Plataforma.web: 'web',
    Plataforma.mobile: 'mobile',
  };
  return map[plataforma]!;
}

enum Plataforma {
  web,
  mobile,
}
