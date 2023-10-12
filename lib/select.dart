
import 'package:flutter/material.dart';

import '70/Bottomsheet.dart';
import 'Bottomsheet.dart';


class BuffetLocationScreen extends StatefulWidget {
  @override
  _BuffetLocationScreenState createState() => _BuffetLocationScreenState();
}

class _BuffetLocationScreenState extends State<BuffetLocationScreen> {
  String selectedLocation = 'Downtown Buffet';

  // Function to navigate to the selected location screen
  void navigateToSelectedLocationScreen() {
    switch (selectedLocation) {
      case 'Polyom Buffet':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyBottomNavigationBar(),),

        );
        break;
      case '70th Buffet':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyBottomNavigationBar2(),
          ),
        );
        break;
      default:
      // Handle default case or error
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body:
        SingleChildScrollView(
          child: Column(
            children: [



              SizedBox(height: 40,),
              Text(
                "Choose your buffet",
                style: TextStyle(
                  fontSize: 25,
                ),),
              SizedBox(height: 10,),

              // Use a custom Widget or ListTile for better control over styling
              CustomListItem(
                title: 'Polyom Buffet',
                onTap: () {
                  setState(() {
                    selectedLocation = 'Polyom Buffet';
                  });
                  navigateToSelectedLocationScreen();
                },
              ),
              SizedBox(height: 16), // Add spacing between list items
              CustomListItem(
                title: '70th Buffet',
                onTap: () {
                  setState(() {
                    selectedLocation = '70th Buffet';
                  });
                  navigateToSelectedLocationScreen();
                },
              ),
            ],
          ),
        )


    );
  }
}

void main() {
  runApp(MaterialApp(
    home: BuffetLocationScreen(),
  ));
}
void handleSaveData() {
  // Implement your logic to save the data here
  // For example, you can save it to a database or perform any necessary actions.
}

class CustomListItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  CustomListItem({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Add rounded corners
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16), // Add padding for better spacing
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18, // Customize the font size
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
