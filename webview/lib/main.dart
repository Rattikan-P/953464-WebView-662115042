import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter WebView',
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter WebView'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            print('Page started loading: $url');
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
            setState(() {
              isLoading = false;
            });
          },
          onNavigationRequest: (request) {
            if (request.url.startsWith('https://flutter.dev') ||
                request.url.startsWith('https://docs.flutter.dev')) {
              print('allowing navigation to ${request.url}');
              return NavigationDecision.navigate;
            }
            print('blocking navigation to ${request.url}');
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse("https://flutter.dev"));

    // Challenge 1: Load from asset file: 'assets/index.html'
    // _controller.loadFlutterAsset('assets/index.html');

    // Challenge 2: Load HTML from String
    // _controller.loadHtmlString('''
    // <!DOCTYPE html>
    // <html>
    // <head>
    //   <meta name="viewport" content="width=device-width, initial-scale=1.0">
    //   <style>
    //     * {
    //       margin: 0;
    //       padding: 0;
    //       box-sizing: border-box;
    //     }
    //     body {
    //       font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    //       padding: 20px;
    //       background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
    //       min-height: 100vh;
    //     }
    //     .container {
    //       max-width: 600px;
    //       margin: 20px auto;
    //       background: rgba(255, 255, 255, 0.95);
    //       padding: 35px;
    //       border-radius: 20px;
    //       box-shadow: 0 10px 40px rgba(0,0,0,0.3);
    //       backdrop-filter: blur(10px);
    //     }
    //     .badge {
    //       display: inline-block;
    //       background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
    //       color: white;
    //       padding: 6px 16px;
    //       border-radius: 20px;
    //       font-size: 11px;
    //       font-weight: bold;
    //       letter-spacing: 1px;
    //       text-transform: uppercase;
    //       box-shadow: 0 4px 15px rgba(79, 172, 254, 0.4);
    //     }
    //     h1 {
    //       background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
    //       -webkit-background-clip: text;
    //       -webkit-text-fill-color: transparent;
    //       background-clip: text;
    //       font-size: 32px;
    //       margin: 15px 0 10px 0;
    //       font-weight: bold;
    //     }
    //     h2 {
    //       color: #333;
    //       font-size: 20px;
    //       margin-top: 25px;
    //       display: flex;
    //       align-items: center;
    //       gap: 8px;
    //     }
    //     p {
    //       line-height: 1.8;
    //       color: #555;
    //       margin: 10px 0;
    //     }
    //     .box {
    //       background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);
    //       padding: 20px;
    //       border-radius: 12px;
    //       margin: 20px 0;
    //       box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    //     }
    //     .box strong {
    //       color: #0288d1;
    //       font-size: 16px;
    //       display: block;
    //       margin-bottom: 12px;
    //     }
    //     ul {
    //       margin: 10px 0;
    //       padding-left: 20px;
    //     }
    //     li {
    //       margin: 10px 0;
    //       color: #555;
    //       position: relative;
    //     }
    //     li::marker {
    //       color: #4facfe;
    //     }
    //     code {
    //       background: linear-gradient(135deg, #4facfe15 0%, #00f2fe15 100%);
    //       padding: 4px 10px;
    //       border-radius: 6px;
    //       color: #0288d1;
    //       font-family: 'Courier New', monospace;
    //       font-weight: bold;
    //       border: 1px solid #4facfe30;
    //     }

    //     .footer {
    //       text-align: center;
    //       margin-top: 30px;
    //       padding-top: 20px;
    //       border-top: 2px solid #f0f0f0;
    //       color: #999;
    //       font-size: 12px;
    //     }
    //   </style>
    // </head>
    // <body>
    //   <div class="container">
    //     <span class="badge">💻 challenge 2</span>
    //     <h1>HTML String Method</h1>
    //     <p>This content is loaded from a <code>String</code> in Dart code</p>

    //     <h2>⚡ loadHtmlString() Method</h2>
    //     <p>This method loads HTML directly from a string variable. No separate file needed - perfect for dynamic content!</p>

    //     <div class="box">
    //       <strong>✅ Best Use Cases</strong>
    //       <ul>
    //         <li>Dynamically generated HTML</li>
    //         <li>Simple, short content</li>
    //         <li>Quick prototyping & testing</li>
    //       </ul>
    //     </div>

    //     <p style="color: #999; font-size: 14px; text-align: center; margin-top: 20px;">
    //       <em>💡 WebView supports HTML, CSS & JavaScript</em>
    //     </p>

    //     <div class="footer">
    //       Flutter WebView Tutorial
    //     </div>
    //   </div>
    // </body>
    // </html>
    // ''');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Webview Navigation & Events"),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              if (await _controller.canGoBack()) {
                _controller.goBack();
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () async {
              if (await _controller.canGoForward()) {
                _controller.goForward();
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async {
              _controller.reload();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          isLoading
              ? Container(
                  color: Colors.black.withOpacity(0.3),
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.deepPurple),
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
