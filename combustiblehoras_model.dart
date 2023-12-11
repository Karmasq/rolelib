class Combustible {
  int? id;
  String? tipoEquipo;
  double? cantidad;
  int? reporteId;

  Combustible({
    this.id,
    this.tipoEquipo,
    this.cantidad,
    this.reporteId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tipoEquipo': tipoEquipo,
      'cantidad': cantidad,
      'reporteId': reporteId,
    };
  }

  static Combustible fromMap(Map<String, dynamic> map) {
    return Combustible(
      id: map['id'],
      tipoEquipo: map['tipoEquipo'],
      cantidad: map['cantidad'],
      reporteId: map['reporteId'],
    );
  }
}

class Horas {
  int? id;
  String? tipoMaquinaria;
  int? cantidad;
  int? reporteId; 
 

  Horas({
    this.id,
    this.tipoMaquinaria,
    this.cantidad,
    this.reporteId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tipoMaquinaria': tipoMaquinaria,
      'cantidad': cantidad,
      'reporteId': reporteId, // Nueva propiedad
    };
  }

  static Horas fromMap(Map<String, dynamic> map) {
    return Horas(
      id: map['id'],
      tipoMaquinaria: map['tipoMaquinaria'],
      cantidad: map['cantidad'],
      reporteId: map['reporteId'], // Nueva propiedad
    );
  }
}

