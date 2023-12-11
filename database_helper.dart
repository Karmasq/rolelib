import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:roledrilling_app/models/reporte_model.dart';
import 'package:roledrilling_app/models/perforacion_model.dart';
import 'package:roledrilling_app/models/herramienta_model.dart'; // Asegúrate de importar el modelo de herramienta
import 'package:roledrilling_app/models/combustiblehoras_model.dart';
import 'package:roledrilling_app/models/pruebasreflex_model.dart';
import '../models/operaciones_model.dart';


class DatabaseHelper {
  static const _databaseName = "ReporteDrillingApp.db";
  static const _databaseVersion = 5; // Cambiar la versión de la base de datos

  static const table = 'reportes_table';
  static const columnId = 'id'; // Cambiar el nombre de la columna de la clave primaria
  static const columnProyecto = 'proyecto';
  static const columnFecha = 'fecha';
  static const columnPozo = 'pozo';
  static const columnMaquina = 'maquina';
  static const columnTurno = 'turno';
  static const columnPerforista = 'perforista';
  static const columnAyudante1 = 'ayudante1';
  static const columnAyudante2 = 'ayudante2';
  static const columnSupervisor = 'supervisor';
  static const columnSupervisorSeguridad = 'supervisorSeguridad';
  

final String tablePerforacion = 'perforaciones';
final String columnPerforacionId = 'id';
final String columnPerforacionPerforacion = 'perforacion';
final String columnPerforacionTamano = 'tamano';
final String columnPerforacionDesde = 'desde';
final String columnPerforacionHasta = 'hasta';
final String columnPerforacionTotalPerforado = 'totalPerforado';
final String columnPerforacionReporteId = 'reporteId'; // Nueva columna

// Añadir la tabla y columnas para herramientas
final String tableHerramienta = 'herramientas';
final String columnHerramientaId = 'id';
final String columnHerramientaHerramienta = 'herramienta';
final String columnHerramientaNumeroSerie = 'numeroSerie';
final String columnHerramientaSerie = 'serie';
final String columnHerramientaDesde = 'desde';
final String columnHerramientaHasta = 'hasta';
final String columnHerramientaTotal = 'total';
final String columnHerramientaReporteId = 'reporteId'; // Nueva columna

  // Añadir la tabla de Combustible
  final String tableCombustible = 'combustible';
  final String columnCombustibleId = 'id';
  final String columnCombustibleTipoEquipo = 'tipoEquipo';
  final String columnCombustibleCantidad = 'cantidad';
  final String columnCombustibleReporteId = 'reporteId';
  // Añadir la tabla de Horas
  final String tableHoras = 'horas';
  final String columnHorasId = 'id';
  final String columnHorasTipoMaquinaria = 'tipoMaquinaria';
  final String columnHorasCantidad = 'cantidad';
  final String columnHorasReporteId = 'reporteId';
  //Añadir la tabla de Reflex
  final String tablePruebasReflex = 'pruebas_reflex';
  final String columnPruebasReflexId = 'id';
  final String columnPruebasReflexProfundidad = 'profundidad';
  final String columnPruebasReflexMagField = 'magField';
  final String columnPruebasReflexTemp = 'temp';
  final String columnPruebasReflexMagDip = 'magDip';
  final String columnPruebasReflexInclinacion = 'inclinacion';
  final String columnPruebasReflexAzimut = 'azimut';
  final String columnPruebasReflexReporteId = 'reporteId';

    final String tableOperaciones1 = 'operaciones1';
  final String columnOperaciones1Id = 'id';
  final String columnOperaciones1Operacion = 'operacion';
  final String columnOperaciones1Horas = 'horas';
  final String columnOperaciones1ReporteId = 'reporteId';

  final String tableOperaciones2 = 'operaciones2';
  final String columnOperaciones2Id = 'id';
  final String columnOperaciones2Operacion = 'operacion';
  final String columnOperaciones2Horas = 'horas';
  final String columnOperaciones2ReporteId = 'reporteId';

