import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wardrobe_app/model/ClothingItem.dart';
import 'package:wardrobe_app/model/GeneralEnums.dart';

class AddClothingItemBottomSheet extends StatefulWidget {
  const AddClothingItemBottomSheet({super.key});

  @override
  State<AddClothingItemBottomSheet> createState() =>
      _AddClothingItemBottomSheetState();
}

class _AddClothingItemBottomSheetState
    extends State<AddClothingItemBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  File? _selectedImage;

  String name = '';
  int category = ClothingCategory.Upper.index;
  int material = ClothingMaterial.Cotton.index;
  String color = '';
  String note = '';

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newItem = ClothingItem(
        name: name,
        color: color,
        category: category,
        imageUrl: _selectedImage!.path,
        material: material,
        note: note,
      );

      Navigator.of(context).pop(newItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text('Yeni Kıyafet Ekle', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: _pickImage,
                child:
                    _selectedImage == null
                        ? Container(
                          height: 150,
                          width: double.infinity,
                          color: Colors.grey[300],
                          child: const Icon(Icons.add_a_photo, size: 50),
                        )
                        : Image.file(_selectedImage!, height: 150),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'İsim'),
                validator:
                    (value) =>
                        value == null || value.isEmpty ? 'Zorunlu alan' : null,
                onSaved: (value) => name = value!,
              ),

              DropdownButtonFormField<ClothingMaterial>(
                decoration: const InputDecoration(labelText: 'Materyal'),
                //value: material,
                items:
                    ClothingMaterial.values
                        .map(
                          (e) => DropdownMenuItem<ClothingMaterial>(
                            value: e,
                            child: Text(e.name), // sadece name kullanıyoruz
                          ),
                        )
                        .toList(),
                onChanged: (value) => material = value!.index,
              ),

               DropdownButtonFormField<ClothingCategory>(
                 decoration: const InputDecoration(labelText: 'Kategori'),
                 //value: material,
                 items:
               ClothingCategory.values
                        .map(
                          (e) => DropdownMenuItem<ClothingCategory>(
                            value: e,
                            child: Text(e.name), // sadece name kullanıyoruz
                          ),
                        )
                        .toList(),
                onChanged: (value) => category = value!.index,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Renk'),
                validator:
                    (value) =>
                        value == null || value.isEmpty ? 'Zorunlu alan' : null,
                onSaved: (value) => color = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Not (opsiyonel)'),
                onSaved: (value) => note = value ?? '',
              ),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: _submit, child: const Text('Kaydet')),
            ],
          ),
        ),
      ),
    );
  }
}
