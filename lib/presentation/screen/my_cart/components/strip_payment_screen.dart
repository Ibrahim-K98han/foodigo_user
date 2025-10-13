// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:foodigo/features/Login/bloc/login_bloc.dart';
// import 'package:foodigo/widget/custom_text_style.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// import '../../../../data/remote_url.dart';
// import '../../../../utils/constraints.dart';
// import '../../../../utils/utils.dart';
// import '../../../core/routes/route_names.dart';
//
// class StripPaymentScreen extends StatefulWidget {
//   const StripPaymentScreen({super.key, required this.url});
//
//   final String url;
//
//   @override
//   State<StripPaymentScreen> createState() => _StripPaymentScreenState();
// }
//
// class _StripPaymentScreenState extends State<StripPaymentScreen> {
//   double value = 0.0;
//
//   bool _canRedirect = true;
//
//   bool _isLoading = true;
//
//   late WebViewController controllerGlobal;
//
//   late LoginBloc loginBloc;
//
//   // @override
//   // void initState() {
//   //   loginBloc = context.read<LoginBloc>();
//   //   controllerGlobal = WebViewController()
//   //     ..setJavaScriptMode(JavaScriptMode.unrestricted)
//   //     ..enableZoom(true)
//   //     ..setBackgroundColor(scaffoldBgColor)
//   //     ..loadRequest(
//   //       Uri.parse(widget.url),
//   //       headers: {
//   //         'Authorization': 'Bearer ${loginBloc.userInformation!.token}',
//   //         'Content-Type': 'application/json',
//   //         'Accept': 'application/json',
//   //       },
//   //     )
//   //     ..setNavigationDelegate(NavigationDelegate(
//   //       onProgress: (int progress) {
//   //         setState(() {
//   //           value = progress / 100;
//   //         });
//   //         log("WebView is loading (progress : $progress%)");
//   //       },
//   //       onPageStarted: (String url) {
//   //         log('Page started loading: $url');
//   //         setState(() {
//   //           _isLoading = true;
//   //         });
//   //         log("printing urls $url");
//   //         _redirect(url);
//   //       },
//   //       onPageFinished: (String url) {
//   //         log('Page finished loading: $url');
//   //         setState(() {
//   //           _isLoading = false;
//   //         });
//   //         _redirect(url);
//   //       },
//   //     ));
//   //   super.initState();
//   // }
//
//
//   @override
//   void initState() {
//     super.initState();
//
//
//     loginBloc = context.read<LoginBloc>();
//
//     _loadStripeCheckoutUrl();
//   }
//
//
//   @override
//   void dispose() {
//     // controllerGlobal.loadRequest(request)
//     controllerGlobal.loadRequest(Uri.parse('about:blank'));
//     // controllerGlobal.goBack();
//     super.dispose();
//   }
//
//   Future<void> _loadStripeCheckoutUrl() async {
//     try {
//       // 1️⃣ API request
//       final response = await HttpClient()
//           .getUrl(Uri.parse(widget.url))
//           .then((req) {
//         req.headers.set(
//             'Authorization', 'Bearer ${loginBloc.userInformation!.token}');
//         req.headers.set('Accept', 'application/json');
//         return req.close();
//       });
//
//       final body = await response.transform(utf8.decoder).join();
//       final json = jsonDecode(body);
//
//       // 2️⃣ Checkout URL extract করো
//       final checkoutUrl = json['data']['checkout_url'];
//       log('✅ Stripe Checkout URL: $checkoutUrl');
//
//       // 3️⃣ এখন ওই URL WebView-তে লোড করো
//       controllerGlobal = WebViewController()
//         ..setJavaScriptMode(JavaScriptMode.unrestricted)
//         ..enableZoom(true)
//         ..setBackgroundColor(Colors.white)
//         ..loadRequest(Uri.parse(checkoutUrl))
//         ..setNavigationDelegate(NavigationDelegate(
//           onProgress: (progress) {
//             setState(() => value = progress / 100);
//           },
//           onPageStarted: (url) {
//             setState(() => _isLoading = true);
//             _redirect(url);
//           },
//           onPageFinished: (url) {
//             setState(() => _isLoading = false);
//             _redirect(url);
//           },
//         ));
//
//       setState(() {}); // UI refresh
//     } catch (e, st) {
//       log('❌ Error loading Stripe checkout: $e\n$st');
//       Utils.errorSnackBar(context, 'Failed to load Stripe Checkout');
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () => _exitApp(context),
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           title: const CustomText(text: 'Strip Payment'),
//           elevation: 0.5,
//           leading: IconButton(
//             icon: Icon(Platform.isAndroid
//                 ? Icons.arrow_back
//                 : Icons.arrow_back_ios_new),
//             onPressed: () => _exitApp(context),
//           ),
//           backgroundColor: Colors.white,
//         ),
//         body: Column(
//           children: [
//             if (_isLoading)
//               Center(
//                 child: LinearProgressIndicator(
//                   value: value,
//                 ),
//               ),
//             Expanded(
//               child: WebViewWidget(controller: controllerGlobal),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _redirect(String url) {
//     print("Url: $url");
//     if (_canRedirect) {
//       bool isSuccess = url.contains('/webview-stripe-success') &&
//           url.contains(RemoteUrls.paymentUrl);
//       bool isFailed = url.contains('webview-payment-faild') &&
//           url.contains(RemoteUrls.rootUrl);
//       bool isCancel = url.contains('/webview-schedule-not-available') &&
//           url.contains(RemoteUrls.rootUrl);
//       if (isSuccess || isFailed || isCancel) {
//         _canRedirect = false;
//       }
//       if (isSuccess) {
//         getData();
//       } else if (isCancel) {
//         Utils.errorSnackBar(context,
//             'This schedule already booked. please choose another schedule');
//         Navigator.pop(context);
//         return;
//       } else if (isFailed) {
//         Utils.errorSnackBar(context, 'Payment Failed');
//         Navigator.pop(context);
//       } else {
//         log("Encountered problem");
//       }
//     }
//   }
//
//   void getData() {
//     controllerGlobal
//         .runJavaScriptReturningResult("document.body.innerText")
//         .then(
//       (data) {
//         String decodedJSON = "";
//         if (Platform.isAndroid) {
//           decodedJSON = jsonDecode(data as String) as String;
//         } else {
//           decodedJSON = data as String;
//         }
//
//         var responseJSON = jsonDecode(decodedJSON);
//         // log(decodedJSON, name: 'MolliePaymentScreen');
//         // if (responseJSON["result"] == false) {
//         //   Utils.errorSnackBar(context, responseJSON["message"]);
//         // } else if (responseJSON["result"] == true) {
//         //   Utils.showSnackBar(context, responseJSON["message"]);
//         // }
//         // context.read<DashBoardProfileCubit>().clearDashBoard();
//         // context.read<DashBoardProfileCubit>().getDashBoard();
//         Navigator.pushNamedAndRemoveUntil(context, RouteNames.mainScreen,
//             arguments: 'success', (route) {
//           if (route.settings.name == RouteNames.mainScreen) {
//             return true;
//           }
//           return false;
//         });
//         Utils.showSnackBar(context, responseJSON["message"]);
//       },
//     );
//   }
//
//   Future<bool> _exitApp(BuildContext context) async {
//     if (await controllerGlobal.canGoBack()) {
//       controllerGlobal.goBack();
//       return Future.value(false);
//     } else {
//       return true;
//     }
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/Login/bloc/login_bloc.dart';
import 'package:foodigo/widget/custom_text_style.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../data/remote_url.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';
import '../../../core/routes/route_names.dart';

