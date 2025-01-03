import 'dart:math';
import 'package:flutter/material.dart';
import 'package:trackier_sdk_flutter/trackierevent.dart';
import 'package:trackier_sdk_flutter/trackierfluttersdk.dart';
import 'dart:developer';

class BuiltInEventsScreen extends StatefulWidget {
  @override
  _BuiltInEventsScreenState createState() => _BuiltInEventsScreenState();
}

class _BuiltInEventsScreenState extends State<BuiltInEventsScreen> {
  final List<Widget> _params = [];
  final List<TextEditingController> _controllers = [];
  String? _selectedEvent;
  String? _selectedCurrency;
  final TextEditingController _revenueController = TextEditingController(); // Controller for revenue

  final List<String> _eventsList = [
    "ADD_TO_CART",
    "LEVEL_ACHIEVED",
    "ADD_TO_WISHLIST",
    "COMPLETE_REGISTRATION",
    "TUTORIAL_COMPLETION",
    "PURCHASE",
    "SUBSCRIBE",
    "START_TRIAL",
    "ACHIEVEMENT_UNLOCKED",
    "CONTENT_VIEW",
    "TRAVEL_BOOKING",
    "SHARE",
    "INVITE",
    "LOGIN",
    "UPDATE",
  ];

  final List<String> _currencyList = [
    "USD", "EUR", "GBP", "INR", "AUD", "CAD", "SGD", "CHF", "MYR", "JPY",
    "ARS", "BHD", "BWP", "BRL", "BND", "BGN", "CLP", "COP", "HRK", "CZK",
    "DKK", "AED", "HKD", "HUF", "ISK", "IDR", "ILS", "KZT", "KWD", "LYD",
    "MUR", "MXN", "NPR", "NZD", "NOK", "OMR", "PKR", "PHP", "PLN", "RUB",
    "RON", "SAR", "ZAR", "KRW", "LKR", "SEK", "TWD", "THB", "TTD", "TRY",
    "VEF", "ZMW", "YER", "XPF", "VND", "VES"
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
                  labelText: 'Param $paramIndex', // Indicate parameter name
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
    String event = _selectedEvent ?? '';
    String revenue = _revenueController.text;
    String currency = _selectedCurrency ?? '';

    // Collect all parameter values
    List<String> paramValues = _controllers.map((controller) => controller.text).toList();

    // Check for empty fields
    if (event.isEmpty || revenue.isEmpty || currency.isEmpty || paramValues.any((value) => value.isEmpty)) {
      _showErrorDialog();
      return;
    }

    // Safely convert revenue to double
    double? revenueValue = double.tryParse(revenue);
    if (revenueValue == null) {
      _showErrorDialog(message: 'Revenue must be a valid number.');
      return;
    }

    // Dynamically assign the event based on _selectedEvent
    TrackierEvent trackierEvent;

    switch (_selectedEvent) {
      case "ADD_TO_CART":
        trackierEvent = TrackierEvent(TrackierEvent.ADD_TO_CART);
        break;
      case "LEVEL_ACHIEVED":
        trackierEvent = TrackierEvent(TrackierEvent.LEVEL_ACHIEVED);
        break;
      case "ADD_TO_WISHLIST":
        trackierEvent = TrackierEvent(TrackierEvent.ADD_TO_WISHLIST);
        break;
      case "COMPLETE_REGISTRATION":
        trackierEvent = TrackierEvent(TrackierEvent.COMPLETE_REGISTRATION);
        break;
      case "TUTORIAL_COMPLETION":
        trackierEvent = TrackierEvent(TrackierEvent.TUTORIAL_COMPLETION);
        break;
      case "PURCHASE":
        trackierEvent = TrackierEvent(TrackierEvent.PURCHASE);
        break;
      case "SUBSCRIBE":
        trackierEvent = TrackierEvent(TrackierEvent.SUBSCRIBE);
        break;
      case "START_TRIAL":
        trackierEvent = TrackierEvent(TrackierEvent.START_TRIAL);
        break;
      case "ACHIEVEMENT_UNLOCKED":
        trackierEvent = TrackierEvent(TrackierEvent.ACHIEVEMENT_UNLOCKED);
        break;
      case "CONTENT_VIEW":
        trackierEvent = TrackierEvent(TrackierEvent.CONTENT_VIEW);
        break;
      case "TRAVEL_BOOKING":
        trackierEvent = TrackierEvent(TrackierEvent.TRAVEL_BOOKING);
        break;
      case "SHARE":
        trackierEvent = TrackierEvent(TrackierEvent.SHARE);
        break;
      case "INVITE":
        trackierEvent = TrackierEvent(TrackierEvent.INVITE);
        break;
      case "LOGIN":
        trackierEvent = TrackierEvent(TrackierEvent.LOGIN);
        break;
      case "UPDATE":
        trackierEvent = TrackierEvent(TrackierEvent.UPDATE);
        break;
      default:
        trackierEvent = TrackierEvent(TrackierEvent.LOGIN); // Default to LOGIN if no event selected
        break;
    }

    // Now set other event data like revenue and currency
    trackierEvent.revenue = revenueValue;
    trackierEvent.currency = currency;
    trackierEvent.orderId = "324222233f33";
    Trackierfluttersdk.setUserEmail("Satyam@Trackier.com");
    Trackierfluttersdk.setUserId("###Uy_eeGu");
    Trackierfluttersdk.setUserName("Satyam Jha");
    Trackierfluttersdk.setUserPhone("8252786821");
    Trackierfluttersdk.setGender(Gender.Male);
    
    

    // Assign parameters dynamically using setEventValue
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
      SnackBar(content: Text('Built-in Event Submitted')),
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
        title: Text('Built-in Events'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Welcome To Built-In Events',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              DropdownButton<String>(
                hint: Text('Select Built-in Events'),
                value: _selectedEvent,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedEvent = newValue;
                  });
                },
                items: _eventsList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              ..._params,
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addParam,
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.blue, // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded corners
                  ),
                ),
                child: Text('Add Parameter'),
              ),
              SizedBox(height: 20),
              Card(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _revenueController, // Use the revenue controller
                    decoration: InputDecoration(
                      hintText: 'Revenue',
                      border: OutlineInputBorder(),
                      labelText: 'Revenue',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
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
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.green, // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded corners
                  ),
                ),
                child: Text('Submit Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
