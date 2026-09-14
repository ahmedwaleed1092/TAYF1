import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tayf/core/routing/routs.dart';
import 'package:tayf/core/theme/app_colors.dart';
import 'package:tayf/core/theme/app_style.dart';
import 'package:tayf/fetures/chat_bot/model/chat_message.dart';
import 'package:tayf/fetures/chat_bot/view/components/chat_bubble.dart';
import 'package:tayf/fetures/chat_bot/view/components/chat_input_bar.dart';
import 'package:tayf/fetures/chat_bot/view/components/suggested_questions.dart';

class AiCopilotScreen extends StatefulWidget {
  const AiCopilotScreen({super.key});

  @override
  State<AiCopilotScreen> createState() => _AiCopilotScreenState();
}

class _AiCopilotScreenState extends State<AiCopilotScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<ChatMessage> _messages = [
    ChatMessage(
      isUser: false,
      text: 'How can I help you with your solar plant?',
      time: '9:41 AM',
    ),
    ChatMessage(
      isUser: true,
      text: 'Why is INV-04 underperforming?',
      time: '9:41 AM',
    ),
    ChatMessage(
      isUser: false,
      text:
          'INV-04 is underperforming by 18%\n'
          'The most probable cause is soiling with 86% confidence.',
      time: '9:41 AM',
      action: RecommendedAction(
        label: 'Recommended Action',
        title: 'Cleaning Now',
      ),
    ),
  ];

  final List<String> _suggestedQuestions = const [
    'What happened',
    'Why did it happen',
    'How much did we lose',
    'What should we do?',
  ];

  void _handleSend([String? text]) {
    final content = (text ?? _controller.text).trim();
    if (content.isEmpty) return;
    setState(() {
      _messages.add(ChatMessage(isUser: true, text: content, time: 'now'));
      _controller.clear();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: false,
        leading: BackButton(
          color: AppColors.chatPrimary,
          onPressed: () {
            context.pushReplacementNamed(Routs.home);
          },
        ),
        title: Text('AI Copilot', style: AppStyle.chatAppBarTitle),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ChatBubble(
                  isUser: message.isUser,
                  text: message.text,
                  time: message.time,
                  action: message.action,
                );
              },
            ),
          ),
          if (_messages.length <= 3)
            SuggestedQuestions(
              questions: _suggestedQuestions,
              onTap: _handleSend,
            ),
          ChatInputBar(controller: _controller, onSend: _handleSend),
        ],
      ),
    );
  }
}
