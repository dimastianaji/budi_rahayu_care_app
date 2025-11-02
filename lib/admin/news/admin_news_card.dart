import 'dart:typed_data';
import 'package:flutter/material.dart';

class AdminNewsCard extends StatefulWidget {
  final String title;
  final String content;
  final Uint8List? imageBytes;
  final void Function(String newTitle, String newContent) onSave;

  const AdminNewsCard({
    Key? key,
    required this.title,
    required this.content,
    required this.imageBytes,
    required this.onSave,
  }) : super(key: key);

  @override
  State<AdminNewsCard> createState() => _AdminNewsCardState();
}

class _AdminNewsCardState extends State<AdminNewsCard> {
  bool isEditing = false;
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _contentController = TextEditingController(text: widget.content);
  }

  @override
  void didUpdateWidget(covariant AdminNewsCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.title != widget.title) {
      _titleController.text = widget.title;
    }
    if (oldWidget.content != widget.content) {
      _contentController.text = widget.content;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _toggleEditMode() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  void _saveChanges() {
    final newTitle = _titleController.text.trim();
    final newContent = _contentController.text.trim();
    widget.onSave(newTitle, newContent);
    setState(() {
      isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER: Judul dan ikon pensil (ikon selalu muncul)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),

              // Ikon pensil selalu tampil dengan warna indigo
              IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: Colors.indigo,
                ),
                onPressed: _toggleEditMode,
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Gambar berita (selalu tampil di luar mode edit)
          if (widget.imageBytes != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.memory(
                widget.imageBytes!,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

          const SizedBox(height: 10),

          // Mode edit aktif → tampilkan input judul & konten
          if (isEditing) ...[
            const Text("Judul Berita"),
            const SizedBox(height: 6),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text("Isi Berita"),
            const SizedBox(height: 6),
            TextField(
              controller: _contentController,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo.shade900,
                minimumSize: const Size(double.infinity, 40),
              ),
              onPressed: _saveChanges,
              child: const Text(
                "Simpan Perubahan",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],

          // Mode normal → tampilkan preview isi berita
          if (!isEditing)
            Text(
              widget.content,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
        ],
      ),
    );
  }
}