class StripPaymentScreen extends StatefulWidget {
  const StripPaymentScreen({super.key, required this.url});

  final String url;

  @override
  State<StripPaymentScreen> createState() => _StripPaymentScreenState();
}

class _StripPaymentScreenState extends State<StripPaymentScreen> {
  double value = 0.0;
  bool _canRedirect = true;
  bool _isLoading = true;

  WebViewController? controllerGlobal; // ✅ made nullable
  late LoginBloc loginBloc;

  @override
  void initState() {
    super.initState();
    loginBloc = context.read<LoginBloc>();
    _loadStripeCheckoutUrl();
  }

  @override
  void dispose() {
    controllerGlobal?.loadRequest(Uri.parse('about:blank')); // ✅ safe call
    super.dispose();
  }

  /// 🔹 Load Stripe Checkout Page
  Future<void> _loadStripeCheckoutUrl() async {
    try {
      final response = await HttpClient().getUrl(Uri.parse(widget.url)).then((req) {
        req.headers.set('Authorization', 'Bearer ${loginBloc.userInformation!.token}');
        req.headers.set('Accept', 'application/json');
        return req.close();
      });

      final body = await response.transform(utf8.decoder).join();
      final jsonData = jsonDecode(body);

      final checkoutUrl = jsonData['data']['checkout_url'];
      log('✅ Stripe Checkout URL: $checkoutUrl');

      final controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..enableZoom(true)
        ..setBackgroundColor(Colors.white)
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (progress) => setState(() => value = progress / 100),
            onPageStarted: (url) {
              setState(() => _isLoading = true);
              _redirect(url);
            },
            onPageFinished: (url) {
              setState(() => _isLoading = false);
              _redirect(url);
            },
            onWebResourceError: (error) {
              log('❌ WebView Error: ${error.description}');
              Utils.errorSnackBar(context, 'WebView error occurred.');
            },
          ),
        )
        ..loadRequest(Uri.parse(checkoutUrl));

