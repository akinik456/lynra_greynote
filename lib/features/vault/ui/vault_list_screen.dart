import 'package:flutter/material.dart';
import '../data/vault_repository.dart';
import '../models/vault_item.dart';
import 'add_edit_screen.dart';
import 'vault_detail_screen.dart';

class VaultListScreen extends StatefulWidget {
  const VaultListScreen({super.key});

  @override
  State<VaultListScreen> createState() => _VaultListScreenState();
}

class _VaultListScreenState extends State<VaultListScreen> {
  final repo = VaultRepository();
  final vaultKey = '1234';

  List<VaultItem> items = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    final result = await repo.getItems(vaultKey);
    setState(() => items = result);
  }

  Future<void> addDummy() async {
    await repo.insertItem(
      vaultKey: vaultKey,
      title: "New Item ${DateTime.now().second}",
      username: "user",
      password: "pass",
      note: "",
    );
    await load();
  }
Future<void> delete(VaultItem item) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Delete entry'),
        content: Text('Delete "${item.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      );
    },
  );

  if (confirmed == true) {
    await repo.deleteItem(item.id);
    await load();
  }
}
Future<void> openAdd() async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const AddEditScreen(),
    ),
  );

  if (result != null) {
    await repo.insertItem(
      vaultKey: vaultKey,
      title: result["title"],
      username: result["username"],
      password: result["password"],
      note: result["note"],
    );
    await load();
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GreyNote"),
      ),
      body: items.isEmpty
          ? const Center(child: Text("No entries"))
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];

                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
					  title: Text(item.title),
					  subtitle: Text(item.username),
					  trailing: const Icon(Icons.chevron_right),
					  onTap: () async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => VaultDetailScreen(item: item),
    ),
  );

  if (result != null) {
    await repo.deleteItem(item.id);

    await repo.insertItem(
      vaultKey: vaultKey,
      title: result["title"],
      username: result["username"],
      password: result["password"],
      note: result["note"],
    );

    await load();
  }
},
					  onLongPress: () => delete(item),
					),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: openAdd,
        child: const Icon(Icons.add),
      ),
    );
  }
}