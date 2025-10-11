import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:foodigo/features/Privacy/cubit/privacy_policy_cubit.dart';
import 'package:foodigo/features/Privacy/cubit/privacy_policy_state.dart';
import 'package:foodigo/utils/utils.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/loading_widget.dart';

class TermsAndConditionScreen extends StatefulWidget {
  const TermsAndConditionScreen({super.key});

  @override
  State<TermsAndConditionScreen> createState() =>
      _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {
  late PrivacyPolicyCubit ppCubit;
  @override
  void initState() {
    super.initState();
    ppCubit = context.read<PrivacyPolicyCubit>();
    ppCubit.fetchTermsAndCondition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Terms and Condition'),
      body: BlocConsumer<PrivacyPolicyCubit, PrivacyPolicyState>(
        listener: (context, state) {
          if (state is TermsAndConditionError) {
            Utils.errorSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is TermsAndConditionLoading) {
            return const LoadingWidget();
          } else if (state is TermsAndConditionLoaded) {
            return Padding(
              padding: Utils.symmetric(h: 20, v: 10),
              child: SingleChildScrollView(
                child: Column(children: [HtmlWidget(state.model.description)]),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
