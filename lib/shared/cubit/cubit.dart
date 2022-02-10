// ignore_for_file: avoid_print, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/modules/archivedTaskes/archivedTaskes.dart';
import 'package:todoapp/modules/doneTaskes/doneTaskes.dart';
import 'package:todoapp/modules/newTaskes/newTaskes.dart';
import 'package:todoapp/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(initAppState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<Widget> screen = [
    const NewTaskes(),
    const DoneTaskes(),
    const ArchivedTaskes(),
  ];
  List title = ["New Taskes", "Done Taskes", "Archived Taskes"];
  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeAppState());
  }

  late Database database;

  List<Map> newTaskes = [];
  List<Map> doneTaskes = [];
  List<Map> archivedTaskes = [];

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheet({required bool isShow, required IconData icon}) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }

  void createDataBase() {
    openDatabase(
      "todo.db",
      version: 1,
      onCreate: (database, version) {
        print("database is created");
        database.execute(
            "create table taskes (id integer primary key , title text , date text , time text ,status text )");
      },
      onOpen: (database) {
        getDataFromDataBase(database);
        print("database is opened");
      },
    ).then((value) {
      database = value;
      emit(AppCreateDataBaseState());
    });
  }

  insertDataBase({
    required String title,
    required String date,
    required String time,
  }) async {
    await database.transaction((txn) async {
      return txn
          .rawInsert(
              "insert into taskes (title , date , time , status) VALUES('$title','$date', '$time' , 'new') ")
          .then((value) {
        print("$value is inserted");
        emit(AppInsertDataintoDataBaseState());
        getDataFromDataBase(database);
      });
    });
  }

  void getDataFromDataBase(database) {
    newTaskes = [];
    doneTaskes = [];
    archivedTaskes = [];

    database.rawQuery("select * from taskes").then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTaskes.add(element);
        } else if (element['status'] == 'done') {
          doneTaskes.add(element);
        } else {
          archivedTaskes.add(element);
        }
      });

      emit(AppGetDataFromDataBaseState());
    });
  }

  void upDateDataBase({required String status, required int id}) {
    database.rawUpdate(
        'UPDATE taskes SET status = ? WHERE id = ?', ['$status', id]).then(
      (value) {
        getDataFromDataBase(database);
        emit(AppUpDateDatainDataBaseState());
      },
    );
  }

  void deleteFromDataBase({
    required int id,
  }) {
    database.rawDelete('DELETE FROM taskes WHERE id = ?', [id]).then((value) {
      emit(AppDeleteDatainDataBaseState());
      getDataFromDataBase(database);
    });
  }
}
