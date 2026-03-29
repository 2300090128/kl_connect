import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  List<Map<String, dynamic>> adminPosts = [
    {
      "id": "1",
      "title": "College Reopening",
      "content": "Reopening after holidays",
      "imageUrl": "https://picsum.photos/400/200?random=1",
      "timestamp": DateTime.now().subtract(const Duration(days: 2)),
    },
  ];

  void openCreatePost() async {
    final result = await Navigator.pushNamed(context, '/admin-create');
    if (result != null && result is Map) {
      setState(() {
        final post = Map<String, dynamic>.from(result);
        post["id"] = DateTime.now().millisecondsSinceEpoch.toString();
        post["timestamp"] = DateTime.now();
        adminPosts.insert(0, post);
      });
    }
  }

  void openEditPost(int index) async {
    final result = await Navigator.pushNamed(
      context,
      '/admin-edit',
      arguments: adminPosts[index],
    );

    if (result != null && result is Map) {
      setState(() {
        adminPosts[index] = {...adminPosts[index], ...result};
      });
    }
  }

  void deletePost(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Post"),
        content: const Text("Are you sure you want to delete this post?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                adminPosts.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Post deleted successfully")),
              );
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: openCreatePost,
            tooltip: "Create Post",
          ),
        ],
      ),
      body: adminPosts.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.inbox, size: 60, color: Colors.grey),
                  const SizedBox(height: 10),
                  const Text("No posts yet"),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: openCreatePost,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF003366),
                    ),
                    child: const Text("Create First Post"),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: adminPosts.length,
              itemBuilder: (context, index) {
                final post = adminPosts[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        post["imageUrl"] ?? "",
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 150,
                            color: Colors.grey[300],
                            child: const Center(child: Icon(Icons.image)),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post["title"] ?? "",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              post["content"] ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _formatDate(post["timestamp"]),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => openEditPost(index),
                              tooltip: "Edit",
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => deletePost(index),
                              tooltip: "Delete",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return "";
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return "${difference.inDays}d ago";
    } else if (difference.inHours > 0) {
      return "${difference.inHours}h ago";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes}m ago";
    } else {
      return "just now";
    }
  }
}
