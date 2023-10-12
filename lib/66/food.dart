

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class Food4 extends StatefulWidget {


  const Food4({Key? key}) : super(key: key);

  @override
  _FoodState createState() => _FoodState();
}

class _FoodState extends State<Food4> {

  TextEditingController nameController = TextEditingController();
  TextEditingController? _itemImageUrlController;

  List<Map<String, dynamic>> _jsonData = [];

  @override
  void initState() {
    super.initState();
    _itemImageUrlController = TextEditingController(text: 'https://cdn-icons-png.flaticon.com/512/2553/2553691.png');

    _fetchData();
  }

  Future<void> _fetchData() async {
    final response = await http.get(Uri.parse(
        'https://raw.githubusercontent.com/melmorsy2010/Retailtribebuffet/main/food66.json'));

    if (response.statusCode == 200) {
      setState(() {
        _jsonData = List<Map<String, dynamic>>.from(
            json.decode(response.body) as List<dynamic>);
        print(response.body);
      });
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<void> _updateData() async {
    // Check if there is a Scaffold widget in the widget tree
    if (ScaffoldMessenger.of(context).mounted) {
      final String updateDataEndpoint = 'http://localhost:3000/updateData';
      final String token = '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';
      final String username = 'melmorsy2010';
      final String repository = 'Retailtribebuffet';
      final String branch = 'main';
      final String path = 'food66.json';

      // Fetch the existing file's metadata, including its sha value
      final response = await http.get(
        Uri.parse(
            'https://api.github.com/repos/$username/$repository/contents/$path'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final existingFileData = jsonDecode(response.body);
        final String sha = existingFileData['sha'];

        // Update the file on GitHub with the new data
        final bytes = utf8.encode(json.encode(_jsonData));
        final putResponse = await http.put(
          Uri.parse(
              'https://api.github.com/repos/$username/$repository/contents/$path'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json'
          },
          body: json.encode({
            'message': 'Update data',
            'content': base64.encode(bytes),
            'sha': sha
          }),
        );

        if (putResponse.statusCode == 200) {
          print('Data updated successfully');

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('تم حفظ التغييرات بنجاح'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          print('Failed to update data: ${putResponse.body}');

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('خطأ فى حفظ البيانات '),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('66 Admin panel'),
        ),
        body: SingleChildScrollView(
            child: Center(
              child: _jsonData.isEmpty
                  ? CircularProgressIndicator()
                  : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 500,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ReorderableListView.builder(
                        padding: EdgeInsets.all(16),
                        itemCount: _jsonData.length,
                        itemBuilder: (context, index) {
                          final item = _jsonData[index];
                          return Card(
                            key: ValueKey(item), // <-- required for reorderable list
                            margin: EdgeInsets.only(bottom: 16),
                            child: ListTile(
                              leading: Image.network(
                                item['image_url'],
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                              title: Text(
                                item['name'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('تأكيد الحذف'),
                                        content: Text('هل أنت متأكد من حذف المشروب؟'),
                                        actions: [
                                          TextButton(
                                            child: Text('الغاء'),
                                            onPressed: () => Navigator.of(context).pop(),
                                          ),
                                          TextButton(
                                            child: Text('تأكيد'),
                                            onPressed: () {
                                              setState(() {
                                                _jsonData.removeAt(index);
                                              });
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),

                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    final nameController = TextEditingController(text: item['name']);

                                    final imageController = TextEditingController(text: item['image_url']);

                                    return AlertDialog(
                                      title: Text('Edit Item'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextField(
                                            controller: nameController,
                                            decoration: InputDecoration(
                                              labelText: 'ٍاسم المشروب',
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                          SizedBox(height: 16),
                                          TextField(
                                            controller: imageController,
                                            decoration: InputDecoration(
                                              labelText: 'رابط الصوره',
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                          SizedBox(height: 16),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Cancel'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            final updatedItem = {
                                              'name': nameController.text,
                                              'image_url': imageController.text,
                                            };

                                            setState(() {
                                              _jsonData[index] = updatedItem;
                                            });

                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Save'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        },
                        onReorder: (oldIndex, newIndex) {
                          setState(() {
                            if (newIndex > oldIndex) {
                              newIndex -= 1;
                            }
                            final item = _jsonData.removeAt(oldIndex);
                            _jsonData.insert(newIndex, item);
                          });
                        },
                      )
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: _updateData,
                            child: Text('حفظ التغييرات'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Drawer(
                                    elevation: 10.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16.0),
                                        topRight: Radius.circular(16.0),
                                      ),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(16),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextFormField(
                                            controller: nameController,
                                            decoration: InputDecoration(
                                              labelText: 'اسم الطعام',
                                              border: OutlineInputBorder(),
                                              fillColor: Colors.white,
                                              filled: true,
                                              contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                                            ),
                                          ),
                                          SizedBox(height: 16),
                                          TextFormField(
                                            controller: _itemImageUrlController,
                                            decoration: InputDecoration(
                                              labelText: 'رابط الصوره',
                                              border: OutlineInputBorder(),
                                              fillColor: Colors.white,
                                              filled: true,
                                              contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                                            ),
                                          ),
                                          SizedBox(height: 16),
                                          ElevatedButton(
                                            onPressed: () {
                                              final itemName = nameController.text;
                                              final itemImageUrl = _itemImageUrlController?.text;

                                              if (itemName.isNotEmpty && itemImageUrl?.isNotEmpty == true) {
                                                setState(() {
                                                  _jsonData.add({
                                                    'name': itemName,
                                                    'image_url': itemImageUrl!,
                                                  });
                                                });

                                                nameController.clear();
                                                _itemImageUrlController?.clear();

                                                Navigator.of(context).pop();
                                              } else {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: Text('Please fill in the required fields.'),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                              }
                                            },
                                            child: Text('اضافة المشروب'),
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.blue,
                                              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                                              textStyle: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },

                            child: Text('اضافة طعام جديد'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              textStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),




                  ],
                ),

              ),
            )
        )
    );


  }
}
