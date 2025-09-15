import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/utils/constraints.dart';

import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/custom_text_style.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        // SliverAppBar with Banner
        SliverAppBar(
            pinned: true,
            expandedHeight: 300,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: Stack(
              fit: StackFit.loose,
              clipBehavior: Clip.none,
              children: [
                FlexibleSpaceBar(
                  background: Container(
                    color: const Color(0xff0C1321),
                  ),
                ),
                Positioned(
                  top: 90,
                  left: 10.0,
                  right: 10.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        const CustomText(
                          text: 'How can we help?',
                          fontSize: 20,
                          color: whiteColor,
                          fontWeight: FontWeight.w500,
                        ),
                        const CustomText(
                          textAlign: TextAlign.center,
                          text:
                              'Didn’t find the answer you were looking for? Contact our support center!',
                          color: whiteColor,
                        ),
                        Utils.verticalSpace(26),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.language, color: primaryColor),
                            ),
                            Utils.horizontalSpace(16),
                            const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.email, color: primaryColor),
                            ),
                            Utils.horizontalSpace(16),
                            const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.call, color: primaryColor),
                            ),
                          ],
                        ),
                        Utils.verticalSpace(26),
                        TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 15.h,
                            ),
                            hintText: 'Search...',
                            prefixIcon: const Padding(
                              padding: EdgeInsets.all(10),
                              child: CustomImage(
                                path: KImages.searchIcon,
                                color: textColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )),

        // Timeline Steps
        const SliverToBoxAdapter(child: SizedBox(height: 30)),

        SliverToBoxAdapter(
          child: Padding(
            padding: Utils.symmetric(),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Top Questions',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 14),
                const FAQTile(
                  question: "How to create a Paypay account?",
                  answer:
                      "Open the Paypay app to get started and follow the steps. Paypay doesn’t charge a fee to create or maintain your Paypay account.",
                  initiallyExpanded: true,
                ),
                const FAQTile(
                  question: "What documents do I need to submit?",
                  answer:
                      "Open the Paypay app to get started and follow the steps. Paypay doesn’t charge a fee to create or maintain your Paypay account.",
                  initiallyExpanded: true,
                ),
                const FAQTile(
                    question: "Will I be notified if I’m not selected?"),
                const FAQTile(question: "How can I prepare for the interview?"),
                const FAQTile(question: "How long does recruitment take?"),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}

class FAQTile extends StatefulWidget {
  final String question;
  final String? answer;
  final bool initiallyExpanded;

  const FAQTile({
    super.key,
    required this.question,
    this.answer,
    this.initiallyExpanded = false,
  });

  @override
  State<FAQTile> createState() => _FAQTileState();
}

class _FAQTileState extends State<FAQTile> {
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 0.h),
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent, // Remove default divider
        ),
        child: ExpansionTile(
          onExpansionChanged: (val) => setState(() => _expanded = val),
          initiallyExpanded: widget.initiallyExpanded,
          tilePadding: EdgeInsets.zero,
          title: CustomText(
            text: widget.question,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          trailing: CircleAvatar(
            backgroundColor: Color(0xffE2E8F0),
            child: Icon(
              _expanded ? Icons.remove : Icons.add,
              color: textColor,
            ),
          ),
          children: [
            if (widget.answer != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 16, 16),
                child: CustomText(
                  textAlign: TextAlign.justify,
                  text: widget.answer!,
                  color: textColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
