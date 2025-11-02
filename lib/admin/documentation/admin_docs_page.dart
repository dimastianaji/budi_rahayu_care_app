import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:budi_rahayu_care_app/shared/widgets/header.dart';
import 'package:budi_rahayu_care_app/shared/widgets/admin_bottom_nav.dart';

class AdminDocsPage extends StatefulWidget {
  const AdminDocsPage({Key? key}) : super(key: key);

  @override
  State<AdminDocsPage> createState() => _AdminDocumentationPageState();
}

class _AdminDocumentationPageState extends State<AdminDocsPage> {
  bool showAddForm = false;
  Uint8List? _imageBytes;
  final ImagePicker _picker = ImagePicker();

  List<Uint8List?> docs = [];

  Future<void> pickImage() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      final bytes = await file.readAsBytes();
      setState(() {
        _imageBytes = bytes;
      });
    }
  }

  void addDoc() {
    if (_imageBytes != null) {
      setState(() {
        docs.insert(0, _imageBytes);
        _imageBytes = null;
        showAddForm = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const AdminBottomNav(currentIndex: 3),
      body: Column(
        children: [
          const Header(),
          Expanded(
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    const Text(
                      "Dokumentasi",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),

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
                                onTap: pickImage,
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
                                  backgroundColor: Color(0xFF0A2472),
                                  minimumSize: const Size(double.infinity, 40),
                                ),
                                onPressed: addDoc,
                                child: const Text("Tambah Dokumentasi"),
                              ),
                            ],
                          ),
                        ),
                      ),

                    const SizedBox(height: 16),

                    for (var i = 0; i < docs.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                                child: Image.memory(
                                  docs[i]!,
                                  height: 160,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    docs.removeAt(i);
                                  });
                                },
                                child: const Text(
                                  "Hapus",
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
