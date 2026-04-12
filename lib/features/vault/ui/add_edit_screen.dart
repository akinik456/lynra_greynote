import 'package:flutter/material.dart';

class AddEditScreen extends StatefulWidget {
  final Map<String, dynamic>? initialData;

  const AddEditScreen({
    super.key,
    this.initialData,
  });

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final titleCtrl = TextEditingController();
  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final noteCtrl = TextEditingController();

  bool hidePassword = true;

  @override
  void initState() {
    super.initState();

    if (widget.initialData != null) {
      titleCtrl.text = widget.initialData!["title"] ?? "";
      usernameCtrl.text = widget.initialData!["username"] ?? "";
      passwordCtrl.text = widget.initialData!["password"] ?? "";
      noteCtrl.text = widget.initialData!["note"] ?? "";
    }
  }

  void save() {
    Navigator.pop(context, {
      "title": titleCtrl.text.trim(),
      "username": usernameCtrl.text.trim(),
      "password": passwordCtrl.text,
      "note": noteCtrl.text.trim(),
    });
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.initialData != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Edit Entry" : "New Entry"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        children: [
          _FieldCard(
            label: "Title",
            child: TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(
                hintText: "e.g. Ziraat Bank",
                border: InputBorder.none,
              ),
            ),
          ),
          _FieldCard(
            label: "Username",
            child: TextField(
              controller: usernameCtrl,
              decoration: const InputDecoration(
                hintText: "Username / Email",
                border: InputBorder.none,
              ),
            ),
          ),
          _FieldCard(
            label: "Password",
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: passwordCtrl,
                    obscureText: hidePassword,
                    decoration: const InputDecoration(
                      hintText: "Password",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    hidePassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                )
              ],
            ),
          ),
          _FieldCard(
            label: "Note",
            child: TextField(
              controller: noteCtrl,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: "Optional note",
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF22D3EE),
        foregroundColor: Colors.black,
        onPressed: save,
        label: const Text("Save"),
        icon: const Icon(Icons.check),
      ),
    );
  }
}

class _FieldCard extends StatelessWidget {
  final String label;
  final Widget child;

  const _FieldCard({
    required this.label,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withOpacity(0.6),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            child,
          ],
        ),
      ),
    );
  }
}