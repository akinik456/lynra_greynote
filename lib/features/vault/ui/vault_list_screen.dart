import 'package:flutter/material.dart';
import '../data/vault_repository.dart';
import '../models/vault_item.dart';
import 'add_edit_screen.dart';
import 'vault_detail_screen.dart';
import '../data/collection_repository.dart';
import '../models/vault_collection.dart';

class VaultListScreen extends StatefulWidget {
  const VaultListScreen({super.key});

  @override
  State<VaultListScreen> createState() => _VaultListScreenState();
}

class _VaultListScreenState extends State<VaultListScreen> {
  final repo = VaultRepository();
  final vaultKey = '1234';
  String selectedCollectionId = 'default';
  final collectionRepo = CollectionRepository();
  
  List<VaultCollection> collections = [];
  List<VaultItem> items = [];

  @override
  void initState() {
    super.initState();
	loadCollections();
    load();
  }

  Future<void> load() async {
    final result = await repo.getItems(
	  vaultKey: vaultKey,
	  collectionId: selectedCollectionId,
	);
    setState(() => items = result);
  }
  
  Future<void> loadCollections() async {
	  final result = await collectionRepo.getCollections();

	  setState(() {
		collections = result;
		if (collections.isNotEmpty &&
			!collections.any((c) => c.id == selectedCollectionId)) {
		  selectedCollectionId = collections.first.id;
		}
	  });
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
		iban: result["iban"] ?? "",
		collectionId: selectedCollectionId,
		type: result["type"] ?? "standard",
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
      body: Column(
	  children: [
		_CollectionBar(
	  collections: collections,
	  selectedCollectionId: selectedCollectionId,
	  onSelected: (id) async {
		setState(() {
		  selectedCollectionId = id;
		});
		await load();
	  },
	  onAdd: openAddCollection,
	  onDelete: openDeleteCollection,
	),
    Expanded(
      child: items.isEmpty
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
                          iban: result["iban"] ?? "",
						  type: result["type"] ?? "standard",
                        );

                        await load();
                      }
                    },
                    onLongPress: () => delete(item),
                  );
                },
              ),
            ),
    ),
  ],
),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF22D3EE),
        foregroundColor: Colors.black,
        onPressed: openAdd,
        child: const Icon(Icons.add),
      ),
    );
  }
Future<void> openAddCollection() async {
if (collections.length >= 5) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Maximum 5 collections allowed'),
    ),
  );
  return;
}  
  final controller = TextEditingController();
  final result = await showDialog<String>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('New Collection'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'e.g. Mom',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final name = controller.text.trim();
              if (name.isEmpty) return;
              Navigator.pop(context, name);
            },
            child: const Text('Add'),
          ),
        ],
      );
    },
  );

  if (result == null || result.trim().isEmpty) return;

  final id = result
      .trim()
      .toLowerCase()
      .replaceAll(RegExp(r'\s+'), '_');

  await collectionRepo.insertCollection(
    id: id,
    name: result.trim(),
  );

  await loadCollections();

  setState(() {
    selectedCollectionId = id;
  });

  await load();
}  
Future<void> openDeleteCollection(VaultCollection collection) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Delete Collection'),
        content: Text(
          'Delete "${collection.name}"?\n\nAll entries will be permanently deleted.',
        ),
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

  if (confirmed != true) return;

  await collectionRepo.deleteCollection(collection.id);

  await loadCollections();

  setState(() {
    selectedCollectionId = 'default';
  });

  await load();
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
class _CollectionBar extends StatelessWidget {
  final List<VaultCollection> collections;
  final String selectedCollectionId;
  final ValueChanged<String> onSelected;
  final VoidCallback onAdd;
  final Function(VaultCollection) onDelete;
  
  const _CollectionBar({
    required this.collections,
    required this.selectedCollectionId,
    required this.onSelected,
	required this.onAdd,
	required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (collections.isEmpty) {
      return const SizedBox(height: 12);
    }

    return SizedBox(
  height: 58,
  child: ListView.separated(
    padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
    scrollDirection: Axis.horizontal,
    itemCount: collections.length + 1,
    separatorBuilder: (_, __) => const SizedBox(width: 8),
    itemBuilder: (context, index) {
      if (index == collections.length) {
        return ActionChip(
          label: const Text('+'),
          onPressed: onAdd,
          backgroundColor: const Color(0xFF1E293B),
          labelStyle: const TextStyle(
            color: Color(0xFF22D3EE),
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        );
      }

      final collection = collections[index];
      final selected = collection.id == selectedCollectionId;

return InkWell(
  borderRadius: BorderRadius.circular(14),
  onLongPress: collection.id == 'default'
      ? null
      : () => onDelete(collection),
  child: ChoiceChip(
    label: Text(collection.name),
    selected: selected,
    onSelected: (_) => onSelected(collection.id),
    selectedColor: const Color(0xFF22D3EE),
    labelStyle: TextStyle(
      color: selected ? Colors.black : Colors.white,
      fontWeight: FontWeight.w600,
    ),
    backgroundColor: const Color(0xFF1E293B),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    ),
  ),
);
    },
  ),
);
  }
}