class Reporte {
  int? id;
  String fecha;
  String pozo;
  String maquina;
  String turno;
  String perforista;
  String ayudante1;
  String ayudante2;
  String supervisor;
  String supervisorSeguridad;
  String proyecto;

  Reporte({
    this.id,
    required this.fecha,
    required this.pozo,
    required this.maquina,
    required this.turno,
    required this.perforista,
    required this.ayudante1,
    required this.ayudante2,
    required this.supervisor,
    required this.supervisorSeguridad,
    required this.proyecto,
   
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fecha': fecha,
      'pozo': pozo,
      'maquina': maquina,
      'turno': turno,
      'perforista': perforista,
      'ayudante1': ayudante1,
      'ayudante2': ayudante2,
      'supervisor': supervisor,
      'supervisorSeguridad': supervisorSeguridad,
      'proyecto': proyecto,
    };
  }

  factory Reporte.fromMap(Map<String, dynamic> map) {
    return Reporte(
      id: map['id'],
      fecha: map['fecha'],
      pozo: map['pozo'],
      maquina: map['maquina'],
      turno: map['turno'],
      perforista: map['perforista'],
      ayudante1: map['ayudante1'],
      ayudante2: map['ayudante2'],
      supervisor: map['supervisor'],
      supervisorSeguridad: map['supervisorSeguridad'],
      proyecto: map['proyecto'],
    );
  }
}
