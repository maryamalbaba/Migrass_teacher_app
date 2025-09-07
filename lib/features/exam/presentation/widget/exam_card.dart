import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExamCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ExamCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: onTap,
      ),
    );
  }
}