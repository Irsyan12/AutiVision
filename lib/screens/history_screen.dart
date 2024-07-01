import 'package:autivision/widgets/appBar.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  final List<Map<String, String>> historyData = [
    {
      'imageUrl': 'https://via.placeholder.com/150',
      'status': 'Autistic',
      'date': 'Monday, 18/9/2023',
      'probability': '72',
    },
    {
      'imageUrl': 'https://via.placeholder.com/150',
      'status': 'Non Autistic',
      'date': 'Sunday, 05/03/2023',
      'probability': '91',
    },
    {
      'imageUrl': 'https://via.placeholder.com/150',
      'status': 'Autistic',
      'date': 'Monday, 18/9/2023',
      'probability': '95',
    },
    {
      'imageUrl': 'https://via.placeholder.com/150',
      'status': 'Non Autistic',
      'date': 'Sunday, 05/03/2023',
      'probability': '88',
    },
    {
      'imageUrl': 'https://via.placeholder.com/150',
      'status': 'Autistic',
      'date': 'Monday, 18/9/2023',
      'probability': '82',
    },
    {
      'imageUrl': 'https://via.placeholder.com/150',
      'status': 'Non Autistic',
      'date': 'Sunday, 05/03/2023',
      'probability': '97',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Riwayat',
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: historyData.length,
        itemBuilder: (context, index) {
          final item = historyData[index];
          return HistoryItem(
            imageUrl: item['imageUrl']!,
            status: item['status']!,
            date: item['date']!,
            probability: item['probability']!,
          );
        },
      ),
    );
  }
}

class HistoryItem extends StatelessWidget {
  final String imageUrl;
  final String status;
  final String date;
  final String probability;

  HistoryItem({
    required this.imageUrl,
    required this.status,
    required this.date,
    required this.probability,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    IconData statusIcon;

    // Determine the status color and icon based on status
    if (status == 'Autistic') {
      statusColor = Colors.red;
      statusIcon = Icons.error_outline;
    } else if (status == 'Non Autistic') {
      statusColor = Colors.green;
      statusIcon = Icons.check_circle_outline;
    } else {
      statusColor = Colors.grey; // Default color for any other status
      statusIcon = Icons.help_outline;
    }

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
                  date,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Probability: $probability%',
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
