import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../config.dart';

class TodoListApp extends StatefulWidget {
  const TodoListApp({Key? key}) : super(key: key);

  @override
  _TodoListAppState createState() => _TodoListAppState();
}

class _TodoListAppState extends State<TodoListApp> {
  List<String> tasks = [];

  @override
  void initState() {
    super.initState();
    _getNotes();
  }

  Future<void> _getNotes() async {
    try {
      final List<String> notes = await getAllNotes();
      setState(() {
        tasks = notes;
      });
    } catch (e) {
      print('Error loading notes: $e');
      // يمكنك إضافة رسالة خطأ للمستخدم هنا
    }
  }

  Future<List<String>> getAllNotes() async {
    try {
      final response = await http.get(Uri.parse(adminnotget));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print(data);
        final List<String> notes =
            data.map((item) => item['Data'].toString()).toList();
        return notes;
      } else {
        throw Exception(
            'Failed to load notes. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error loading notes: $e');
    }
  }

  void _addTask(String task) async {
    try {
      final response = await http.post(
        Uri.parse(adminnote),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'Data': task}),
      );

      if (response.statusCode == 200) {
        setState(() {
          tasks.add(task);
        });
        _showToast('تمت إضافة المهمة بنجاح', Colors.green);
      } else {
        _showToast('فشلت عملية إضافة المهمة. الرمز: ${response.statusCode}',
            Colors.red);
      }
    } catch (e) {
      _showToast('حدث خطأ أثناء إضافة المهمة: $e', Colors.red);
    }
  }

  void _removeTask(int index) async {
    try {
      final response = await http.delete(
        Uri.parse(adminnotedelet),
        body: {'Data': tasks[index]},
      );

      if (response.statusCode == 200) {
        setState(() {
          tasks.removeAt(index);
        });
        _showToast('تم حذف المهمة بنجاح', Colors.green);
      } else {
        _showToast(
            'فشلت عملية حذف المهمة. الرمز: ${response.statusCode}', Colors.red);
      }
    } catch (e) {
      _showToast('حدث خطأ أثناء حذف المهمة: $e', Colors.red);
    }
  }

  void _showToast(String message, Color backgroundColor) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Todo List',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            const SizedBox(height: 20),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            const SizedBox(height: 20),
            if (tasks.isEmpty) const Center(child: Text('لا شيء لعرضه.')),
            if (tasks.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(tasks[index]),
                    onDismissed: (direction) => _removeTask(index),
                    background: Container(
                      color: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: AlignmentDirectional.centerStart,
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    secondaryBackground: Container(
                      color: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: AlignmentDirectional.centerEnd,
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    child: ListTile(
                      title: Text(tasks[index], textAlign: TextAlign.end),
                    ),
                  );
                },
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _showAddTaskDialog(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: Icon(Icons.add)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    String taskTitle = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('العنوان'),
          content: TextField(
            onChanged: (value) {
              taskTitle = value;
            },
            decoration: const InputDecoration(
              hintText: 'أدخل الملاحظة',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('حذف'),
            ),
            ElevatedButton(
              onPressed: () {
                if (taskTitle.isNotEmpty) {
                  _addTask(taskTitle);
                  Navigator.of(context).pop();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text('إضافة'),
            ),
          ],
        );
      },
    );
  }
}
