import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wardrobe_app/model/ClothingItem.dart';
import 'package:wardrobe_app/screens/addClothingItem_screen.dart';

class WardrobeScreen2 extends StatefulWidget {
  const WardrobeScreen2({super.key});

  @override
  State<WardrobeScreen2> createState() => _WardrobeScreen2State();
}

class _WardrobeScreen2State extends State<WardrobeScreen2> {
  late Future<List<ClothingItem>> futureClothingItems;
  @override
  void initState() {
    super.initState();
    futureClothingItems = fetchClothingItems();
  }

  Future<List<ClothingItem>> fetchClothingItems() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:5150/api/ClothingItemApi'),
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => ClothingItem.fromJson(item)).toList();
    } else {
      throw Exception('Veriler alınamadı.');
    }
  }

  Future<void> addClothingItem(ClothingItem item) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:5150/api/ClothingItemApi'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(item.toJson()),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Kıyafet eklenemedi: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade800,
        title: const Text("Gardırop", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_alt_outlined, color: Colors.white),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newItem = await showModalBottomSheet<ClothingItem>(
            context: context,
            isScrollControlled: true,
            builder: (context) => const AddClothingItemBottomSheet(),
          );

          if (newItem != null) {
            await addClothingItem(newItem); // POST işlemi
            setState(() {
              futureClothingItems = fetchClothingItems();
            });
          }
        },
        backgroundColor: Colors.purple.shade800,
        child: const Icon(Icons.add, color: Colors.white),
      ),

      body: FutureBuilder<List<ClothingItem>>(
        future: futureClothingItems,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final items = snapshot.data!;
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Aynı anda 2 kutu göster
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.8, // Kutu boy oranı
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child:
                            item.imageUrl != null
                                ? Image.file(
                                  File(item.imageUrl!),
                                  fit: BoxFit.cover,
                                )
                                : const Icon(
                                  Icons.image_not_supported,
                                  size: 50,
                                ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text("Renk: ${item.color}"),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
