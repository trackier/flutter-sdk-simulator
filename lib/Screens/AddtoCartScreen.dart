import 'package:flutter/material.dart';
import 'package:trackier_sdk_flutter/trackierevent.dart';
import 'package:trackier_sdk_flutter/trackierfluttersdk.dart';

class AddToCartScreen extends StatefulWidget {
  @override
  _AddToCartScreenState createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize any necessary SDKs here if needed
  }

  void _purchase() {
    // Create a Trackier event
    TrackierEvent trackierEvent = TrackierEvent("Q4YsqBKnzZ");
    trackierEvent.revenue = 30.0; // Set the revenue for the purchase
    trackierEvent.param1 = "Britannia Cupcake"; // Set the product name

    // Set user additional details
    Map<String, dynamic> userDetails = {
      "username": "sanu",
      "id": "8738273",
    };
    Trackierfluttersdk.setUserAdditonalDetail(userDetails);

    // Track the event
    Trackierfluttersdk.trackEvent(trackierEvent);

    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Thanks for Purchase")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add to Cart Page'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'Image/trackierlogo.png', // Ensure this path is correct
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            SizedBox(height: 20),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      'Image/chocochipcupcake.png', // Ensure this path is correct
                      width: 100,
                      height: 100,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Britannia Cupcake', // Replace with your product name
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            '\$30.00', // Replace with your product price
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _purchase,
              child: Text('Purchase'),
            ),
          ],
        ),
      ),
    );
  }
}