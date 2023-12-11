class Perforacion {
  int? id;
  String? perforacion;
  String? tamano;
  double? desde;
  double? hasta;
  double? totalPerforado;
  int? reporteId;

  Perforacion({
    this.id,
    this.perforacion,
    this.tamano,
    this.desde,
    this.hasta,
    this.totalPerforado,
    this.reporteId,
  });

   Map<String, dynamic> toMap() {
    return {
      'id': id,
      'perforacion': perforacion,
      'tamano': tamano,
      'desde': desde,
      'hasta': hasta,
      'totalPerforado': totalPerforado,
      'reporteId': reporteId, // Nueva propiedad
    };
  }

  static Perforacion fromMap(Map<String, dynamic> map) {
    return Perforacion(
      id: map['id'],
      perforacion: map['perforacion'],
      tamano: map['tamano'],
      desde: map['desde'],
      hasta: map['hasta'],
      totalPerforado: map['totalPerforado'],
      reporteId: map['reporteId'], // Nueva propiedad
    );
  }
}
