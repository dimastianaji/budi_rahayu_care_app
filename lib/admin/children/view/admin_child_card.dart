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
    return GestureDetector(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    widget.childData.photoUrl,
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
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => setState(() => _isExpanded = !_isExpanded),
                  child: Text(
                    _isExpanded ? 'Tutup' : 'Edit',
                    style: const TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
            if (_isExpanded) ...[
              const SizedBox(height: 10),
              TextField(
                controller: _descController,
                maxLines: 4,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              // Tombol Simpan Deskripsi
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.childData.description = _descController.text;
                      _isExpanded = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Simpan Deskripsi',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Tombol Hapus Data Anak
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final confirm = await showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Konfirmasi Hapus'),
                        content: const Text(
                            'Apakah kamu yakin ingin menghapus data anak ini?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text(
                              'Batal',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Hapus'),
                          ),
                        ],
                      ),
                    );
                    if (confirm == true) widget.onDelete();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Hapus Data Anak',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
