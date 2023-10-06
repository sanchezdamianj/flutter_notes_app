import 'package:flutter/material.dart';
import 'package:notes_app/database/database_handler.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/screens/create_note_page.dart';
import 'package:notes_app/screens/edit_note_page.dart';
import 'package:notes_app/theme/colors.dart';
import 'package:notes_app/widgets/button_widget.dart';
import 'package:notes_app/widgets/dialog_box_widget.dart';
import 'package:notes_app/widgets/single_note_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: darkBackgroundColor,
          title: const Text("Notes", style: TextStyle(fontSize: 40)),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Row(
                children: [
                  ButtonWidget(icon: Icons.search),
                  SizedBox(
                    width: 10,
                  ),
                  ButtonWidget(icon: Icons.info_outline),
                ],
              ),
            )
          ]),
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const CreateNotePage()));
          },
          backgroundColor: Colors.black54,
          child: const Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
      body: StreamBuilder<List<NoteModel>>(
          stream: DatabaseHanlder.getNotes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Image.asset(
                  "assets/ios_loading.gif",
                  width: 50,
                  height: 50,
                ),
              );
            }

            if (snapshot.hasData == false) {
              return const Center(
                child: Text("No data"),
              );
            }

            if (snapshot.data!.isEmpty) {
              return _noNotesWidget();
            }

            if (snapshot.hasData) {
              final notes = snapshot.data;
              return ListView.builder(
                itemCount: notes!.length,
                itemBuilder: (context, index) {
                  return SingleNoteWidget(
                    title: notes[index].title,
                    body: notes[index].body,
                    color: notes[index].color,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => EditNotePage(
                                    noteModel: notes[index],
                                  )));
                    },
                    onLongPress: () {
                      showDialogBoxWidget(
                        context,
                        height: 250,
                        title: "Are you sure you want to delete this note ?",
                        onTapYes: () {
                          DatabaseHanlder.deleteNote(notes[index].id!);
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
              );
            }

            return Center(
              child: Image.asset(
                "assets/ios_loading.gif",
                width: 50,
                height: 50,
              ),
            );
          }),
    );
  }

  _noNotesWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: 200,
              height: 200,
              child: Image.asset("assets/add_notes_image.png")),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "Create Colorful Notes",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
