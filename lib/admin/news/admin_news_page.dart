import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'admin_news_card.dart';
import 'package:budi_rahayu_care_app/shared/widgets/header.dart';
import 'package:budi_rahayu_care_app/shared/widgets/admin_bottom_nav.dart';

class AdminNewsPage extends StatefulWidget {
  const AdminNewsPage({Key? key}) : super(key: key);

  @override
  State<AdminNewsPage> createState() => _AdminNewsPageState();
}

class _AdminNewsPageState extends State<AdminNewsPage> {
  bool showAddForm = false;
  Uint8List? _imageBytes; // Menyimpan data gambar

  final ImagePicker _picker = ImagePicker();

  List<Map<String, dynamic>> newsList = [
    {
      'title': 'Judul Berita',
      'content':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa.',
      'image': null,
    },
    {
      'title': 'Judul Berita',
      'content':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa.',
      'image': null,
    },
  ];

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  /// Fungsi untuk memilih gambar dari galeri
  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytes = bytes;
      });
    }
  }

  /// Fungsi menambahkan berita
  void _addNews() {
    if (_titleController.text.isNotEmpty &&
        _contentController.text.isNotEmpty) {
      setState(() {
        newsList.insert(0, {
          'title': _titleController.text,
          'content': _contentController.text,
          'image': _imageBytes,
        });
        _titleController.clear();
        _contentController.clear();
        _imageBytes = null;
        showAddForm = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const AdminBottomNav(currentIndex: 2),
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
                      "Berita",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Tombol Tambah Berita
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 12),
                          child: Center(
                            child: Text(
                              "Tambah Berita",
                              style: TextStyle(
                                color: Colors.indigo.shade900,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Form Tambah Berita
                    if (showAddForm)
                      Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Judul Berita*"),
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
                              const Text("Berita*"),
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
                              const Text("Tambahkan Foto Berita*"),
                              const SizedBox(height: 4),

                              // Tombol pilih gambar
                              InkWell(
                                onTap: _pickImage,
                                child: Container(
                                  width: double.infinity,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: Colors.grey[300],
                                  ),
                                  child: Center(
                                    child: Text(
                                      _imageBytes == null
                                          ? "Browse"
                                          : "Gambar dipilih ✅",
                                      style: TextStyle(
                                        color: Colors.indigo.shade900,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 8),

                              // Preview gambar (jika ada)
                              if (_imageBytes != null)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.memory(
                                    _imageBytes!,
                                    height: 150,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),

                              const SizedBox(height: 16),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.indigo.shade900,
                                  minimumSize:
                                      const Size(double.infinity, 40),
                                ),
                                onPressed: _addNews,
                                child: const Text(
                                  "Tambah Berita",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    const SizedBox(height: 16),

                    // List Berita
                    for (var i = 0; i < newsList.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: AdminNewsCard(
                          title: newsList[i]['title']!,
                          content: newsList[i]['content']!,
                          imageBytes: newsList[i]['image'], 
                          onSave: (newTitle, newContent) {
                            setState(() {
                              newsList[i]['title'] = newTitle;
                              newsList[i]['content'] = newContent;
                            });
                          },
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
