import 'package:flutter/material.dart';
import 'package:budi_rahayu_care_app/admin/documentation/documentation_model.dart';
import 'package:budi_rahayu_care_app/admin/documentation/documentation_service.dart';

class DocumentationSection extends StatelessWidget {
  const DocumentationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffe0e0e0), // ⬅️ sama dengan TujuanSection
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 🏷️ Judul Section
          const Text(
            'Dokumentasi Kegiatan',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xff343434),
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          // 📸 Slideshow Dokumentasi
          SizedBox(
            height: 180,
            child: FutureBuilder<List<Documentation>>(
              future: DocumentationService.getAll(),
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'Belum ada dokumentasi',
                      style: TextStyle(color: Color(0xff343434)),
                    ),
                  );
                }

                final docs = snapshot.data!;

                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  itemCount: docs.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    final doc = docs[index];

                    return Container(
                      width: 240,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          doc.imageUrl!,
                          fit: BoxFit.cover,
                          loadingBuilder:
                              (context, child, progress) {
                            if (progress == null) return child;
                            return Container(
                              color: Colors.grey[300],
                              child: const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
