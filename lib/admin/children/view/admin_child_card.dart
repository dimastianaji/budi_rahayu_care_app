import 'dart:io';
import 'package:flutter/material.dart';
import '../model/child_model.dart';

class AdminChildCard extends StatefulWidget {
  final ChildModel childData;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

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
  late TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    _descController = TextEditingController(text: widget.childData.description);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: widget.childData.photoUrl.startsWith('lib/')
                    ? Image.asset(
                        widget.childData.photoUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        File(widget.childData.photoUrl),
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
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
                icon: const Icon(Icons.edit, color: Colors.indigo),
                onPressed: () => setState(() => _isExpanded = !_isExpanded),
              ),
            ],
          ),
          const SizedBox(height: 6),
          if (!_isExpanded)
            Text(
              widget.childData.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          if (_isExpanded) ...[
            TextField(
              controller: _descController,
              maxLines: 4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo.shade900,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 40),
              ),
              onPressed: () {
                setState(() {
                  widget.childData.description = _descController.text;
                  _isExpanded = false;
                });
              },
              child: const Text("Simpan Deskripsi"),
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
}
