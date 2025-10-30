import 'dart:typed_data';
import 'package:flutter/material.dart';

class AdminNewsCard extends StatefulWidget {
  final String title;
  final String content;
  final Uint8List? imageBytes; // <-- Tambahan baru
  final Function(String, String) onSave;

  const AdminNewsCard({
    Key? key,
    required this.title,
    required this.content,
    this.imageBytes, // <-- Tambahan baru
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
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📸 Tampilkan gambar jika ada
            if (widget.imageBytes != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.memory(
                  widget.imageBytes!,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

            if (widget.imageBytes != null) const SizedBox(height: 12),

            // 📰 Jika sedang edit
            if (isEditing) ...[
              const Text("Edit Judul Berita*"),
              const SizedBox(height: 4),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text("Edit Isi Berita*"),
              const SizedBox(height: 4),
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
                onPressed: () {
                  widget.onSave(
                    _titleController.text,
                    _contentController.text,
                  );
                  setState(() {
                    isEditing = false;
                  });
                },
                child: const Text(
                  "Simpan Perubahan",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ] else ...[
              // 🧾 Tampilan default (judul + konten)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isEditing = true;
                      });
                    },
                    icon: const Icon(Icons.edit, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                widget.content,
                maxLines: 3, // hanya tampil 3 baris
                overflow: TextOverflow.ellipsis, // tampilkan "..."
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