  final String tableOperaciones3 = 'operaciones3';
  final String columnOperaciones3Id = 'id';
  final String columnOperaciones3Operacion = 'operacion';
  final String columnOperaciones3Horas = 'horas';
  final String columnOperaciones3ReporteId = 'reporteId';
 
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

 Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnProyecto TEXT NOT NULL,
        $columnFecha TEXT NOT NULL,
        $columnPozo TEXT NOT NULL,
        $columnMaquina TEXT NOT NULL,
        $columnTurno TEXT NOT NULL,
        $columnPerforista TEXT NOT NULL,
        $columnAyudante1 TEXT NOT NULL,
        $columnAyudante2 TEXT NOT NULL,
        $columnSupervisor TEXT NOT NULL,
        $columnSupervisorSeguridad TEXT NOT NULL
      )
    ''');
    // Crear la tabla de perforaciones
  await db.execute('''
      CREATE TABLE IF NOT EXISTS $tablePerforacion (
        $columnPerforacionId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnPerforacionPerforacion TEXT NOT NULL,
        $columnPerforacionTamano TEXT NOT NULL,
        $columnPerforacionDesde REAL NOT NULL,
        $columnPerforacionHasta REAL NOT NULL,
        $columnPerforacionTotalPerforado REAL NOT NULL,
        $columnPerforacionReporteId INTEGER,
        FOREIGN KEY ($columnPerforacionReporteId) REFERENCES $table ($columnId) ON DELETE CASCADE
      )
    ''');
    // Crear la tabla de herramientas
  await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableHerramienta (
        $columnHerramientaId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnHerramientaHerramienta TEXT NOT NULL,
        $columnHerramientaNumeroSerie TEXT NOT NULL,
        $columnHerramientaSerie TEXT NOT NULL,
        $columnHerramientaDesde REAL NOT NULL,
        $columnHerramientaHasta REAL NOT NULL,
        $columnHerramientaTotal REAL NOT NULL,
        $columnHerramientaReporteId INTEGER,
        FOREIGN KEY ($columnHerramientaReporteId) REFERENCES $table ($columnId) ON DELETE CASCADE
      )
    ''');
    // Crear la tabla de Combustible
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableCombustible (
        $columnCombustibleId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnCombustibleTipoEquipo TEXT NOT NULL,
        $columnCombustibleCantidad REAL NOT NULL,
        $columnCombustibleReporteId INTEGER,
        FOREIGN KEY ($columnCombustibleReporteId) REFERENCES $table ($columnId) ON DELETE CASCADE

      )
    ''');
    // Crear la tabla de Horas
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableHoras (
        $columnHorasId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnHorasTipoMaquinaria TEXT NOT NULL,
        $columnHorasCantidad INTEGER NOT NULL,
        $columnHorasReporteId INTEGER,
        FOREIGN KEY ($columnHorasReporteId) REFERENCES $table ($columnId) ON DELETE CASCADE
      )
    ''');

   await db.execute('''
      CREATE TABLE IF NOT EXISTS $tablePruebasReflex (
        $columnPruebasReflexId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnPruebasReflexProfundidad REAL NOT NULL,
        $columnPruebasReflexMagField REAL NOT NULL,
        $columnPruebasReflexTemp REAL NOT NULL,
        $columnPruebasReflexMagDip REAL NOT NULL,
        $columnPruebasReflexInclinacion REAL NOT NULL,
        $columnPruebasReflexAzimut REAL NOT NULL,
        $columnPruebasReflexReporteId INTEGER,
        FOREIGN KEY ($columnPruebasReflexReporteId) REFERENCES $table ($columnId) ON DELETE CASCADE

      )
    ''');
  }

