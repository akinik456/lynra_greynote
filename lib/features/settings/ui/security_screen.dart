import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'pin_setup_screen.dart';


class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});
@override
State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
String lockType = "Pattern";
String secondaryLock = "None";
final storage = const FlutterSecureStorage();
final auth = LocalAuthentication();

@override
void initState() {
  super.initState();
  loadSecondaryLock();
}

Future<void> saveSecondaryLock(String value) async {
  await storage.write(key: "secondary_lock", value: value);
}

Future<void> loadSecondaryLock() async {
  final value = await storage.read(key: "secondary_lock");
  if (value != null) {
    setState(() {
      secondaryLock = value;
    });
  }
}
Future<void> testBiometric() async {
  final canCheck = await auth.canCheckBiometrics;
print("biometric called");
  if (!canCheck) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Biometric not available")),
    );
	print("biometric called end");
    return;
  }

  final authenticated = await auth.authenticate(
    localizedReason: "Authenticate to continue",
    options: const AuthenticationOptions(
      biometricOnly: true,
    ),
  );

  if (authenticated) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Biometric success")),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Biometric failed")),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Security"),
      ),
      body: ListView(
  padding: const EdgeInsets.all(16),
  children: [
    ListTile(
      title: const Text("Secondary Lock"),
	  subtitle: Text(secondaryLock),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Secondary Lock"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("None"),
              onTap: () {
  setState(() => secondaryLock = "None");
  saveSecondaryLock(secondaryLock);
  Navigator.pop(context);
},
            ),
            ListTile(
              title: const Text("PIN"),
              onTap: () async {
  final issecondaryLockPin = await storage.read(key: "secondary_lock");
	print("secondary_lock:$secondaryLock");		  
  if(issecondaryLockPin!="PIN")
  {
  setState(() => secondaryLock = "PIN");
  saveSecondaryLock(secondaryLock);
  Navigator.pop(context);
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("PIN setup coming next")),
	
  );
  Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => const PinSetupScreen(),
  ),
);
};
},
            ),
            ListTile(
              title: const Text("Biometric"),
              onTap: () async {
  await testBiometric();
  setState(() => secondaryLock = "Biometric");
  saveSecondaryLock(secondaryLock);
  Navigator.pop(context);
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Biometric setup coming next")),
  );
},
            ),
          ],
        ),
      );
    },
  );
},
    ),
  ],
),
    );
  }
}