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
  bool _isAdding = false;

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

  // 📸 Pilih foto anak
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  // ➕ Tambah anak
  void _addChild() {
    if (_nameController.text.isEmpty || _descController.text.isEmpty) return;
    setState(() {
      _children.add(ChildModel(
        name: _nameController.text,
        description: _descController.text,
        photoUrl: _selectedImage?.path ??
            'lib/shared/assets/images/child_placeholder.jpg',
      ));
      _isAdding = false;
      _nameController.clear();
      _descController.clear();
      _selectedImage = null;
    });
  }

  // 🗑️ Hapus anak
  void _deleteChild(int index) {
    setState(() {
      _children.removeAt(index);
    });
  }

  // ✏️ Edit anak
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
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Column(
          children: [
            const Header(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Center(
                        child: Text(
                          'Data Anak',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // 🔽 Tambah Data Anak
                      InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          setState(() => _isAdding = !_isAdding);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(color: Colors.black12, blurRadius: 6),
                            ],
                          ),
                          child: _isAdding
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Tambah Data Anak',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(height: 10),
                                    GestureDetector(
                                      onTap: _pickImage,
                                      child: Container(
                                        height: 150,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: _selectedImage != null
                                              ? DecorationImage(
                                                  image: FileImage(
                                                      _selectedImage!),
                                                  fit: BoxFit.cover,
                                                )
                                              : null,
                                        ),
                                        child: _selectedImage == null
                                            ? const Center(
                                                child: Text(
                                                  'Pilih Foto Anak',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              )
                                            : null,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    TextField(
                                      controller: _nameController,
                                      decoration: const InputDecoration(
                                        labelText: 'Nama*',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    TextField(
                                      controller: _descController,
                                      maxLines: 3,
                                      decoration: const InputDecoration(
                                        labelText: 'Deskripsi*',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: _addChild,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue[900],
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 14),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: const Text(
                                          'Tambah Data Anak',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : const Center(
                                  child: Text(
                                    'Tambah Data Anak',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // 🧒 Daftar Anak
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _children.length,
                        itemBuilder: (context, index) {
                          final child = _children[index];
                          return AdminChildCard(
                            childData: child,
                            onDelete: () => _deleteChild(index),
                            onEdit: () => _editChild(index),
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
      ),
      bottomNavigationBar: const AdminBottomNav(currentIndex: 1),
    );
  }
}
