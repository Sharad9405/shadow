import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:shadow/db/db_constant.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'table/table.dart';
import 'package:shadow/model/model.dart';

class DbHelper {
  static final _databaseName = DbConstant.databaseName;
  static final _databaseVersion = DbConstant.databaseVersion;

  // ten plus one plan Table
  static final _tppTableName = TenPlusOnePlan.tenPlusOnePlanTableName;
  static final _tppId = TenPlusOnePlan.id;
  // static final _tppColumnId = TenPlusOnePlan.tppColumnId;
  static final _tppColumnPayableEmiAmount =
      TenPlusOnePlan.tppColumnPayableEmiAmount;
  static final _tppColumnFirstEmiAmount =
      TenPlusOnePlan.tppColumnFirstEmiAmount;
  static final _tppColumnNinethEmiAmount =
      TenPlusOnePlan.tppColumnNinethEmiAmount;
  static final _tppColumnEleventhEmiAmount =
      TenPlusOnePlan.tppColumnEleventhEmiAmount;
  static final _tppColumnTotalPurchaseAmount =
      TenPlusOnePlan.tppColumnTotalPurchaseAmount;
  static final _tppColumnTotalSavings = TenPlusOnePlan.tppColumnTotalSavings;
  static final _tppPlanStartAndMaturityDate =
      TenPlusOnePlan.tppPlanStartAndMaturityDate;

  // Gold Table
  static final _goldTableName = GoldTable.goldTableName;
  static final _goldColumnId = GoldTable.goldColumnId;
  static final _goldTitle = GoldTable.goldTitle;
  static final _goldDescription = GoldTable.goldDescription;
  static final _goldWeight = GoldTable.goldWeight;
  static final _goldPrice = GoldTable.goldPrice;
  static final _goldImgUrl = GoldTable.goldImageUrl;
  static final _goldType = GoldTable.goldType;

  static final DbHelper instance = DbHelper._privateConstructor();

  // singleton class
  DbHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;

  Future<Database> get database async {
    if (_database == null) {
      // lazily instantiate the db the first time it is accessed
      _database = await _initDatabase();
      return _database;
    }
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    print('_initDatabase=> init database');
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databaseName);

    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // Create DB tablr
  Future _onCreate(Database db, int version) async {
    print('_onCreate => create table');

    // await db.execute('''
    //   CREATE TABLE $_tableName (
    //   $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
    //   $columnName TEXT NOT NULL,
    //   $columnAge INTEGER NOT NULL
    //   )
    // ''');

    //create ten-plus-one plan table
    await db.execute('''
      CREATE TABLE $_tppTableName (
        $_tppId INTEGER PRIMARY KEY AUTOINCREMENT,
        $_tppColumnPayableEmiAmount TEXT NOT NULL,
        $_tppColumnFirstEmiAmount TEXT NOT NULL,
        $_tppColumnNinethEmiAmount TEXT NOT NULL,
        $_tppColumnEleventhEmiAmount TEXT NOT NULL,
        $_tppColumnTotalPurchaseAmount TEXT NOT NULL,
        $_tppColumnTotalSavings TEXT NOT NULL,
        $_tppPlanStartAndMaturityDate TEXT NOT NULL
      )
    ''');
    // Gold Table
    await db.execute('''
      CREATE TABLE $_goldTableName (
        $_goldColumnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $_goldTitle TEXT NOT NULL,
        $_goldDescription TEXT NOT NULL,
        $_goldWeight TEXT NOT NULL,
        $_goldPrice TEXT NOT NULL,
        $_goldImgUrl TEXT NOT NULL,
        $_goldType TEXT NOT NULL
      )
    ''');
  }

  //Helper methods
  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.

  // Future<int> insert(Map<String, dynamic> values) async {
  //   Database db = await instance.database;
  //   return await db.insert(_tableName, values);
  // }

