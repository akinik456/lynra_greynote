import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PinSetupScreen extends StatefulWidget {
  const PinSetupScreen({super.key});

  @override
  State<PinSetupScreen> createState() => _PinSetupScreenState();
}

class _PinSetupScreenState extends State<PinSetupScreen> {
final pinCtrl = TextEditingController();
final confirmPinCtrl = TextEditingController();
bool obscurePin = true;
final storage = const FlutterSecureStorage();

Future<bool> hasPin() async {
  final value = await storage.read(key: "user_pin");
  return value != null;
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Set PIN"),
      ),
      body: Padding(
  padding: const EdgeInsets.all(16),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text(
        "Enter 6-digit PIN",
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
        border: OutlineInputBorder(),
        counterText: "",
        ),		
      ),
	  const Text(
        "Enter 6-digit PIN",
        style: TextStyle(fontSize: 18),
      ),
	  const SizedBox(height: 20),
      TextField(
        controller: confirmPinCtrl,
		keyboardType: TextInputType.number,
        maxLength: 6,
        obscureText: obscurePin,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
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
        border: OutlineInputBorder(),
        counterText: "",
        ),		
      ),
	  const SizedBox(height: 20),
ElevatedButton(
  onPressed: () async  {
  final pin = pinCtrl.text.trim();
  final confirmPin = confirmPinCtrl.text.trim();

  if (pin.length != 6 || confirmPin.length != 6) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("PIN must be 6 digits")),
    );
    return;
  }

  if (pin != confirmPin) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("PINs do not match")),
    );
    return;
  }
  await storage.write(key: "user_pin", value: pin);
  ScaffoldMessenger.of(context).showSnackBar(
    
    const SnackBar(content: Text("PIN saved")),
  );
  Navigator.pop(context);
},
  child: const Text("Save PIN"),
),

    ],
  ),
),
    );
  }
}