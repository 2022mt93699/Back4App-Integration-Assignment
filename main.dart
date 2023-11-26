import 'dart:async';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Parse().initialize(
    '2MgQ5ajx2UQw5RHhpmWUWWQOC6i0m5YAcFl3oZdT',
    'https://parseapi.back4app.com',
    clientKey: 'DCWRhcWjiLFBGHIyf91hVabWFkkljll4FJIqUYdu',
    autoSendSessionId: true,
    debug: true,
  );

  runApp(MyApp());
}

class Task {
  String objectId;
  String title;
  String description;

  Task({required this.objectId, required this.title, required this.description});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<Task> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BITS Pilani Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title:',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: titleController,
            ),
            SizedBox(height: 16),
            Text(
              'Description:',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: descriptionController,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _saveTask();
              },
              child: Text('Add Task'),
            ),
            SizedBox(height: 16),
            Text(
              'Tasks:',
              style: TextStyle(fontSize: 18),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(tasks[index].title),
                    subtitle: Text(tasks[index].description),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _editTask(index);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteTask(index);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveTask() async {
    final Task newTask = Task(
      objectId: '',
      title: titleController.text,
      description: descriptionController.text,
    );

    try {
      final ParseObject taskObject = ParseObject('Task')
        ..set('title', newTask.title)
        ..set('description', newTask.description);

      final ParseResponse apiResponse = await taskObject.save();
      if (apiResponse.success) {
        setState(() {
          newTask.objectId = apiResponse.result!.objectId!;
          tasks.add(newTask);
          titleController.clear();
          descriptionController.clear();
        });
        print('Task added successfully!');
      } else {
        print('Error adding task: ${apiResponse.error!.message}');
      }
    } catch (e) {
      print('Error adding task: $e');
    }
  }

  void _editTask(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: Column(
            children: [
              Text(
                'Title:',
                style: TextStyle(fontSize: 18),
              ),
              TextField(
                controller: TextEditingController(text: tasks[index].title),
                onChanged: (value) {
                  tasks[index].title = value;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Description:',
                style: TextStyle(fontSize: 18),
              ),
              TextField(
                controller: TextEditingController(text: tasks[index].description),
                onChanged: (value) {
                  tasks[index].description = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _updateTask(index);
                Navigator.pop(context);
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _updateTask(int index) async {
    try {
      final ParseObject taskObject = ParseObject('Task')
        ..objectId = tasks[index].objectId
        ..set('title', tasks[index].title)
        ..set('description', tasks[index].description);

      final ParseResponse apiResponse = await taskObject.save();
      if (apiResponse.success) {
        setState(() {
          tasks[index].objectId = apiResponse.result!.objectId!;
        });
        print('Task updated successfully!');
      } else {
        print('Error updating task: ${apiResponse.error!.message}');
      }
    } catch (e) {
      print('Error updating task: $e');
    }
  }

  void _deleteTask(int index) async {
    try {
      final ParseObject taskObject = ParseObject('Task')
        ..objectId = tasks[index].objectId;

      final ParseResponse apiResponse = await taskObject.delete();
      if (apiResponse.success) {
        setState(() {
          tasks.removeAt(index);
        });
        print('Task deleted successfully!');
      } else {
        print('Error deleting task: ${apiResponse.error!.message}');
      }
    } catch (e) {
      print('Error deleting task: $e');
    }
  }
}