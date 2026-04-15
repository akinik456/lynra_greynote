import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class VaultWordScreen extends StatefulWidget {
  const VaultWordScreen({super.key});

  @override
  State<VaultWordScreen> createState() => _VaultWordScreenState();
}

class _VaultWordScreenState extends State<VaultWordScreen> {
  bool enabled = false;
  final storage = const FlutterSecureStorage();
  final wordCtrl = TextEditingController();
  
@override
void initState() {
  super.initState();
  loadVaultWord();
}

Future<void> loadVaultWord() async {
  final enabledValue = await storage.read(key: "vault_word_enabled");
  final savedWord = await storage.read(key: "vault_word");

  setState(() {
    enabled = enabledValue == "true";
    wordCtrl.text = savedWord ?? "";
  });
}  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vault Word"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text("Enable Vault Word"),
              value: enabled,
              onChanged: (val) {
                setState(() {
                  enabled = val;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: wordCtrl,
              decoration: const InputDecoration(
                labelText: "Vault Word",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
  await storage.write(key: "vault_word_enabled", value: enabled.toString());
  await storage.write(key: "vault_word", value: wordCtrl.text);

  Navigator.pop(context, true);
},
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}