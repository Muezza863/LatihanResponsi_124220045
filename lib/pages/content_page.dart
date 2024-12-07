import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lat_responsi/pages/detail_page.dart';

class ContentPage extends StatelessWidget {
  final String type; 

  ContentPage({required this.type});

  Future<List<Map<String, dynamic>>> fetchData(String type) async {
    String menu = type;

    // Panggil API
    String url = 'https://api.spaceflightnewsapi.net/v4/${menu}/';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // Parsing respons JSON
      final jsonResponse = jsonDecode(response.body);

      // Ambil data dari key "results" yang berupa array
      if (jsonResponse is Map<String, dynamic> && jsonResponse.containsKey('results')) {
        return List<Map<String, dynamic>>.from(jsonResponse['results']);
      } else {
        throw Exception('Unexpected JSON structure');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(type.toUpperCase()),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchData(type),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            final items = snapshot.data!;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return GestureDetector(
                  onTap: () {
                    // Aksi saat card diklik
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                          id: item['id'],
                          menu: type,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Gambar
                        if (item['image_url'] != null)
                          Image.network(
                            item['image_url'],
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 200,
                                color: Colors.grey,
                                child: Center(
                                  child: Icon(Icons.broken_image, size: 50),
                                ),
                              );
                            },
                          ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title
                              Text(
                                item['title'] ?? 'No Title',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              // News site
                              Text(
                                'Source: ${item['news_site'] ?? 'Unknown'}',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              SizedBox(height: 4),
                              // Publish date
                              Text(
                                'Published at: ${item['published_at'] ?? 'Unknown'}',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}


