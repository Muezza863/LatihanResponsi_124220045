import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatelessWidget {
  final int id;
  final String menu;

  DetailPage({required this.id, required this.menu});

  Future<Map<String, dynamic>> fetchDetail() async {
    // Membentuk URL berdasarkan menu dan id
    String url = 'https://api.spaceflightnewsapi.net/v4/${menu}/${id}/';
    print('Fetching URL: $url');
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Parsing JSON response
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to fetch data. HTTP Status Code: ${response.statusCode}');
      }
    } catch (e) {
      // Menangkap error saat fetch data
      throw Exception('Error while fetching detail: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Page'
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchDetail(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error occurred:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    snapshot.error.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.red),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Go Back'),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          } else {
            final data = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Gambar
                  if (data['image_url'] != null && data['image_url'] is String)
                    Image.network(
                      data['image_url'],
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
                  SizedBox(height: 16),
                  // Judul
                  Text(
                    data['title'] ?? 'No Title',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  // Situs Berita
                  Text(
                    'Source: ${data['news_site'] ?? 'Unknown'}',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 8),
                  // Tanggal Publikasi
                  Text(
                    'Published at: ${data['published_at'] ?? 'Unknown'}',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 16),
                  // Ringkasan
                  Text(
                    data['summary'] ?? 'No Summary Available',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  // Link ke artikel asli
                  if (data['url'] != null && data['url'] is String)


                    FloatingActionButton(
                        onPressed: () async {
                            final Uri url = Uri.parse(data['url']);
                            if (!await launchUrl(url)) {
                            throw Exception('Could not launch $url');
                            }
                          },
                      child: Text('Read Full Article'),
                    )
                    // ElevatedButton(
                    //   onPressed: () {
                    //     showDialog(
                    //       context: context,
                    //       builder: (BuildContext context) {
                    //         return AlertDialog(
                    //           content: Text("Link to article:\n${data['url']}"),
                    //         );
                    //       },
                    //     );
                    //   },
                    //   child: Text('Read Full Article'),
                    // ),
                ],
              ),
            );
          }
        },
      ),
      // floatingActionButton: Padding(
      //   padding: EdgeInsets.only(bottom: 30),
      //   child:
      //   FloatingActionButton(
      //     backgroundColor: Colors.blue[200],
      //     onPressed: () async {
      //       final Uri url = Uri.parse(data['url']);
      //       if (!await launchUrl(url)) {
      //         throw Exception('Could not launch $url');
      //       }
      //     },
      //     child: Text('Read Full Article'),
      //   ),
      // ),
    );
  }
}
