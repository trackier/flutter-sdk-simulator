import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CakeScreen extends StatelessWidget {
  final String? productId;
  final String? quantity;
  final String? actionData;
  final String? dlv;

  CakeScreen({
    this.productId,
    this.quantity,
    this.actionData,
    this.dlv,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint("CakeScreen received: productId=$productId, quantity=$quantity, actionData=$actionData, dlv=$dlv");

    return Scaffold(
      appBar: AppBar(
        title: Text('Cake Activity'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Product Image
            Image.asset(
              _getProductImage(),
              width: 200,
              height: 200,
            ),
            SizedBox(height: 10),
            // Product Name
            Text(
              "Name: ${productId?.toUpperCase() ?? 'Unknown'}",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Quantity
            Text(
              "Quantity: ${quantity ?? '0'}",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // JSON Data
            Text(
              _getJsonData(),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Copy Data Button
            ElevatedButton.icon(
              onPressed: () {
                _copyDataToClipboard(context);
              },
              icon: Icon(Icons.content_copy),
              label: Text(
                "Data Copy",
                style: TextStyle(color: Colors.white), // Change the text color here
              ), style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
            ),
          ],
        ),
      ),
    );
  }

  String _getProductImage() {
    // Log productId to see which image is being used
    debugPrint("Fetching image for product: $productId");

    switch (productId) {
      case "blueberry":
        return 'Image/blueberrycupcake.png'; // Ensure you have this image in your assets
      case "chocochip":
        return 'Image/chocochipcupcake.png'; // Ensure you have this image in your assets
      case "vanilla":
        return 'Image/vanillaccupake.png'; // Ensure you have this image in your assets
      default:
        return 'Image/chocochipcupcake.png'; // Default image if none match
    }
  }

  String _getJsonData() {
    return '{"Action": "$actionData", "Dlv": "$dlv", "Quantity": "$quantity", "Product": "$productId"}';
  }

  void _copyDataToClipboard(BuildContext context) {
    final data = _getJsonData();
    Clipboard.setData(ClipboardData(text: data));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Data Copied")),
    );
  }
}
