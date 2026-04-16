import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PinUnlockScreen extends StatefulWidget {
  const PinUnlockScreen({super.key});

  @override
  State<PinUnlockScreen> createState() => _PinUnlockScreenState();
}

class _PinUnlockScreenState extends State<PinUnlockScreen> {
  final pinCtrl = TextEditingController();
  final storage = const FlutterSecureStorage();
  bool obscurePin = true;

  Future<void> checkPin() async {
    final savedPin = await storage.read(key: "user_pin");
    final enteredPin = pinCtrl.text.trim();

    if (savedPin != null && enteredPin == savedPin) {
      Navigator.pop(context, true);
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Wrong PIN")),
    );
  }

  @override
  Widget build(BuildContext context) {
  print('PATTERN UNLOCK BUILD');
    return WillPopScope(
  onWillPop: () async {
    SystemNavigator.pop();
    return false;
  },
  child:  Scaffold(
      appBar: AppBar(
        title: const Text("Enter PIN"),
		leading: BackButton(onPressed: () => SystemNavigator.pop()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Enter your 6-digit PIN",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: pinCtrl,
              keyboardType: TextInputType.number,
              maxLength: 6,
              obscureText: obscurePin,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                counterText: "",
                suffixIcon: IconButton(
                  icon: Icon(
                    obscurePin ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      obscurePin = !obscurePin;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: checkPin,
              child: const Text("Unlock"),
            ),
          ],
        ),
      ),
	  ),
    );
  }
}