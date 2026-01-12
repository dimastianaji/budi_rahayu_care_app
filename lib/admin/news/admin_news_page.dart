import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'admin_news_card.dart';
import 'package:budi_rahayu_care_app/core/services/news_service.dart';

class AdminNewsPage extends StatefulWidget {
  const AdminNewsPage({Key? key}) : super(key: key);

  @override
  State<AdminNewsPage> createState() => _AdminNewsPageState();
}

class _AdminNewsPageState extends State<AdminNewsPage> {
  bool showAddForm = false;
  bool isLoading = false;
  bool isSubmitting = false;

  Uint8List? _imageBytes;
  final ImagePicker _picker = ImagePicker();

  final List<Map<String, dynamic>> newsList = [];

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
void initState() {
  super.initState();
  _loadNews();

  // 👇 Tambahkan ini untuk cek profile user saat ini
  final uid = Supabase.instance.client.auth.currentSession?.user.id;
  if (uid != null) {
    print('🟢 Current User ID: $uid');

    // Cek apakah ada profile untuk user ini
    _checkUserProfile(uid);
  } else {
    print('🔴 User belum login!');
  }
}

Future<void> _checkUserProfile(String uid) async {
  try {
    final profile = await Supabase.instance.client
        .from('profiles')
        .select()
        .eq('id', uid)
        .maybeSingle();

    if (profile != null) {
      print('👤 Profile ditemukan: ${profile['name']} - Role: ${profile['role']}');
    } else {
      print('🔴 Profile tidak ditemukan untuk user ini!');
    }
  } catch (e) {
    print('❌ Error cek profile: $e');
  }
}

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  /// 🔄 Load berita
  Future<void> _loadNews() async {
    setState(() => isLoading = true);
    try {
      final data = await NewsService.getAllNews();
      setState(() => newsList
        ..clear()
        ..addAll(data));
    } catch (_) {
      _showSnackBar('Gagal memuat berita');
    } finally {
      setState(() => isLoading = false);
    }
  }

  /// 🖼️ Pick image
  Future<void> _pickImage() async {
    final XFile? picked =
        await _picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      _imageBytes = await picked.readAsBytes();
      setState(() {});
    }
  }

  /// ➕ Tambah berita
  Future<void> _addNews() async {
  if (_titleController.text.isEmpty || _contentController.text.isEmpty) {
    _showSnackBar('Judul dan isi wajib diisi');
    return;
  }

  setState(() => isSubmitting = true);

  try {
    // Cek authentication terlebih dahulu
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      _showSnackBar('Silakan login terlebih dahulu');
      setState(() => isSubmitting = false);
      return;
    }

    print('👤 Uploading as user: ${user.email}');

    String? imageUrl;

    if (_imageBytes != null) {
      print('📸 Processing image upload...');
      
      // Upload dengan progress feedback
      imageUrl = await NewsService.uploadNewsImage(
        bytes: _imageBytes!,
        fileName: 'news_${DateTime.now().millisecondsSinceEpoch}.jpg',
      );
      
      print('🖼️ Image uploaded: $imageUrl');
    }

    print('📝 Creating news entry...');
    
    await NewsService.createNews(
      title: _titleController.text,
      content: _contentController.text,
      imageUrl: imageUrl,
    );

    // Reset form
    _titleController.clear();
    _contentController.clear();
    _imageBytes = null;
    showAddForm = false;

    // Refresh list
    await _loadNews();
    
    _showSnackBar('Berita berhasil ditambahkan ✅');
    
  } catch (e) {
    print('❌ Error in _addNews: $e');
    
    String errorMessage = 'Gagal menambahkan berita';
    
    if (e.toString().contains('403')) {
      errorMessage = 'Akses ditolak. Pastikan Anda sudah login dengan benar.';
    } else if (e.toString().contains('storage')) {
      errorMessage = 'Gagal mengupload gambar. Coba lagi.';
    }
    
    _showSnackBar(errorMessage);
  } finally {
    setState(() => isSubmitting = false);
  }
}

  /// ✏️ Update berita
  Future<void> _updateNews({
    required String id,
    required String title,
    required String content,
    String? imageUrl,
  }) async {
    try {
      await NewsService.updateNews(
        id: id,
        title: title,
        content: content,
        imageUrl: imageUrl,
      );
      await _loadNews();
      _showSnackBar('Berita berhasil diperbarui');
    } catch (_) {
      _showSnackBar('Gagal memperbarui berita');
    }
  }

  /// 🗑️ Delete berita
  Future<void> _deleteNews(Map<String, dynamic> news) async {
    try {
      await NewsService.deleteNews(
        id: news['id'],
        imageUrl: news['image_url'],
      );
      await _loadNews();
      _showSnackBar('Berita dihapus');
    } catch (_) {
      _showSnackBar('Gagal menghapus berita');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
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

            // 📰 Judul
            const Text(
              "Berita",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 16),

            // ➕ Toggle form
            Card(
              elevation: 3,
              child: InkWell(
                onTap: () {
                  setState(() => showAddForm = !showAddForm);
                },
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: Text("Tambah Berita")),
                ),
              ),
            ),

            if (showAddForm) _buildAddForm(),

            const SizedBox(height: 16),

            // 📃 List berita
            if (isLoading)
              const Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(),
              )
            else if (newsList.isEmpty)
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text('Belum ada berita'),
              )
            else
              for (final news in newsList)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: AdminNewsCard(
                    title: news['title'],
                    content: news['content'],
                    imageUrl: news['image_url'],
                    onSave: (t, c) => _updateNews(
                      id: news['id'],
                      title: t,
                      content: c,
                    ),
                    onDelete: () => _deleteNews(news),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  /// 🧾 Form tambah berita
  Widget _buildAddForm() {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Judul'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _contentController,
              maxLines: 5,
              decoration: const InputDecoration(labelText: 'Isi'),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: _pickImage,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                color: Colors.grey[300],
                child: Center(
                  child: Text(
                    _imageBytes == null
                        ? "Pilih Gambar"
                        : "Gambar dipilih ✅",
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: isSubmitting ? null : _addNews,
              child: isSubmitting
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text("Tambah Berita"),
            ),
          ],
        ),
      ),
    );
  }
}
