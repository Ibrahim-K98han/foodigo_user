import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/widget/custom_appbar.dart';

import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/custom_text_style.dart';

class SmsScreen extends StatefulWidget {
  const SmsScreen({super.key});

  @override
  State<SmsScreen> createState() => _SmsScreenState();
}

class _SmsScreenState extends State<SmsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Inbox',
        visibleLeading: true,
      ),
      body: Padding(
        padding: Utils.symmetric(h: 24.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(
                    color: const Color(0xffF1F5F9),
                  )),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
                leading: CustomImage(
                  path: KImages.delivery_man,
                  width: 52,
                  height: 52,
                  fit: BoxFit.cover,
                ),
                title: CustomText(
                  text: 'James Cameron ',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                subtitle: Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 14,
                    ),
                    CustomText(
                      text: '4.7 (2.5k)',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff475569),
                    ),
                  ],
                ),
                trailing: Icon(Icons.call, color: redColor),
              ),
            ),
            Utils.verticalSpace(16),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(10),
                children: const [
                  ChatBubble(
                    isSender: false,
                    message:
                        "Hello, Jr Sam! Is your AC system winter-ready?\nOur Winter AC Master Cleaning and Servicing package ensures.",
                    time: "09:00 AM",
                  ),
                  ChatBubble(
                    isSender: true,
                    message:
                        "Good morning. Yes, now I’m working on freelance projects",
                    time: "09:10 AM",
                  ),
                  ChatBubble(
                    isSender: false,
                    message: "Great! Can you send us your portfolio?",
                    time: "09:30 AM",
                  ),
                  ChatBubble(
                    isSender: true,
                    message: "Great! Can you send us your portfolio?",
                    time: "09:30 AM",
                  ),
                  ChatBubble(
                    isSender: true,
                    message: "Great! Can you send us your portfolio?",
                    time: "09:30 AM",
                  ),
                  ChatBubble(
                    isSender: false,
                    message: "Great! Can you send us your portfolio?",
                    time: "09:30 AM",
                  ),
                ],
              ),
            ),
            const ChatInputField(),
          ],
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final bool isSender;
  final String message;
  final String time;
  final List<String>? attachments;

  const ChatBubble({
    super.key,
    required this.isSender,
    required this.message,
    required this.time,
    this.attachments,
  });

  @override
  Widget build(BuildContext context) {
    final alignment =
        isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final bgColor = isSender ? Color(0xffE94222) : const Color(0xffF8FAFC);
    final textColo = isSender ? whiteColor : textColor;
    final radius = BorderRadius.only(
      topLeft: const Radius.circular(8),
      topRight: const Radius.circular(8),
      bottomLeft: Radius.circular(isSender ? 8 : 0),
      bottomRight: Radius.circular(isSender ? 0 : 8),
    );

    return Column(
      crossAxisAlignment: alignment,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          margin: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(color: bgColor, borderRadius: radius),
          child: CustomText(text: message, color: textColo),
        ),
        if (attachments != null && attachments!.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(bottom: 4),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: alignment,
              children: [
                const CustomText(text: "Attachment", fontSize: 12),
                const SizedBox(height: 4),
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: attachments!.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            attachments![index],
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        CustomText(
          text: 'Message seen at $time',
          fontSize: 10,
          color: textColor,
        ),
        const SizedBox(height: 4),
      ],
    );
  }
}

class ChatInputField extends StatelessWidget {
  const ChatInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                onChanged: (value) {},
                decoration: InputDecoration(
                  contentPadding: Utils.symmetric(h: 14.0, v: 14.0),
                  fillColor: const Color(0xffF8FAFC),
                  filled: true,
                  border: InputBorder.none,
                  // No border
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: 'Type a message ...',
                  hintStyle: const TextStyle(color: Color(0xff64748B)),
                  prefixIcon: IconButton(
                    icon: const CustomImage(
                      path: KImages.imoje,
                      width: 20,
                      height: 20,
                    ),
                    onPressed: () {},
                  ),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const CustomImage(
                          path: KImages.attach,
                          width: 20,
                          height: 20,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const CustomImage(
                          path: KImages.camera,
                          width: 20,
                          height: 20,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            Utils.horizontalSpace(10),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: Utils.all(value: 10),
                decoration: const BoxDecoration(
                  color: Color(0xffE94222),
                  shape: BoxShape.circle,
                ),
                child: const CustomImage(
                  path: KImages.send,
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
