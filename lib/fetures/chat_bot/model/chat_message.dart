import 'package:flutter/material.dart';

class ChatMessage {
  final bool isUser;
  final String text;
  final String time;
  final RecommendedAction? action;

  ChatMessage({
    required this.isUser,
    required this.text,
    required this.time,
    this.action,
  });
}

class RecommendedAction {
  final String label;
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  RecommendedAction({
    required this.label,
    required this.title,
    this.icon = Icons.eco_outlined,
    this.onTap,
  });
}