  /// * insert *******/
  Future<int> insertTenPlusOnePlanInDb(
      TenPlusOnePlanModel tenPlusOnePlanModel) async {
    Database db = await instance.database;
    return await db.insert(_tppTableName, tenPlusOnePlanModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> insertGoldItemInDb(GoldModel model) async {
    Database db = await instance.database;
    return await db.insert(_goldTableName, model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // All of the rows are returned as a list of maps, where each map is
  // key-value list of columns.

  // Future<List<Map<String, dynamic>>> getAllRows() async {
  //   Database db = await instance.database;
  //   return await db.query(_tableName);
  // }

  /// * Read *******/
  // Using sqflite we can query data in many ways by using arguments
  // such as where, groupBy, having, orderBy and columns inside query() helper.
  Future<List<TenPlusOnePlanModel>> getAllTenPlusOnePlanFromDb() async {
    ////returns the memos as a list (array)
    Database db = await instance.database;

    final maps = await db.query(
        _tppTableName); // //query all the rows in a table as an array of maps

    return List.generate(maps.length, (i) {
      return TenPlusOnePlanModel(
        id: maps[i][TenPlusOnePlan.id],
        payableEmiAmount: maps[i][TenPlusOnePlan.tppColumnPayableEmiAmount],
        firstEmiOff: maps[i][TenPlusOnePlan.tppColumnFirstEmiAmount],
        ninethEmi: maps[i][TenPlusOnePlan.tppColumnNinethEmiAmount],
        eleventhEmi: maps[i][TenPlusOnePlan.tppColumnEleventhEmiAmount],
        totalPurchaseAmount: maps[i]
            [TenPlusOnePlan.tppColumnTotalPurchaseAmount],
        totalSaving: maps[i][TenPlusOnePlan.tppColumnTotalSavings],
        planStartAndMaturityDate: maps[i]
            [TenPlusOnePlan.tppPlanStartAndMaturityDate],
      );
    });
  }

  Future<List<GoldModel>> getAllGoldItemListFromDb() async {
    Database db = await instance.database;

    final result = await db.query(
        _goldTableName); // //query all the rows in a table as an array of maps
    return List.generate(result.length, (i) {
      return GoldModel(
        id: result[i][GoldTable.goldColumnId],
        title: result[i][GoldTable.goldTitle],
        description: result[i][GoldTable.goldDescription],
        weight: result[i][GoldTable.goldWeight],
        price: result[i][GoldTable.goldPrice],
        imgUrl: result[i][GoldTable.goldImageUrl],
        goldType: result[i][GoldTable.goldType],
      );
    });
  }

  Future<GoldModel> getGoldItemById(int id) async {
    final db = await instance.database;
    var result = await db.query(_goldTableName, where: '$_goldColumnId = ?', whereArgs: [id]);
    // return result.isNotEmpty ? GoldModel.toModel(result.first) : Null;

    // return result.isNotEmpty ? GoldModel.toModel(result.first) : Null;

    if(result.length > 0){
     return GoldModel.fromMap(result.first);
    }
    return null;
  }

  /// * Delete *******/
  // Use the where argument in delete() helper to delete specific rows from the table.
  // Remember to use whereArgs to pass arguments to where statement in order to prevent SQL injection attacks.
  Future<int> deleteTenPlusOnePlanRecord(int id) async {
    Database db = await instance.database;
    int result =
        await db.delete(_tppTableName, where: '$_tppId = ?', whereArgs: [id]);
    return result;
  }

  Future<int> deleteGoldItemRecord(int id) async {
    Database db = await instance.database;
    int result = await db
        .delete(_goldTableName, where: '$_goldColumnId = ?', whereArgs: [id]);
    return result;
  }

  /// * Update *******/
  /*
  Use update() helper to update any record in the database. To update specific records, use the where argument.
  * */
  Future<int> updateTenPlusOnePlanRecord(
      int id, TenPlusOnePlanModel model) async {
    Database db = await instance.database;

    int result = await db.update(_tppTableName, model.toMap(),
        where: '$_tppId = ?', whereArgs: [id]);
    return result;
  }

  Future<int> updateGoldItemRecord(int id, GoldModel model) async {
    Database db = await instance.database;

    int result = await db.update(_goldTableName, model.toMap(),
        where: '$_goldColumnId = ?', whereArgs: [id]);
    return result;
  }

  // All the methods (insert, query, update, delete) can also be done using
  // row SQL commands. This method uses a raw query and return the row count

  // Future<int> getAllRowCount() async {
  //   Database db = await instance.database;
  //   return Sqflite.firstIntValue(
  //       await db.rawQuery('SELECT COUNT (*) FROM $_tableName'));
  // }

  Future<int> getAllRecordInTenPlusOnePlanTable() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT (*) FROM $_tppTableName'));
  }

  Future<int> getAllRecordCountInGoldTable() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT (*) FROM $_goldTableName'));
  }

  // we are assuming here that the id column in the map is set.
  // the other column values will used to update the row.

  // Future<int> update(Map<String, dynamic> row) async {
  //   Database db = await instance.database;
  //   int id = row[columnId];
  //   return await db
  //       .update(_tableName, row, where: '$columnId = ?', whereArgs: [id]);
  // }

  // Future<int> update(Map<String, dynamic> row) async {
  //   Database db = await instance.database;
  //   int id = row[columnId];
  //   return await db
  //       .update(_tableName, row, where: '$columnId = ?', whereArgs: [id]);
  // }

  // delete the row specified by the id. the number of row affected row is
  // returned.
  // Future<int> delete(int id) async {
  //   Database db = await instance.database;
  //   return await db.delete(_tableName, where: '$columnId = ?', whereArgs: [id]);
  // }
}
