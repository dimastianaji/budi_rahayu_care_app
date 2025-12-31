import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../documentation/documentation_model.dart';
import '../documentation/documentation_service.dart';

class AdminDocsPage extends StatefulWidget {
  const AdminDocsPage({Key? key}) : super(key: key);

  @override
  State<AdminDocsPage> createState() => _AdminDocsPageState();
}

class _AdminDocsPageState extends State<AdminDocsPage> {
  bool showAddForm = false;
  bool isLoading = false;

  Uint8List? _imageBytes;
  final ImagePicker _picker = ImagePicker();

  List<Documentation> docs = [];

  @override
  void initState() {
    super.initState();
    _loadDocs();
  }

  // ======================
  // LOAD DATA
  // ======================
  Future<void> _loadDocs() async {
    setState(() => isLoading = true);
    docs = await DocumentationService.getAll();
    setState(() => isLoading = false);
  }

  // ======================
  // PICK IMAGE
  // ======================
  Future<void> _pickImage() async {
    final XFile? file = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (file != null) {
      final bytes = await file.readAsBytes();
      setState(() {
        _imageBytes = bytes;
      });
    }
  }

  // ======================
  // CREATE DOC
  // ======================
  Future<void> _addDoc() async {
    if (_imageBytes == null) return;

    setState(() => isLoading = true);

    await DocumentationService.create(
      title: 'Dokumentasi',
      imageBytes: _imageBytes!,
      imageName: 'doc.jpg',
    );

    _imageBytes = null;
    showAddForm = false;

    await _loadDocs();
  }

  // ======================
  // DELETE DOC
  // ======================
  Future<void> _deleteDoc(String id) async {
    setState(() => isLoading = true);
    await DocumentationService.delete(id);
    await _loadDocs();
  }

  // ======================
  // UI
  // ======================
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 8),

            // 🖼️ Judul Halaman
            const Text(
              "Dokumentasi",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 16),

            // ➕ Tambah Dokumentasi
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    showAddForm = !showAddForm;
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: Text(
                      "Tambah Dokumentasi",
                      style: TextStyle(
                        color: Color(0xFF0A2472),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // 📸 Form Tambah
            if (showAddForm)
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Tambahkan Dokumentasi*"),
                      const SizedBox(height: 6),

                      InkWell(
                        onTap: _pickImage,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.grey[300],
                          ),
                          child: Center(
                            child: Text(
                              _imageBytes == null
                                  ? "Browse"
                                  : "Gambar dipilih ✅",
                              style: const TextStyle(
                                color: Color(0xFF0A2472),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      if (_imageBytes != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.memory(
                            _imageBytes!,
                            height: 160,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),

                      const SizedBox(height: 14),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0A2472),
                          minimumSize: const Size(double.infinity, 40),
                        ),
                        onPressed: isLoading ? null : _addDoc,
                        child: const Text(
                          "Tambah Dokumentasi",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 16),

            // ⏳ Loading
            if (isLoading)
              const Padding(
                padding: EdgeInsets.all(24),
                child: CircularProgressIndicator(),
              ),

            // 🗂️ List Dokumentasi
            for (final doc in docs)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      if (doc.imageUrl != null)
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10),
                          ),
                          child: Image.network(
                            doc.imageUrl!,
                            height: 160,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      TextButton(
                        onPressed: () => _deleteDoc(doc.id),
                        child: const Text(
                          "Hapus",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
