import 'package:flutter/material.dart';
import 'package:trackier_sdk_flutter/trackierevent.dart';
import 'package:trackier_sdk_flutter/trackierfluttersdk.dart';
import 'dart:developer';

class CustomsEventsScreen extends StatefulWidget {
  @override
  _CustomsEventsScreenState createState() => _CustomsEventsScreenState();
}

class _CustomsEventsScreenState extends State<CustomsEventsScreen> {
  final List<Widget> _params = [];
  final List<TextEditingController> _controllers = [];
  final TextEditingController _eventIdController = TextEditingController();
  final TextEditingController _revenueController = TextEditingController();
  String? _selectedCurrency;

  final List<String> _currencyList = [
    "USD", "EUR", "GBP", "INR", "AUD", "CAD", "SGD", "CHF", "MYR", "JPY",
    // Add more currencies as needed
  ];

  void _addParam() {
    if (_params.length < 10) { // Limit to 10 parameters
      TextEditingController newController = TextEditingController();
      setState(() {
        _params.add(_buildParamRow(newController, _params.length + 1));
        _controllers.add(newController);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You can only add up to 10 parameters.')),
      );
    }
  }

  Widget _buildParamRow(TextEditingController controller, int paramIndex) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Parameter Value',
                  border: OutlineInputBorder(),
                  labelText: 'Param $paramIndex',
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                setState(() {
                  int index = _controllers.indexOf(controller);
                  _params.removeAt(index);
                  _controllers.removeAt(index);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void _submit() {
    String eventId = _eventIdController.text;
    String revenue = _revenueController.text;
    String currency = _selectedCurrency ?? '';

    // Collect all parameter values
    List<String> paramValues = _controllers.map((controller) => controller.text).toList();

    // Check for empty fields
    if (eventId.isEmpty || revenue.isEmpty || currency.isEmpty || paramValues.any((value) => value.isEmpty)) {
      _showErrorDialog();
      return;
    }

    // Safely convert revenue to double
    double? revenueValue = double.tryParse(revenue);
    if (revenueValue == null) {
      _showErrorDialog(message: 'Revenue must be a valid number.');
      return;
    }

    // Create a new TrackierEvent
    TrackierEvent trackierEvent = TrackierEvent(eventId);

    trackierEvent.revenue = revenueValue;
    trackierEvent.currency = currency;
    trackierEvent.orderId = "324222233f33";
    Trackierfluttersdk.setUserEmail("Satyam@Trackier.com");
    Trackierfluttersdk.setUserId("#jdjdjdjh3");
    Trackierfluttersdk.setUserName("Satyam Jha");
    Trackierfluttersdk.setUserPhone("8252786821");
    Trackierfluttersdk.setGender(Gender.Male);


    // Assign parameters dynamically
      trackierEvent.setEventValue("Event Send","To Pannel");


    // Dynamically assign the values to param1, param2, ..., param10 based on user input
    for (int i = 0; i < paramValues.length; i++) {
      switch (i) {
        case 0:
          trackierEvent.param1 = paramValues[i];
          break;
        case 1:
          trackierEvent.param2 = paramValues[i];
          break;
        case 2:
          trackierEvent.param3 = paramValues[i];
          break;
        case 3:
          trackierEvent.param4 = paramValues[i];
          break;
        case 4:
          trackierEvent.param5 = paramValues[i];
          break;
        case 5:
          trackierEvent.param6 = paramValues[i];
          break;
        case 6:
          trackierEvent.param7 = paramValues[i];
          break;
        case 7:
          trackierEvent.param8 = paramValues[i];
          break;
        case 8:
          trackierEvent.param9 = paramValues[i];
          break;
        case 9:
          trackierEvent.param10 = paramValues[i];
          break;
      }
    }
    // Track the event
    Trackierfluttersdk.trackEvent(trackierEvent);

    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Custom Events Submitted')),
    );
  }

  void _showErrorDialog({String message = 'Please fill in all fields before submitting.'}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Input Error'),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customs Events'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Welcome To Customs Events',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _eventIdController,
              decoration: InputDecoration(
                hintText: 'Enter Events Id',
                border: OutlineInputBorder(),
                labelText: 'Event ID',
              ),
            ),
            SizedBox(height: 20),
            ..._params,
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addParam,
              child: Text('Add Parameter'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _revenueController,
              decoration: InputDecoration(
                hintText: 'Revenue',
                border: OutlineInputBorder(),
                labelText: 'Revenue',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              hint: Text('Select Currency'),
              value: _selectedCurrency,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCurrency = newValue;
                });
              },
              items: _currencyList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: Text('Submit Event'),
            ),
          ],
        ),
      ),
    );
  }
}