//Modulos reporte

  Future<int> insertReporte(Reporte reporte) async {
  Database db = await instance.database;
  return await db.insert(table, reporte.toMap());
    }

  Future<List<Reporte>> getReportes() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(maps.length, (i) {
      return Reporte(
        id: maps[i][columnId],
        proyecto: maps[i][columnProyecto],
        fecha: maps[i][columnFecha],
        pozo: maps[i][columnPozo],
        maquina: maps[i][columnMaquina],
        turno: maps[i][columnTurno],
        perforista: maps[i][columnPerforista],
        ayudante1: maps[i][columnAyudante1],
        ayudante2: maps[i][columnAyudante2],
        supervisor: maps[i][columnSupervisor],
        supervisorSeguridad: maps[i][columnSupervisorSeguridad],
      );
    });
  }

  Future<int> deleteReporte(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
// Insertar un registro de perforación
Future<void> insertPerforacion(Perforacion perforacion) async {
  Database db = await instance.database;
  await db.insert(tablePerforacion, perforacion.toMap());
}

// Obtener todos los registros de perforación asociados con un reporteId
Future<List<Perforacion>> getPerforaciones(int reporteId) async {
  Database db = await instance.database;
  List<Map<String, dynamic>> maps = await db.query(
    tablePerforacion,
    where: '$columnPerforacionReporteId = ?',
    whereArgs: [reporteId],
  );
  return List.generate(maps.length, (i) {
    return Perforacion.fromMap(maps[i]);
  });
}

// Eliminar un registro de Perforacion por su ID
Future<int> deletePerforaciones(int id) async {
  Database db = await instance.database;
  return await db.delete(
    tablePerforacion,
    where: '$columnPerforacionId = ?',
    whereArgs: [id]
  );
}

// Insertar un registro de herramienta
Future<void> insertHerramienta(Herramienta herramienta) async {
  Database db = await instance.database;
  await db.insert(tableHerramienta, herramienta.toMap());
}

// Obtener todos los registros de herramienta asociados con un reporteId
Future<List<Herramienta>> getHerramienta(int reporteId) async {
  Database db = await instance.database;
  List<Map<String, dynamic>> maps = await db.query(
    tableHerramienta,
    where: '$columnHerramientaReporteId = ?',
    whereArgs: [reporteId],
  );
  return List.generate(maps.length, (i) {
    return Herramienta.fromMap(maps[i]);
  });
}

// Eliminar un registro de Herramienta por su ID
Future<int> deleteHerramienta(int id) async {
  Database db = await instance.database;
  return await db.delete(
    tableHerramienta,
    where: '$columnHerramientaId = ?',
    whereArgs: [id]
  );
}

// Insertar un registro de combustible
Future<void> insertCombustible(Combustible combustible) async {
  Database db = await instance.database;
  await db.insert(tableCombustible, combustible.toMap());
}

// Obtener todos los registros de combustible asociados con un reporteId
Future<List<Combustible>> getCombustibles(int reporteId) async {
  Database db = await instance.database;
  List<Map<String, dynamic>> maps = await db.query(
    tableCombustible,
    where: '$columnCombustibleReporteId = ?',
    whereArgs: [reporteId],
  );
  return List.generate(maps.length, (i) {
    return Combustible.fromMap(maps[i]);
  });
}

// Eliminar un registro de combustible por su ID
Future<int> deleteCombustible(int id) async {
  Database db = await instance.database;
  return await db.delete(
    tableCombustible,
    where: '$columnCombustibleId = ?',
    whereArgs: [id]
  );
}

// Insertar un registro de horas
Future<void> insertHoras(Horas horas) async {
  Database db = await instance.database;
  await db.insert(tableHoras, horas.toMap());
}


// Obtener todos los registros de horas asociados con un reporteId
Future<List<Horas>> getHoras(int reporteId) async {
  Database db = await instance.database;
  List<Map<String, dynamic>> maps = await db.query(
    tableHoras,
    where: '$columnHorasReporteId = ?',
    whereArgs: [reporteId],
  );
  return List.generate(maps.length, (i) {
    return Horas.fromMap(maps[i]);
  });
}

// Eliminar un registro de horas por su ID
Future<int> deleteHoras(int id) async {
  Database db = await instance.database;
  return await db.delete(
    tableHoras,
    where: '$columnHorasId = ?',
    whereArgs: [id]
  );
}

 
// Insertar un registro de pruebas reflex
Future<void> insertPruebasReflex(PruebasReflex pruebasReflex) async {
  Database db = await instance.database;
  await db.insert(tablePruebasReflex, pruebasReflex.toMap());
}

// Obtener todos los registros de pruebas reflex asociados con un reporteId
Future<List<PruebasReflex>> getPruebasReflex(int reporteId) async {
  Database db = await instance.database;
  List<Map<String, dynamic>> maps = await db.query(
    tablePruebasReflex,
    where: '$columnPruebasReflexReporteId = ?',
    whereArgs: [reporteId],
  );
  return List.generate(maps.length, (i) {
    return PruebasReflex.fromMap(maps[i]);
  });
}

// Eliminar un registro de pruebas reflex por su ID
Future<int> deletePruebasReflex(int id) async {
  Database db = await instance.database;
  return await db.delete(
    tablePruebasReflex,
    where: '$columnPruebasReflexId = ?',
    whereArgs: [id]
  );
}}