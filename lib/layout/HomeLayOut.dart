// ignore_for_file: file_names, avoid_print, unused_local_variable, must_call_super, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:todoapp/shared/cubit/cubit.dart';
import 'package:todoapp/shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  HomeLayout({Key? key}) : super(key: key);


  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var controllerTitle = TextEditingController();
  var controllerDate = TextEditingController();
  var controllerTime = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDataBase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(AppCubit.get(context)
                  .title[AppCubit.get(context).currentIndex]),
            ),
            body: AppCubit.get(context)
                .screen[AppCubit.get(context).currentIndex],
            floatingActionButton: FloatingActionButton(
                child: Icon(AppCubit.get(context).fabIcon),
                onPressed: () {
                  if (AppCubit.get(context).isBottomSheetShown) {
                    if (formKey.currentState!.validate()) {
                      AppCubit.get(context).insertDataBase(
                        title: controllerTitle.text,
                        date: controllerDate.text,
                        time: controllerTime.text,
                      );
                      Navigator.pop(context);

                      AppCubit.get(context).changeBottomSheet(
                        isShow: false,
                        icon: Icons.edit,
                      );
                    }
                  } else {
                    scaffoldKey.currentState!
                        .showBottomSheet(
                          (context) => Container(
                            width: double.infinity,
                            color: Colors.grey[100],
                            padding: const EdgeInsetsDirectional.all(20.0),
                            child: Form(
                              key: formKey,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      controller:   controllerTitle,
                                      keyboardType: TextInputType.text,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return ('Title must not be empty');
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Task Name',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        prefixIcon: const Icon(
                                          Icons.title,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    TextFormField(
                                      controller: controllerTime,
                                      keyboardType: TextInputType.datetime,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return ('Time must not be empty');
                                        }
                                        return null;
                                      },
                                      onTap: () {
                                        showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        ).then((value) => {
                                              controllerTime.text = value!
                                                  .format(context)
                                                  .toString()
                                            });
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Task Time',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        prefixIcon: const Icon(
                                          Icons.watch_later_outlined,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    TextFormField(
                                      controller: controllerDate,
                                      keyboardType: TextInputType.datetime,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return ('Date must not be empty');
                                        }
                                        return null;
                                      },
                                      onTap: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate:
                                              DateTime.parse('2021-12-30'),
                                        ).then(
                                          (value) {
                                            controllerDate.text =
                                                DateFormat.yMMMd()
                                                    .format(value!);
                                          },
                                        );
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Task Date',
                                        
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        prefixIcon: const Icon(
                                          Icons.calendar_today_outlined,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                        .closed
                        .then((value) {
                      AppCubit.get(context)
                          .changeBottomSheet(isShow: false, icon: Icons.edit);
                    });
                    AppCubit.get(context)
                        .changeBottomSheet(isShow: true, icon: Icons.add);
                  }
                }),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: AppCubit.get(context).currentIndex,
              onTap: (index) {
                AppCubit.get(context).changeIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: "New taskes",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.done,
                  ),
                  label: "Done Taskes",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined),
                  label: "Archived Taskes",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}