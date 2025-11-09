import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  Uint8List? _imageBytes;

  final ImagePicker _picker = ImagePicker();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

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

  Future<void> _addNews() async {
    if (_titleController.text.isNotEmpty &&
        _contentController.text.isNotEmpty &&
        _imageBytes != null) {
      try {
        // Upload gambar ke Firebase Storage
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference storageRef =
            FirebaseStorage.instance.ref().child('news_images/$fileName.jpg');

        UploadTask uploadTask = storageRef.putData(_imageBytes!);
        TaskSnapshot snapshot = await uploadTask;
        String imageUrl = await snapshot.ref.getDownloadURL();

        // Simpan data ke Firestore
        await FirebaseFirestore.instance.collection('news').add({
          'title': _titleController.text,
          'content': _contentController.text,
          'imageUrl': imageUrl,
          'date': Timestamp.now(),
        });

        setState(() {
          _titleController.clear();
          _contentController.clear();
          _imageBytes = null;
          showAddForm = false;
        });

        print('Mulai upload berita...');
print('Berita berhasil disimpan ke Firestore');


        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Berita berhasil ditambahkan')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menambahkan berita: $e')),
        );
      }
    }
  }

  Future<void> _deleteNews(String docId, String imageUrl) async {
    try {
      // Hapus gambar dari Storage
      await FirebaseStorage.instance.refFromURL(imageUrl).delete();

      // Hapus dokumen dari Firestore
      await FirebaseFirestore.instance.collection('news').doc(docId).delete();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Berita berhasil dihapus')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menghapus berita: $e')),
      );
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

                    // List Berita dari Firestore
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('news')
                          .orderBy('date', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (!snapshot.hasData ||
                            snapshot.data!.docs.isEmpty) {
                          return const Text("Belum ada berita");
                        }

                        final beritaList = snapshot.data!.docs;

                        return Column(
                          children: beritaList.map((doc) {
                            final data = doc.data() as Map<String, dynamic>;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: AdminNewsCard(
                                title: data['title'] ?? '',
                                content: data['content'] ?? '',
                                imageUrl: data['imageUrl'] ?? '',
                                onSave: (newTitle, newContent) async {
                                  await FirebaseFirestore.instance
                                      .collection('news')
                                      .doc(doc.id)
                                      .update({
                                    'title': newTitle,
                                    'content': newContent,
                                  });
                                },
                                onDelete: () async {
                                  await _deleteNews(
                                      doc.id, data['imageUrl'] ?? '');
                                },
                              ),
                            );
                          }).toList(),
                        );
                      },
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
