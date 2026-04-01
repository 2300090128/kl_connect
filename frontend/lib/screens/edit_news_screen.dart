import 'package:flutter/material.dart';

class EditNewsScreen extends StatefulWidget {
  final Map<String, String> newsItem;

  const EditNewsScreen({super.key, required this.newsItem});

  @override
  State<EditNewsScreen> createState() => _EditNewsScreenState();
}

class _EditNewsScreenState extends State<EditNewsScreen> {

  late TextEditingController titleController;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(
      text: widget.newsItem["title"],
    );
  }

  void updateNews() {
    setState(() {
      widget.newsItem["title"] = titleController.text;
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Post"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [

            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Edit Title",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: updateNews,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF003366),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}