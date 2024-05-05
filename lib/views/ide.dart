import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:highlight/languages/python.dart';
import 'package:icons_plus/icons_plus.dart';
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
                child: IconButton(
                  iconSize: 30,
                  icon: const Icon(FontAwesome.circle_question_solid),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('เกี่ยวกับ IDE'),
                              IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: const Icon(Icons.cancel))
                            ],
                          ),
                          content: const SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "ข้อจำกัด ",
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    "- ไม่สามารถรับ Input ได้\n- สามารถใช้งานได้แค่ Built-in Module ที่มีอยู่ใน Python\n- auto complete ต้องกด enter ในคีย์บอร์ดเท่านั้น\n\n สร้างโดย PY৹NEER")
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                child: Container(
                  color: AppColor.ideColor,
                  // height: MediaQuery.of(context).size.height * 0.35,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xFF1E1E1E),
                                width: 2,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Text(
                                  'Editor',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Tooltip(
                                message: 'Excute Code',
                                child: _isLoading
                                    ? Padding(
                                        padding: const EdgeInsets.all(9.0),
                                        child: LoadingAnimationWidget.beat(
                                          color: AppColor.primarSnakeColor,
                                          size: 30,
                                        ),
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          _runCode();
                                        },
                                        icon: const Icon(Bootstrap.play_circle),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .background,
                                          elevation: 0,
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  child: Container(
                    color: AppColor.ideColor,
                    height: MediaQuery.of(context).size.height * 0.30,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CodeTheme(
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
                              onChanged: (codeString) =>
                                  saveUserCode(codeString),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.33,
                    width: double.infinity,
                    color: AppColor.ideColor,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xFF1E1E1E),
                                width: 2,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Text(
                                  'Output',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Tooltip(
                                message: 'คัดลอก Output ไปยัง Clipboard',
                                child: IconButton(
                                  onPressed: () {
                                    Clipboard.setData(
                                        ClipboardData(text: _output));
                                    Fluttertoast.showToast(
                                      msg: "คัดลอกแล้ว",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                    );
                                  },
                                  icon: const Icon(
                                      Clarity.copy_to_clipboard_line),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    elevation: 0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(20),
                            child: Align(
                              alignment: Alignment.centerLeft,
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
                      ],
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
