import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:codemaster_pro/core/theme/app_colors.dart';
import 'package:codemaster_pro/features/practice/providers/code_execution_repository.dart';

class CodeEditorScreen extends ConsumerStatefulWidget {
  const CodeEditorScreen({super.key});

  @override
  ConsumerState<CodeEditorScreen> createState() => _CodeEditorScreenState();
}

class _CodeEditorScreenState extends ConsumerState<CodeEditorScreen> {
  final TextEditingController _codeController = TextEditingController();
  String _selectedLanguage = 'Python';
  String _output = '';
  bool _isExecuting = false;

  final List<String> _languages = ['Python', 'JavaScript', 'Java', 'Dart'];

  final Map<String, String> _codeTemplates = {
    'Python': 'def main():\n    print("Hello, World!")\n\nif __name__ == "__main__":\n    main()',
    'JavaScript': 'function main() {\n    console.log("Hello, World!");\n}\n\nmain();',
    'Java': 'public class Main {\n    public static void main(String[] args) {\n        System.out.println("Hello, World!");\n    }\n}',
    'Dart': 'void main() {\n  print("Hello, World!");\n}',
  };

  @override
  void initState() {
    super.initState();
    _codeController.text = _codeTemplates[_selectedLanguage]!;
  }

  void _onLanguageChanged(String? newLanguage) {
    if (newLanguage != null) {
      setState(() {
        _selectedLanguage = newLanguage;
        _codeController.text = _codeTemplates[newLanguage]!;
        _output = '';
      });
    }
  }

  Future<void> _runCode() async {
    if (_codeController.text.trim().isEmpty) return;

    setState(() {
      _isExecuting = true;
      _output = 'Executing code...';
    });

    final repo = ref.read(codeExecutionRepositoryProvider);
    final result = await repo.executeCode(_selectedLanguage, _codeController.text);

    if (mounted) {
      setState(() {
        _isExecuting = false;
        _output = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coding Playground'),
        backgroundColor: AppColors.backgroundDark,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DropdownButton<String>(
              value: _selectedLanguage,
              dropdownColor: AppColors.surfaceDark,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              underline: const SizedBox(),
              items: _languages.map((lang) {
                return DropdownMenuItem(value: lang, child: Text(lang));
              }).toList(),
              onChanged: _onLanguageChanged,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: const Color(0xFF1E1E1E), // Dark VSCode-like background
              child: TextField(
                controller: _codeController,
                maxLines: null,
                expands: true,
                style: const TextStyle(fontFamily: 'monospace', color: Colors.greenAccent, fontSize: 16),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                  hintText: 'Write your code here...',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: AppColors.surfaceDark,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Console Output', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                ElevatedButton.icon(
                  onPressed: _isExecuting ? null : _runCode,
                  icon: _isExecuting ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Icon(Icons.play_arrow),
                  label: const Text('Run Code'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.black,
              child: SingleChildScrollView(
                child: SelectableText(
                  _output,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    color: _output.startsWith('Error') || _output.startsWith('Failed') ? Colors.redAccent : Colors.white,
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
