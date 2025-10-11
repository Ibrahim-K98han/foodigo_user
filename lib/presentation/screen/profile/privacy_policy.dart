import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:foodigo/features/Privacy/cubit/privacy_policy_cubit.dart';
import 'package:foodigo/features/Privacy/cubit/privacy_policy_state.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/fetch_error_text.dart';
import 'package:foodigo/widget/loading_widget.dart';

import '../../../../utils/utils.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  late PrivacyPolicyCubit ppCubit;
  @override
  void initState() {
    super.initState();
    ppCubit = context.read<PrivacyPolicyCubit>();
    ppCubit.fetchPrivacyPolicy();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Privacy Policy'),
      body: BlocConsumer<PrivacyPolicyCubit, PrivacyPolicyState>(
        listener: (context, state) {
          if (state is PrivacyPolicyError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is PrivacyPolicyLoading) {
            return const LoadingWidget();
          } else if (state is PrivacyPolicyError) {
            return const FetchErrorText(text: 'Something went wrong');
          } else if (state is PrivacyPolicyLoaded) {
            return Padding(
              padding: Utils.symmetric(h: 20, v: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [HtmlWidget(state.privacyPolicy.description)],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
