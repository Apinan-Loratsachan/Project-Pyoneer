import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:highlight/languages/python.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pyoneer/utils/color.dart';
import 'package:http/http.dart' as http;
import 'package:pyoneer/utils/log.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IDEScreen extends StatefulWidget {
  const IDEScreen({super.key});

  @override
  State<IDEScreen> createState() => _IDEScreenState();
}

class _IDEScreenState extends State<IDEScreen>
    with AutomaticKeepAliveClientMixin {
  final controller = CodeController(
    text:
        '# เขียน Code ที่นี่เลย\n# ข้อจำกัด ไม่สามารถรับ Input ได้\n# สามารถใช้งานได้แค่ Built-in Module\n\nimport random\n\nnumber = random.randint(1,100)\nprint("ตัวเลขที่สุ่มได้คือ :", number)',
    language: python,
  );

  static Future<void> saveUserCode(String string) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('code', string);
    } catch (e) {
      PyoneerLog.red(e.toString());
    }
  }

  static Future<String> getUserCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('code') ??
        '# เขียน Code ที่นี่เลย\n# ข้อจำกัด ไม่สามารถรับ Input ได้\n# สามารถใช้งานได้แค่ Built-in Module\n\nimport random\n\nnumber = random.randint(1,100)\nprint("ตัวเลขที่สุ่มได้คือ :", number)';
  }

  bool isError = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getUserCode().then((value) {
      controller.text = value;
    });
  }

  String _output = 'ข้อความจาก PY৹NEER : ยังไม่ได้ execute';

  @override
  bool get wantKeepAlive => true;
  final _focusNode = FocusNode();

  Future<void> _runCode() async {
    setState(() {
      _isLoading = true;
    });
    final code = controller.text;
    const apiUrl = 'https://Kantz.pythonanywhere.com/run_code';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'code': code}),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final output = jsonResponse['output'];
      final error = jsonResponse['error'];

      setState(() {
        if (error != null) {
          _output =
              'ข้อความจาก PY৹NEER : พบ ERROR ต่อไปนี้\n------------------------------------------------------\n$error';
          isError = true;
        } else {
          _output = '$output';
          isError = false;
        }
        _isLoading = false;
      });
    } else {
      setState(() {
        _output = 'HTTP Error: ${response.statusCode}';
        isError = true;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/icons/python.png", height: 30),
              const SizedBox(width: 15),
              const Text(
                "Python IDE",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ).animate(
            onPlay: (controller) => controller.repeat(),
            effects: [
              const ShimmerEffect(
                delay: Duration(milliseconds: 500),
                duration: Duration(milliseconds: 1000),
                color: Colors.amber,
              ),
              const ShimmerEffect(
                delay: Duration(milliseconds: 700),
                duration: Duration(milliseconds: 1000),
                color: Colors.blue,
              ),
            ],
          ),
          leading: IgnorePointer(
            child: SizedBox(
              width: 60,
              child: IconButton(
                color: Colors.transparent,
                iconSize: 40,
                icon: const Icon(Icons.play_circle_fill),
                onPressed: () {},
              ),
            ),
          ),
          actions: [
            SizedBox(
              width: 60,
              child: Center(
                child: _isLoading
                    ? LoadingAnimationWidget.beat(
                        color: AppColor.primarSnakeColor,
                        size: 30,
                      )
                    : IconButton(
                        iconSize: 40,
                        icon: const Icon(Icons.play_circle_fill),
                        onPressed: _runCode,
                      ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    color: AppColor.ideColor,
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: SingleChildScrollView(
                      child: CodeTheme(
                        data: CodeThemeData(styles: monokaiSublimeTheme),
                        child: CodeField(
                          focusNode: _focusNode,
                          wrap: true,
                          controller: controller,
                          gutterStyle: const GutterStyle(
                              textStyle: TextStyle(
                            height: 1.55,
                            fontSize: 10,
                          )),
                          textStyle: const TextStyle(fontSize: 16),
                          onChanged: (codeString) => saveUserCode(codeString),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Stack(
              children: [
                const SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Output",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Tooltip(
                        message: "คัดลอก Output",
                        child: IconButton(
                          icon: const Icon(Icons.copy),
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: _output));
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: double.infinity,
                    color: AppColor.ideColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Text(
                          _output,
                          style: TextStyle(
                            fontSize: 16,
                            color: isError ? Colors.red : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
