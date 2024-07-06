import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatefulWidget {
  final String teacher_id;
  final int resultDate;
  final int resultYear;
  const WebviewPage(this.teacher_id, this.resultDate, this.resultYear,
      {Key? key})
      : super(key: key);

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(
          "https://misreg.csc.ku.ac.th/schedule_v2/getTable_v2.php?teacher_id=${widget.teacher_id}&&sm=${widget.resultDate}&yr=${widget.resultYear}"));
    print(widget.teacher_id);
    print(widget.resultDate);
    print(widget.resultYear);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ย้อนกลับ",
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              if (await controller.canGoBack()) {
                controller.goBack();
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () async {
              if (await controller.canGoForward()) {
                controller.goForward();
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              controller.reload();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
        ],
      ),
    );
  }
}
