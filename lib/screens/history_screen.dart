import 'package:autivision/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:autivision/services/history_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:autivision/providers/auth_provider.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatelessWidget {
  final HistoryService _historyService = HistoryService();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userId = authProvider.userId;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Riwayat',
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _historyService.loadHistory(userId: userId!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
            return Center(child: Text('Error loading history'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            print('No history available');
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.network(
                    'https://firebasestorage.googleapis.com/v0/b/autivision-c1daf.appspot.com/o/no_history_data.svg?alt=media&token=8baac719-0ac5-4128-aaef-3349a2737861',
                    width: 200,
                    height: 200,
                  ),
                  Text('Tidak ada riwayat data'),
                ],
              ),
            );
          } else {
            final historyData = snapshot.data!;
            return ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: historyData.length,
              itemBuilder: (context, index) {
                final item = historyData[index];
                return HistoryItem(
                  imageUrl: item['imageUrl']!,
                  status: item['classification']!,
                  date: item['timestamp'].toDate(),
                  confidence: item['confidence'],
                );
              },
            );
          }
        },
      ),
    );
  }
}

class HistoryItem extends StatelessWidget {
  final String imageUrl;
  final String status;
  final DateTime date;
  final double confidence;

  HistoryItem({
    required this.imageUrl,
    required this.status,
    required this.date,
    required this.confidence,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    IconData statusIcon;

    // Tentukan warna status dan ikon berdasarkan status
    if (status == 'Autistic') {
      statusColor = Colors.red;
      statusIcon = Icons.error_outline;
    } else if (status == 'Non Autistic') {
      statusColor = Colors.green;
      statusIcon = Icons.check_circle_outline;
    } else {
      statusColor = Colors.grey; // Warna default untuk status lainnya
      statusIcon = Icons.help_outline;
    }

    // Format tanggal
    final dateFormat = DateFormat('EEEE, dd/MM/yyyy', 'id');
    final formattedDate = dateFormat.format(date);

    // Format confidence
    final formattedConfidence = '${(confidence * 100).toStringAsFixed(0)}%';

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(imageUrl),
                radius: 30,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  backgroundColor: statusColor,
                  radius: 10,
                  child: Icon(
                    statusIcon,
                    size: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  formattedDate,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Confidence: $formattedConfidence',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
