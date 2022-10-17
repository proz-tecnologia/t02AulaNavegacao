import 'package:flutter/material.dart';
import 'package:todo_app/src/home/home_controller.dart';
import 'package:todo_app/src/home/home_state.dart';
import 'package:todo_app/utils/app_routes.dart';

import '../../models/note_model.dart';

class HomeArguments {
  final String name;

  const HomeArguments({required this.name});
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeController controller;
  late final String username;
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback(
      (timeStamp) {
        final args =
            ModalRoute.of(context)!.settings.arguments as HomeArguments;
        username = args.name;
        controller = HomeController(
          username: username,
          onUpdate: () {
            setState(() {});
          },
        );
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TodoApp, bem vindo $username'),
        actions: [
          IconButton(
              onPressed: () {
                controller.logout().then(
                      (value) => Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.login,
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
          final myNote = await Navigator.pushNamed(
            context,
            AppRoutes.createNote,
          );

          if (myNote != null) {
            controller.addNote(note: myNote as NoteModel);
          }
        },
      ),
    );
  }
}
