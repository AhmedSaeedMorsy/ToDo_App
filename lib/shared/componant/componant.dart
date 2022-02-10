import 'package:flutter/material.dart';
import 'package:todoapp/shared/cubit/cubit.dart';

Widget buildTaskItem(Map taskes, context) {
  return Dismissible(
    key: Key(taskes['id'].toString()),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          CircleAvatar(
            child: Text("${taskes['time']}"),
            radius: 40.0,
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${taskes['title']}",
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text('${taskes['date']}'),
              ],
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          IconButton(
            onPressed: () {
              AppCubit.get(context).upDateDataBase(
                status: 'done',
                id: taskes['id'],
              );
            },
            icon: const Icon(
              Icons.check_box,
              color: Colors.green,
            ),
          ),
          IconButton(
            onPressed: () {
              AppCubit.get(context).upDateDataBase(
                status: 'archived',
                id: taskes['id'],
              );
            },
            icon: const Icon(Icons.archive, color: Colors.black45),
          ),
        ],
      ),
    ),
    onDismissed: (direction) {
      AppCubit.get(context).deleteFromDataBase(id: taskes['id']);
    },
  );
}

Widget taskBuilder({
  required List<Map> taskes,
}) {
  if (taskes.isNotEmpty) {
    return ListView.separated(
      itemBuilder: (context, index) => buildTaskItem(taskes[index], context),
      itemCount: taskes.length,
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
  } else {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.menu,
            color: Colors.grey,
            size: 100.0,
          ),
          Text(
            'No Tasks Yet , Please Add Some Tasks',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
