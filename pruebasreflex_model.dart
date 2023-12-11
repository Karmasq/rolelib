class PruebasReflex {
  int? id;
  double? profundidad;
  double? magField;
  double? temp;
  double? magDip;
  double? inclinacion;
  double? azimut;
  int? reporteId;

  PruebasReflex({
    this.id,
    this.profundidad,
    this.magField,
    this.temp,
    this.magDip,
    this.inclinacion,
    this.azimut,
    this.reporteId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'profundidad': profundidad,
      'magField': magField,
      'temp': temp,
      'magDip': magDip,
      'inclinacion': inclinacion,
      'azimut': azimut,
      'reporteId':reporteId,
    };
  }

  static PruebasReflex fromMap(Map<String, dynamic> map) {
    return PruebasReflex(
      id: map['id'],
      profundidad: map['profundidad'],
      magField: map['magField'],
      temp: map['temp'],
      magDip: map['magDip'],
      inclinacion: map['inclinacion'],
      azimut: map['azimut'],
      reporteId: map['reporteId'],
    );
  }
}
