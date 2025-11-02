import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../model/child_model.dart';
import 'admin_child_card.dart';
import 'package:budi_rahayu_care_app/shared/widgets/header.dart';
import 'package:budi_rahayu_care_app/shared/widgets/admin_bottom_nav.dart';

class AdminChildrenPage extends StatefulWidget {
  const AdminChildrenPage({super.key});

  @override
  State<AdminChildrenPage> createState() => _AdminChildrenPageState();
}

class _AdminChildrenPageState extends State<AdminChildrenPage> {
  bool showAddForm = false;

  final List<ChildModel> _children = [
    ChildModel(
      name: 'Zhafir Zaidan Avail',
      description: 'Anak yang ceria dan rajin belajar.',
      photoUrl: 'lib/shared/assets/images/kid1.png',
    ),
    ChildModel(
      name: 'Alvin Bagus Firmansyah',
      description: 'Suka membaca dan membantu teman-temannya.',
      photoUrl: 'lib/shared/assets/images/kid2.png',
    ),
  ];

  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _addChild() {
    if (_nameController.text.isNotEmpty && _descController.text.isNotEmpty) {
      setState(() {
        _children.insert(
          0,
          ChildModel(
            name: _nameController.text,
            description: _descController.text,
            photoUrl: _selectedImage?.path ??
                'lib/shared/assets/images/child_placeholder.jpg',
          ),
        );
        _nameController.clear();
        _descController.clear();
        _selectedImage = null;
        showAddForm = false;
      });
    }
  }

  void _deleteChild(int index) {
    setState(() {
      _children.removeAt(index);
    });
  }

  void _editChild(int index) {
    final child = _children[index];
    final nameController = TextEditingController(text: child.name);
    final descController = TextEditingController(text: child.description);
    File? editedImage;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Data Anak'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  final picker = ImagePicker();
                  final pickedFile =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      editedImage = File(pickedFile.path);
                    });
                  }
                },
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: editedImage != null
                          ? FileImage(editedImage!)
                          : (child.photoUrl.startsWith('lib/')
                              ? AssetImage(child.photoUrl)
                              : FileImage(File(child.photoUrl))) as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Ganti Foto (opsional)',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Anak',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi Anak',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo.shade900,
            ),
            onPressed: () {
              setState(() {
                _children[index] = ChildModel(
                  name: nameController.text,
                  description: descController.text,
                  photoUrl: editedImage?.path ?? child.photoUrl,
                );
              });
              Navigator.pop(context);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const AdminBottomNav(currentIndex: 1),
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
                      "Data Anak",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 🔽 Tombol Tambah Data Anak
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
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
                              "Tambah Data Anak",
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

                    // 🧒 Form Tambah Anak
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
                              const Text("Nama Anak*"),
                              const SizedBox(height: 4),
                              TextField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Text("Deskripsi Anak*"),
                              const SizedBox(height: 4),
                              TextField(
                                controller: _descController,
                                maxLines: 4,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Text("Tambahkan Foto Anak*"),
                              const SizedBox(height: 4),
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
                                      _selectedImage == null ? "Browse" : "Gambar dipilih ✅",
                                      style: TextStyle(
                                        color: Colors.indigo.shade900,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              if (_selectedImage != null)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    _selectedImage!,
                                    height: 150,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),

                              const SizedBox(height: 12),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.indigo.shade900,
                                  minimumSize:
                                      const Size(double.infinity, 40),
                                ),
                                onPressed: _addChild,
                                child: const Text(
                                  "Tambah Data Anak",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    const SizedBox(height: 16),

                    // 🔽 Daftar Anak
                    for (var i = 0; i < _children.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: AdminChildCard(
                          childData: _children[i],
                          onDelete: () => _deleteChild(i),
                          onEdit: () => _editChild(i),
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
