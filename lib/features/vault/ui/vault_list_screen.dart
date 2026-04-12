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
        title: result["title"] ?? "",
        username: result["username"] ?? "",
        password: result["password"] ?? "",
        note: result["note"] ?? "",
      );
      await load();
    }
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

  String formatDate(int ts) {
    final dt = DateTime.fromMillisecondsSinceEpoch(ts);
    final day = dt.day.toString().padLeft(2, '0');
    final month = dt.month.toString().padLeft(2, '0');
    final year = dt.year.toString();
    return '$day.$month.$year';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lynra GreyNote',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: items.isEmpty
          ? const _EmptyState()
          : RefreshIndicator(
              onRefresh: load,
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 90),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];

                  return _VaultCard(
                    item: item,
                    formattedDate: formatDate(item.updatedAt),
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => VaultDetailScreen(item: item),
                        ),
                      );

                      if (result != null) {
  await repo.updateItem(
    vaultKey: vaultKey,
    oldItem: item,
    title: result["title"] ?? "",
    username: result["username"] ?? "",
    password: result["password"] ?? "",
    note: result["note"] ?? "",
  );

  await load();
}
                    },
                    onLongPress: () => delete(item),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF22D3EE),
        foregroundColor: Colors.black,
        onPressed: openAdd,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _VaultCard extends StatelessWidget {
  final VaultItem item;
  final String formattedDate;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const _VaultCard({
    required this.item,
    required this.formattedDate,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: Colors.white.withOpacity(0.05),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        onLongPress: onLongPress,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: const Color(0xFF22D3EE).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
  child: Text(
    (item.title.isNotEmpty
            ? item.title[0]
            : '?')
        .toUpperCase(),
    style: const TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w700,
      color: Color(0xFF22D3EE),
    ),
  ),
),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title.isEmpty ? 'Untitled' : item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.username.isEmpty ? 'No username' : item.username,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.68),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Updated $formattedDate',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white.withOpacity(0.42),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right_rounded,
                color: Colors.white.withOpacity(0.45),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 74,
              height: 74,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Icon(
                Icons.lock_outline,
                size: 34,
                color: Color(0xFF22D3EE),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'No entries yet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap the + button to add your first secure entry.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.62),
              ),
            ),
          ],
        ),
      ),
    );
  }
}