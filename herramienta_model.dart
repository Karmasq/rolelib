class Herramienta {
  int? id;
  String? herramienta;
  String? numeroSerie;
  String? serie;
  double? desde;
  double? hasta;
  double? total;
  int? reporteId;

  Herramienta({
    this.id,
    this.herramienta,
    this.numeroSerie,
    this.serie,
    this.desde,
    this.hasta,
    this.total,
    this.reporteId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'herramienta': herramienta,
      'numeroSerie': numeroSerie,
      'serie': serie,
      'desde': desde,
      'hasta': hasta,
      'total': total,
      'reporteId': reporteId, // Nueva propiedad
    };
  }

  static Herramienta fromMap(Map<String, dynamic> map) {
    return Herramienta(
      id: map['id'],
      herramienta: map['herramienta'],
      numeroSerie: map['numeroSerie'],
      serie: map['serie'],
      desde: map['desde'],
      hasta: map['hasta'],
      total: map['total'],
      reporteId: map['reporteId'], // Nueva propiedad
    );
  }
}