      setState(() => controllerGlobal = controller); // ✅ controller assign
    } catch (e, st) {
      log('❌ Error loading Stripe checkout: $e\n$st');
      Utils.errorSnackBar(context, 'Failed to load Stripe Checkout');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const CustomText(text: 'Stripe Payment'),
          elevation: 0.5,
          leading: IconButton(
            icon: Icon(Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios_new),
            onPressed: () => _exitApp(context),
          ),
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            if (_isLoading)
              LinearProgressIndicator(
                value: value,
                backgroundColor: Colors.grey.shade200,
              ),
            Expanded(
              child: controllerGlobal == null
                  ? const Center(child: CircularProgressIndicator())
                  : WebViewWidget(controller: controllerGlobal!), // ✅ safe unwrap
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Detect Redirect (Success / Fail / Cancel)
  void _redirect(String url) {
    log("🌐 Current URL: $url");

    if (!_canRedirect) return;

    final isSuccess = url.contains('stripe-success') || url.contains('success');
    final isFailed = url.contains('stripe-failed') || url.contains('fail');
    final isCancel = url.contains('schedule-not-available') || url.contains('cancel');

    if (isSuccess || isFailed || isCancel) {
      _canRedirect = false;
    }

    if (isSuccess) {
      log('✅ Stripe Payment Success detected!');
      _handleSuccess();
    } else if (isCancel) {
      Utils.errorSnackBar(context, 'This schedule is already booked. Please choose another.');
      Navigator.pop(context);
    } else if (isFailed) {
      Utils.errorSnackBar(context, 'Payment Failed');
      Navigator.pop(context);
    }
  }

  /// 🔹 Handle Success (Fetch Result + Navigate)
  Future<void> _handleSuccess() async {
    try {
      final data = await controllerGlobal?.runJavaScriptReturningResult("document.body.innerText");
      if (data == null) return;

      String decodedJSON = Platform.isAndroid ? jsonDecode(data as String) as String : data as String;
      final responseJSON = jsonDecode(decodedJSON);

      if (mounted) {
        Utils.showSnackBar(context, responseJSON["message"] ?? 'Payment Successful');
        Navigator.of(context).pushNamedAndRemoveUntil(
          RouteNames.mainScreen,
              (route) => false,
          arguments: 'success',
        );
      }
    } catch (e, st) {
      log('⚠️ Error parsing Stripe success data: $e\n$st');
      if (mounted) {
        Utils.showSnackBar(context, 'Payment Successful!');
        Navigator.of(context).pushNamedAndRemoveUntil(
          RouteNames.mainScreen,
              (route) => false,
          arguments: 'success',
        );
      }
    }
  }

  /// 🔹 Handle Back Button
  Future<bool> _exitApp(BuildContext context) async {
    if (await controllerGlobal?.canGoBack() ?? false) {
      controllerGlobal?.goBack();
      return Future.value(false);
    } else {
      return true;
    }
  }
}
