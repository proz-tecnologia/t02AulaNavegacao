import 'package:flutter/material.dart';
import 'package:todo_app/src/create_note/create_note_page.dart';
import 'package:todo_app/src/home/home_controller.dart';
import 'package:todo_app/src/home/home_state.dart';
import 'package:todo_app/src/login/login_page.dart';

import '../../models/note_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.name,
  });

  final String name;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeController controller;
  @override
  void initState() {
    controller = HomeController(
      onUpdate: () {
        setState(() {});
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TodoApp, bem vindo ${widget.name}'),
        actions: [
          IconButton(
              onPressed: () {
                controller.logout().then(
                      (value) => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginPage(),
                        ),
                      ),
                    );
              },
              icon: const Icon(
                Icons.exit_to_app,
              )),
        ],
      ),
      body: Builder(
        builder: (context) {
          if (controller.state.runtimeType == HomeStateLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (controller.state.runtimeType == HomeStateEmpty) {
            return const Center(
              child: Text('Você ainda não tem notas!'),
            );
          } else if (controller.state.runtimeType == HomeStateSuccess) {
            return ListView.builder(
              itemCount: controller.myNotes.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4.0,
                  ),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.myNotes[i].title,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const Divider(),
                          Text(
                            controller.myNotes[i].subtitle,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final myNote = await Navigator.push<NoteModel?>(
            context,
            MaterialPageRoute(
              builder: (_) => const CreateNote(),
            ),
          );

          if (myNote != null) {
            controller.addNote(note: myNote);
          }
        },
      ),
    );
  }
}
