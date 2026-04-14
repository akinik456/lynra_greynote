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
  final ibanCtrl = TextEditingController();
  bool showBankDetails = false;
  bool hidePassword = true;
  String entryType = "standard";
  
  @override
  void initState() {
    super.initState();

    if (widget.initialData != null) {
      titleCtrl.text = widget.initialData!["title"] ?? "";
      usernameCtrl.text = widget.initialData!["username"] ?? "";
      passwordCtrl.text = widget.initialData!["password"] ?? "";
      noteCtrl.text = widget.initialData!["note"] ?? "";
    }
	ibanCtrl.text = widget.initialData?["iban"] ?? "";
    showBankDetails = ibanCtrl.text.trim().isNotEmpty;
	entryType = widget.initialData?["type"] ?? "standard";
  }

  void save() {
    Navigator.pop(context, {
      "title": titleCtrl.text.trim(),
      "username": usernameCtrl.text.trim(),
      "password": passwordCtrl.text,
      "note": noteCtrl.text.trim(),
	  "iban": showBankDetails ? ibanCtrl.text.trim() : "",
	  "type": entryType,
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
			Row(
  children: [
    Expanded(
      child: ElevatedButton(
        onPressed: () {
          setState(() => entryType = "standard");
        },
        child: const Text("Standard"),
      ),
    ),
    const SizedBox(width: 8),
    Expanded(
      child: ElevatedButton(
        onPressed: () {
          setState(() => entryType = "note");
        },
        child: const Text("Note"),
      ),
    ),
  ],
),
          _FieldCard(
            label: "Title",
            child: TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(
                hintText: "Title",
                border: InputBorder.none,
              ),
            ),
          ),
		  if (entryType == "standard") ...[
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
  label: "Bank Details",
  child: SwitchListTile(
    contentPadding: EdgeInsets.zero,
    value: showBankDetails,
    onChanged: (value) {
      setState(() {
        showBankDetails = value;
        if (!showBankDetails) {
          ibanCtrl.clear();
        }
      });
    },
    title: const Text("Add IBAN"),
  ),
),
if (showBankDetails)
  _FieldCard(
    label: "IBAN",
    child: TextField(
      controller: ibanCtrl,
      decoration: const InputDecoration(
        hintText: "TR00 0000 0000 0000 0000 0000 00",
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
		  ],
          _FieldCard(
            label: "Note",
            child: TextField(
              controller: noteCtrl,
              maxLines: entryType == "note" ? 10 : 3,
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