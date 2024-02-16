import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SQFliteDatabase{
   final _dataBaseName = "note.db";
   final _dataBaseVersion = 1;
   final table = "my_table";
   final columnTitle = "title";
   final columnContent = "content";
   final columnId = "id";

   static Database? _dataBase;

   SQFliteDatabase._privateConstructor();
   static final SQFliteDatabase instance = SQFliteDatabase._privateConstructor();

   Future<Database> get dataBase async{
     if(_dataBase != null) return _dataBase!;

     _dataBase = await  initDataBase();
     return _dataBase!;
   }

   initDataBase() async {
     final documentDirectory = await getApplicationDocumentsDirectory();
     final path = join(documentDirectory.path,_dataBaseName);
     return await openDatabase(path, version: _dataBaseVersion,onCreate: _onCreate);
   }

   Future _onCreate(Database db,int version) async{
     await db.execute(
       '''create table $table(
       $columnId integer primary key autoincrement,
       $columnTitle text not null,
       $columnContent Itext not null
       )'''
     );
   }


   Future<int> insert(Map<String,dynamic> row) async{
     Database db = await instance.dataBase;
     return db.insert(table,row) ;
   }

   Future<List<Map<String,dynamic>>> queryAll() async{
     Database db = await instance.dataBase;
     return db.query(table);
   }

   Future<int> delete(int id) async{
     Database db = await instance.dataBase;
     var res = await db.delete(table,where: "$columnId = ?" ,whereArgs: [id]);
     return res;
   }

   Future<int> update({required int id ,required String title,required String content}) async{
     Database db = await instance.dataBase;
     final res = await db.update(table,{"title" : title ,"content" : content,},where: "$columnId == ?",whereArgs: [id]);
     return res;
   }
}