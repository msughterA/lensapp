import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';

// Example table details
final String _exampleTable = 'exampleTable';
final String _exampleId = '_id';
final String _example = 'example';

// Question and Answer details
final String _qaTable = 'qaTable';
final String _qId = '_id';
final String _question = 'question';
final String _answer = 'answer';
final String _module = 'module';

// Summary details
final String _summaryTable = 'summaryTable';
final String _summaryId = '_id';
final String _summary = 'summary';

class SummaryModel {
  int id;
  String summary;
  SummaryModel({this.id, this.summary});
  Map<String, dynamic> toMap() {
    var map = {_summaryId: id, _summary: summary};
    return map;
  }

  SummaryModel.fromMap(Map<String, dynamic> map) {
    id = map[_summaryId];
    summary = map[_summary];
  }
}

class ExampleModel {
  int id;
  String example;

  ExampleModel({this.id, this.example});
  Map<String, dynamic> toMap() {
    var map = {_example: example, _exampleId: id};
    return map;
  }

  ExampleModel.fromMap(Map<String, dynamic> map) {
    id = map[_exampleId];
    example = map[_example];
  }
}

class QAModel {
  int id;
  String question;
  String answer;
  String module;
  QAModel({this.id, this.answer, this.question, this.module});
  Map<String, dynamic> toMap() {
    var map = {_qId: id, _question: question, _answer: answer, _module: module};
    return map;
  }

  QAModel.fromMap(Map<String, dynamic> map) {
    id = map[_qId];
    question = map[_question];
    answer = map[_answer];
  }
}

class DatabaseHelper {
  static Database _db;
  static final _dbName = 'Database.db';
  static final _dbVersion = 1;
  static final _exTable = _exampleTable;
  static final _qTable = _qaTable;
  static final _sumTable = _summaryTable;
  //making it a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_db != null) return _db;
    _db = await _initiateDatabase();
    return _db;
  }

  Future _initiateDatabase() async {
    Directory path = await Directory('');
    String dbpath = join(path.path, _dbName);
    return await openDatabase(dbpath, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    // Create the example table
    await db.execute('''
create table $_exampleTable ( 
  $_exampleId integer primary key autoincrement, 
  $_example text not null)
''');
// Create the Quetion and Answer table
    await db.execute('''
create table $_qTable ( 
  $_qId integer primary key autoincrement, 
  $_question text not null,
  $_answer text not null,
  $_module text not null)
''');
// Create the Summary table
    await db.execute('''
create table $_sumTable ( 
  $_summaryId integer primary key autoincrement, 
  $_summary text not null)
''');
  }

  Future<int> insertExample(Map<String, dynamic> row) async {
    Database db = await instance.database;
    // Insert an Example into the examples table
    return await db.insert(_exTable, row);
  }

  Future<int> insertQA(Map<String, dynamic> row) async {
    Database db = await instance.database;
    // Insert Question and Answer into the examples table
    print('THIS IS THE ROW');
    return await db.insert(_qTable, row);
  }

  Future<int> insertSummary(Map<String, dynamic> row) async {
    Database db = await instance.database;
    // Insert Question and Answer into the qa table

    return await db.insert(_sumTable, row);
  }

  Future queryExamples() async {
    Database db = await instance.database;
    return await db.query(_exTable);
  }

  Future querySummary() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> history = await db.query(_sumTable);
    List hist = [];
    history.forEach((element) {
      Map myMap = {'summary': json.decode(element['summary'])};
      hist.add(myMap);
    });
    return hist;
  }

  Future queryQA(String modle) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> history = await db.query(_qTable,
        columns: ['$_qId', '$_question', '$_answer', '$_module'],
        where: '$_module=?',
        whereArgs: [modle]);
    List hist = [];
    history.forEach((element) {
      //var newElement = json.decode(element);
      Map myMap = {
        'question': json.decode(element['question']),
        'answer': json.decode(element['answer'])
      };
      hist.add(myMap);
    });

    return hist;
  }
}
