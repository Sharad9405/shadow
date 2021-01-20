import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shadow/config/config.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({Key key}) : super(key: key);

  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> with TickerProviderStateMixin {
  AnimationController animationController;
  final Completer<WebViewController> _webViewController = Completer<WebViewController>();

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    super.initState();
    if(Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
  // padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.white,
        body: Padding(
          padding: EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              _appBar(),

              Expanded(
                child: Stack(
                  children: [
                    _setUpWebView(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child:  Padding(
                        padding: EdgeInsets.only(bottom: 20,right: 20),
                        child: _favoriteButton(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _favoriteButton(){
    return FutureBuilder<WebViewController>(
          future: _webViewController.future,
      builder: (BuildContext context, AsyncSnapshot<WebViewController> controller){
            if(controller.hasData){
              return FloatingActionButton(
                onPressed: () async {
                  final String url = await controller.data.currentUrl();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Favorited $url'),));
                },
                child: const Icon(Icons.favorite),
              );
            }
            return Container();
      },
    );
  }

  _setUpWebView(){
    return Container(
      child: Builder(builder: (BuildContext context){
        return WebView(
          initialUrl: 'https://flutter.dev',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController){
            _webViewController.complete(webViewController);
          },
          // TODO(iskakaushik): Remove this when collection literals makes it to stable.
          // ignore: prefer_collection_literals

          javascriptChannels: <JavascriptChannel>[
            _toasterJavaScriptChannel(context)
          ].toSet(),

          // these will help to detect gesture for map only start
          gestureRecognizers: {
            Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer(),
            ),
          },


          navigationDelegate: (NavigationRequest request){
            if(request.url.startsWith('https://www.youtube.com/')){
              print('blocking navigation to $request');
              return NavigationDecision.prevent;
            }
            print('Allowing navigation to $request');
            return NavigationDecision.navigate;
        },

          onPageStarted: (String url){
            print('Page started loading.... $url');
          },

          onPageFinished: (String url){
            print('Page finished loading ... $url');
          },

          gestureNavigationEnabled: true,
        );
      }),
    );
  }

  JavascriptChannel _toasterJavaScriptChannel(BuildContext context){
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message){
        // ignore: deprecated_member_use
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(message.message),
          ));
          print('JavascriptChannel => onMessageReceived() => ${message.message}');
        }
    );
  }

  Widget _appBar() {
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  AppConstant.Faq,
                  style: TextStyle(
                    fontSize: 22,
                    color: AppTheme.darkText,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
