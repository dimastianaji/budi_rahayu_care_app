import 'package:flutter/material.dart';
import '../models/child_model.dart';

class AdminChildCard extends StatefulWidget {
  final ChildModel childData;

  /// kirim id + data baru ke parent
  final void Function(String id, String name, String description) onEdit;
  final VoidCallback onDelete;

  const AdminChildCard({
    super.key,
    required this.childData,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  State<AdminChildCard> createState() => _AdminChildCardState();
}

class _AdminChildCardState extends State<AdminChildCard> {
  bool _isExpanded = false;
  late final TextEditingController _nameController;
  late final TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.childData.name);
    _descController =
        TextEditingController(text: widget.childData.description);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final photoUrl = widget.childData.photoUrl;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: photoUrl != null && photoUrl.isNotEmpty
                    ? Image.network(
                        photoUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _imageFallback(),
                      )
                    : _imageFallback(),
              ),
              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  widget.childData.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),

              IconButton(
                icon: Icon(
                  _isExpanded ? Icons.close : Icons.edit,
                  color: Colors.indigo,
                ),
                onPressed: () =>
                    setState(() => _isExpanded = !_isExpanded),
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// VIEW MODE
          if (!_isExpanded)
            Text(
              widget.childData.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.black87),
            ),

          /// EDIT MODE
          if (_isExpanded) ...[
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nama Anak',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: _descController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Deskripsi',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 40),
              ),
              onPressed: () {
                widget.onEdit(
                  widget.childData.id,
                  _nameController.text.trim(),
                  _descController.text.trim(),
                );

                setState(() => _isExpanded = false);
              },
              child: const Text("Simpan Perubahan"),
            ),

            const SizedBox(height: 8),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 40),
              ),
              onPressed: widget.onDelete,
              child: const Text("Hapus Data Anak"),
            ),
          ],
        ],
      ),
    );
  }

  /// fallback jika foto kosong / error
  Widget _imageFallback() {
    return Container(
      width: 50,
      height: 50,
      color: Colors.grey.shade300,
      child: const Icon(
        Icons.person,
        color: Colors.grey,
      ),
    );
  }
}
