// ignore_for_file: file_names, avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/shared/componant/componant.dart';
import 'package:todoapp/shared/cubit/cubit.dart';
import 'package:todoapp/shared/cubit/states.dart';

class ArchivedTaskes extends StatelessWidget {
  const ArchivedTaskes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var taskes = AppCubit.get(context).archivedTaskes;
        return taskBuilder(taskes: taskes);
      },
    );
  }
}
