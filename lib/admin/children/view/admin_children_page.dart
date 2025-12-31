import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/child_model.dart';
import '../../../core/services/child_service.dart';
import 'admin_child_card.dart';

class AdminChildrenPage extends StatefulWidget {
  const AdminChildrenPage({super.key});

  @override
  State<AdminChildrenPage> createState() => _AdminChildrenPageState();
}

class _AdminChildrenPageState extends State<AdminChildrenPage> {
  bool showAddForm = false;
  bool isLoading = false;
  bool isSubmitting = false;

  late Future<List<ChildModel>> _childrenFuture;

  final _nameController = TextEditingController();
  final _descController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  Uint8List? _imageBytes;
  String? _imageName;

  @override
  void initState() {
    super.initState();
    _loadChildren();
  }

  void _loadChildren() {
    _childrenFuture = ChildService.getChildren();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  /// 🖼️ Pick image
  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      _imageBytes = await picked.readAsBytes();
      _imageName = picked.name;
      setState(() {});
    }
  }

  /// ➕ Add child
  Future<void> _addChild() async {
    if (_nameController.text.trim().isEmpty ||
        _descController.text.trim().isEmpty ||
        _imageBytes == null ||
        _imageName == null) {
      _showSnackBar('Semua field wajib diisi');
      return;
    }

    setState(() => isSubmitting = true);

    try {
      await ChildService.addChild(
        name: _nameController.text.trim(),
        description: _descController.text.trim(),
        photoBytes: _imageBytes!,
        photoName: _imageName!,
      );

      _nameController.clear();
      _descController.clear();
      _imageBytes = null;
      _imageName = null;
      showAddForm = false;

      setState(_loadChildren);
      _showSnackBar('Data anak berhasil ditambahkan ✅');
    } catch (_) {
      _showSnackBar('Gagal menambahkan data anak');
    } finally {
      setState(() => isSubmitting = false);
    }
  }

  /// ✏️ Update
  Future<void> _updateChild(
    String id,
    String name,
    String description,
  ) async {
    await ChildService.updateChild(
      id: id,
      name: name,
      description: description,
    );
    setState(_loadChildren);
  }

  /// 🗑️ Delete
  Future<void> _deleteChild(String id) async {
    await ChildService.deleteChild(id);
    setState(_loadChildren);
  }

  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 8),

            /// 👶 Judul
            const Text(
              "Data Anak",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 16),

            /// ➕ Toggle Form
            Card(
              elevation: 3,
              child: InkWell(
                onTap: () {
                  setState(() => showAddForm = !showAddForm);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: Text(
                      showAddForm ? "Tutup Form" : "Tambah Data Anak",
                    ),
                  ),
                ),
              ),
            ),

            if (showAddForm) _buildAddForm(),

            const SizedBox(height: 16),

            /// 📃 List Anak
            FutureBuilder<List<ChildModel>>(
              future: _childrenFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(),
                  );
                }

                final children = snapshot.data ?? [];

                if (children.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('Belum ada data anak'),
                  );
                }

                return Column(
                  children: children
                      .map(
                        (child) => Padding(
                          padding:
                              const EdgeInsets.only(bottom: 12),
                          child: AdminChildCard(
                            childData: child,
                            onDelete: () =>
                                _deleteChild(child.id),
                            onEdit: (id, name, desc) =>
                                _updateChild(id, name, desc),
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// 🧾 Form tambah anak
  Widget _buildAddForm() {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration:
                  const InputDecoration(labelText: 'Nama Anak'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descController,
              maxLines: 4,
              decoration:
                  const InputDecoration(labelText: 'Deskripsi'),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: _pickImage,
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 10),
                color: Colors.grey[300],
                child: Center(
                  child: Text(
                    _imageBytes == null
                        ? "Pilih Foto"
                        : "Foto dipilih ✅",
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: isSubmitting ? null : _addChild,
              child: isSubmitting
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child:
                          CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text("Tambah Data Anak"),
            ),
          ],
        ),
      ),
    );
  }
}
