import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:foodigo/widget/custom_text_style.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../data/remote_url.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';

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

  late WebViewController controllerGlobal;

  @override
  void initState() {
    controllerGlobal = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..enableZoom(true)
      ..setBackgroundColor(scaffoldBgColor)
      ..loadRequest(Uri.parse(widget.url))
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (int progress) {
          setState(() {
            value = progress / 100;
          });
          log("WebView is loading (progress : $progress%)");
        },
        onPageStarted: (String url) {
          log('Page started loading: $url');
          setState(() {
            _isLoading = true;
          });
          log("printing urls $url");
          _redirect(url);
        },
        onPageFinished: (String url) {
          log('Page finished loading: $url');
          setState(() {
            _isLoading = false;
          });
          _redirect(url);
        },
      ));
    super.initState();
  }

  @override
  void dispose() {
    // controllerGlobal.loadRequest(request)
    controllerGlobal.loadRequest(Uri.parse('about:blank'));
    // controllerGlobal.goBack();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const CustomText(text: 'Strip Payment'),
          elevation: 0.5,
          leading: IconButton(
            icon: Icon(Platform.isAndroid
                ? Icons.arrow_back
                : Icons.arrow_back_ios_new),
            onPressed: () => _exitApp(context),
          ),
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            if (_isLoading)
              Center(
                child: LinearProgressIndicator(
                  value: value,
                ),
              ),
            Expanded(
              child: WebViewWidget(controller: controllerGlobal),
            )
          ],
        ),
      ),
    );
  }

  void _redirect(String url) {
    print("Url: $url");
    if (_canRedirect) {
      bool isSuccess = url.contains('/webview-success-payment') &&
          url.contains(RemoteUrls.rootUrl);
      bool isFailed = url.contains('webview-payment-faild') &&
          url.contains(RemoteUrls.rootUrl);
      bool isCancel = url.contains('/webview-schedule-not-available') &&
          url.contains(RemoteUrls.rootUrl);
      if (isSuccess || isFailed || isCancel) {
        _canRedirect = false;
      }
      if (isSuccess) {
        getData();
      } else if (isCancel) {
        Utils.errorSnackBar(context,
            'This schedule already booked. please choose another schedule');
        Navigator.pop(context);
        return;
      } else if (isFailed) {
        Utils.errorSnackBar(context, 'Payment Failed');
        Navigator.pop(context);
      } else {
        log("Encountered problem");
      }
    }
  }

  void getData() {
    controllerGlobal
        .runJavaScriptReturningResult("document.body.innerText")
        .then(
      (data) {
        String decodedJSON = "";
        if (Platform.isAndroid) {
          decodedJSON = jsonDecode(data as String) as String;
        } else {
          decodedJSON = data as String;
        }

        var responseJSON = jsonDecode(decodedJSON);
        log(decodedJSON, name: 'MolliePaymentScreen');
        if (responseJSON["result"] == false) {
          Utils.errorSnackBar(context, responseJSON["message"]);
        } else if (responseJSON["result"] == true) {
          Utils.showSnackBar(context, responseJSON["message"]);
        }
        // context.read<DashBoardProfileCubit>().clearDashBoard();
        // context.read<DashBoardProfileCubit>().getDashBoard();
        // Navigator.pushNamedAndRemoveUntil(context, RouteNames.mainScreen,
        //     arguments: 'success', (route) {
        //       if (route.settings.name == RouteNames.mainScreen) {
        //         return true;
        //       }
        //       return false;
        //     });
        // PaymenSuccessDialog.dialog(context, responseJSON["message"]);
      },
    );
  }

  Future<bool> _exitApp(BuildContext context) async {
    if (await controllerGlobal.canGoBack()) {
      controllerGlobal.goBack();
      return Future.value(false);
    } else {
      return true;
    }
  }
}
