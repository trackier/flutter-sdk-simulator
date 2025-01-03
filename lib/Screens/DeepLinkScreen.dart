import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'CakeScreen.dart';

class DeepLinkingScreen extends StatefulWidget {
  @override
  _DeepLinkingScreenState createState() => _DeepLinkingScreenState();
}

class _DeepLinkingScreenState extends State<DeepLinkingScreen> {
  static const platform = MethodChannel('deep_link_channel'); // Define the MethodChannel
  String _linkMessage = 'Waiting for a link...'; // Display status message

  @override
  void initState() {
    super.initState();
    _initDeepLinkListener(); // Initialize the listener
  }

  /// Initialize deep link listener via MethodChannel
  void _initDeepLinkListener() {
    platform.setMethodCallHandler((call) async {
      if (call.method == "deep_link_channel") {
        String? link = call.arguments as String?;
        if (link != null) {
          _handleDeepLink(link);
        }
      }
    });
  }

  /// Handle deep link navigation
  void _handleDeepLink(String link) {
    setState(() {
      _linkMessage = 'Deep Link: $link'; // Update the displayed message
    });

    Uri uri = Uri.parse(link); // Parse the incoming link
    String? productId = uri.queryParameters['product_id'];
    String? quantity = uri.queryParameters['quantity'];
    String? actionData = uri.queryParameters['actionData'];
    String? dlv = uri.queryParameters['dlv'];

    // Check the path to navigate to CakeScreen
    if (uri.pathSegments.isNotEmpty && uri.pathSegments[0] == 'd') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CakeScreen(
            productId: productId,
            quantity: quantity,
            actionData: actionData,
            dlv: dlv,
          ),
        ),
      );
    } else {
      print("Unhandled deep link: $link"); // Log unhandled links
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Deep Linking Page')),
      body: Container(
        color: Colors.white, // Background color
        padding: const EdgeInsets.all(16.0), // Padding around the content
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Adding three styled images at the top
              _buildImageContainer('Image/blueberrycupcake.jpeg'),
              const SizedBox(height: 10), // Space between images
              _buildImageContainer('Image/chocochipcupcake.png'),
              const SizedBox(height: 10),
              _buildImageContainer('Image/vanillaccupake.jpeg'),
              const SizedBox(height: 20), // Space between images and text

              // Display deep link message
              Text(
                _linkMessage,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Navigate back
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Button color
                  foregroundColor: Colors.white, // Text color
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded corners
                  ),
                ),
                child: const Text('Back to Event Tracking'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Helper method to build styled image containers
  Widget _buildImageContainer(String imagePath) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          imagePath,
          height: 130,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
