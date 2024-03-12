// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:highlight/languages/python.dart';
import 'package:pyoneer/utils/color.dart';

class IDEScreen extends StatefulWidget {
  const IDEScreen({super.key});

  @override
  State<IDEScreen> createState() => _IDEScreenState();
}

class _IDEScreenState extends State<IDEScreen>
    with AutomaticKeepAliveClientMixin {
  final controller = CodeController(
    text: '# เขียน Code ที่นี่เลย\n',
    language: python,
  );

  @override
  bool get wantKeepAlive => true;
  final _focusNode = FocusNode();

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
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SingleChildScrollView(
                    child: CodeTheme(
                      data: CodeThemeData(styles: monokaiSublimeTheme),
                      child: CodeField(
                        focusNode: _focusNode,
                        minLines: 50,
                        wrap: true,
                        controller: controller,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Text(
              "Output",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      color: AppColor.ideColor,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '1 Test String\n2 Test String\n3 Test String\n4 Test String\n5 Test String\n6 Test String\n7 Test String\n8 Test String\n9 Test String\n10 Test String\n11 Test String\n12 Test String\n13 Test String\n14 Test String\n15 Test String\n16 Test String',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
              return  SizedBox(height: isKeyboardVisible ? 0 : 140);
            }),
          ],
        ),
      ),
    );
  }
}
