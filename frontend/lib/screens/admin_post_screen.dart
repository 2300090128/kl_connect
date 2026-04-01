import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminPostScreen extends StatefulWidget {
  final Map<String, dynamic>? postData;

  const AdminPostScreen({super.key, this.postData});

  @override
  State<AdminPostScreen> createState() => _AdminPostScreenState();
}

class _AdminPostScreenState extends State<AdminPostScreen> {

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  File? image;
  String? imageUrl;
  final picker = ImagePicker();

  List<String> tags = ["CSE", "ECE", "IT", "1st Year", "2nd Year"];
  List<String> selectedTags = [];

  bool isEditMode = false;

  @override
  void initState() {
    super.initState();
    // 🔥 Load post data if editing
    if (widget.postData != null) {
      isEditMode = true;
      titleController.text = widget.postData!["title"] ?? "";
      descController.text = widget.postData!["content"] ?? "";
      imageUrl = widget.postData!["imageUrl"];
    }
  }

  Future pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        image = File(picked.path);
      });
    }
  }

  void savePost() {

    if (titleController.text.isEmpty || descController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Fill all fields")),
      );
      return;
    }

    final postData = {
      "title": titleController.text,
      "content": descController.text,
      "imageUrl": imageUrl ?? "https://picsum.photos/400/200",
    };

    Navigator.pop(context, postData); // 🔥 IMPORTANT
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditMode ? "Edit Post" : "Create Post")),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            GestureDetector(
              onTap: pickImage,
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: image == null
                    ? const Center(child: Icon(Icons.add_a_photo, size: 40))
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.file(image!, fit: BoxFit.cover),
                      ),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: descController,
              maxLines: 4,
              decoration: const InputDecoration(labelText: "Description"),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Cancel"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: savePost,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF003366),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(isEditMode ? "Update" : "Post"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}