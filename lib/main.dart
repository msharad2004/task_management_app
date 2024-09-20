import 'package:flutter/material.dart';

void main() => runApp(TaskManagementApp());

class TaskManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Management App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TaskHomePage(),
    );
  }
}

class TaskHomePage extends StatefulWidget {
  @override
  _TaskHomePageState createState() => _TaskHomePageState();
}

class _TaskHomePageState extends State<TaskHomePage> {
  final List<Task> tasks = [];
  final TextEditingController taskController = TextEditingController();
  final TextEditingController deadlineController = TextEditingController();

  void _addTask() {
    if (taskController.text.isNotEmpty) {
      setState(() {
        tasks.add(Task(taskController.text, deadlineController.text));
        taskController.clear();
        deadlineController.clear();
      });
    }
  }

  void _editTask(int index) {
    taskController.text = tasks[index].name;
    deadlineController.text = tasks[index].deadline;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: taskController),
              TextField(controller: deadlineController, decoration: InputDecoration(hintText: "YYYY-MM-DD")),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  tasks[index] = Task(taskController.text, deadlineController.text);
                  taskController.clear();
                  deadlineController.clear();
                });
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task Management')),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tasks[index].name),
            subtitle: Text("Deadline: ${tasks[index].deadline}"),
            onTap: () => _editTask(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Add Task"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(controller: taskController),
                    TextField(controller: deadlineController, decoration: InputDecoration(hintText: "YYYY-MM-DD")),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      _addTask();
                      Navigator.pop(context);
                    },
                    child: Text("Add"),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Task {
  String name;
  String deadline;

  Task(this.name, this.deadline);
}
