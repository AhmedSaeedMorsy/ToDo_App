// ignore_for_file: file_names, avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/shared/componant/componant.dart';
import 'package:todoapp/shared/cubit/cubit.dart';
import 'package:todoapp/shared/cubit/states.dart';

class NewTaskes extends StatelessWidget {
  const NewTaskes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var taskes = AppCubit.get(context).newTaskes;
        return taskBuilder(taskes: taskes);
      },
    );
  }
}
/*
ListView.separated(
      itemBuilder: (BuildContext context, int index) =>
          buildTaskItem(taskes![index]),
      itemCount: taskes!.length,
      separatorBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsetsDirectional.only(start: 10.0),
          child: Container(
            height: 1.0,
            color: Colors.black,
          ),
        );
      },
    );
*/
/*var taskes = AppCubit.get(context).taskes;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, State) {},
      builder: (context, State) {
        return ListView.separated(
          itemBuilder: (BuildContext context, int index) =>
              buildTaskItem(taskes![index]),
          itemCount: taskes!.length,
          separatorBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsetsDirectional.only(start: 10.0),
              child: Container(
                height: 1.0,
                color: Colors.black,
              ),
            );
          },
        );
      },
    );*/