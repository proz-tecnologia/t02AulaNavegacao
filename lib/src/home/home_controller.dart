import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/models/note_model.dart';
import 'package:todo_app/src/home/home_state.dart';
import 'package:todo_app/utils/shared_preferences_keys.dart';

class HomeController {
  final VoidCallback onUpdate;
  final String username;
  HomeState state = HomeStateEmpty();

  List<NoteModel> myNotes = <NoteModel>[];

  late final SharedPreferences prefs;

  HomeController({
    required this.onUpdate,
    required this.username,
  }) {
    init();
  }

  Future<bool> logout() async {
    return await prefs.clear();
  }

  void updateState(HomeState newState) {
    state = newState;
    onUpdate();
  }

  Future<void> init() async {
    updateState(HomeStateLoading());
    prefs = await SharedPreferences.getInstance();

    final notes = prefs.getString(SharedPreferencesKeys.notes + username);

    if (notes != null && notes.isNotEmpty) {
      final decoded = jsonDecode(notes);

      final decodedNotes =
          (decoded as List).map((e) => NoteModel.fromJson(e)).toList();

      myNotes.addAll(decodedNotes);

      updateState(HomeStateSuccess());
    } else {
      updateState(HomeStateEmpty());
    }
  }

  Future<void> addNote({required NoteModel note}) async {
    updateState(HomeStateLoading());

    myNotes.add(note);

    final myNotesJson = myNotes.map((e) => e.toJson()).toList();

    prefs.setString(
        SharedPreferencesKeys.notes + username, jsonEncode(myNotesJson));

    updateState(HomeStateSuccess());
  }
}
