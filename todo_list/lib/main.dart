import 'package:flutter/material.dart';

// My lib
import 'package:todo_list/task_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo List',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: new MyHomePage(
        title: "Todo List",
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _tasks = [];
  int _counter = 0;

  TextEditingController textEditingController = new TextEditingController();

  void addTask(String taskName) {
    setState(() {
      _tasks.add(new TaskModel(taskName));
    });
    textEditingController.clear();
  }

  void deleteTasks() {
    setState(() {
      var _newTasks = [];
      for (int i = 0; i < _tasks.length; i++) {
        if (!_tasks[i].finished) {
          _newTasks.add(_tasks[i]);
        }
      }
      _tasks = _newTasks;
      _counter = 0;
    });
  }

  Widget getTask(TaskModel task) {
    return new Row(children: [
      IconButton(
        onPressed: () {
          setState(() {
            task.finished = !task.finished;
            if (task.finished)
              _counter++;
            else
              _counter--;
          });
        },
        icon: new Icon(
          task.finished
              ? Icons.check_box_outlined
              : Icons.check_box_outline_blank,
          color: Colors.deepPurple,
        ),
        iconSize: 42.0,
      ),
      new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(task.taskName),
          Text(task.registerDate.toIso8601String())
        ],
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsetsDirectional.all(8.0),
            child: TextField(
              controller: textEditingController,
              onSubmitted: addTask,
            ),
          ),
          Container(
            padding: EdgeInsetsDirectional.all(8.0),
            child: Text("Tarefas selecionadas:" + _counter.toString()),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: _tasks.length,
                  itemBuilder: (_, id) {
                    return getTask(_tasks[id]);
                  }))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: deleteTasks,
        tooltip: "Delete",
        backgroundColor: Colors.red,
        child: const Icon(Icons.delete),
      ),
    );
  }
}
