

import 'package:flutter/material.dart';

import '66/login.dart';
import '70/login.dart';
import 'login.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BuffetLocationScreen(),
  ));
}
class BuffetLocationScreen extends StatefulWidget {
  @override
  _BuffetLocationScreenState createState() => _BuffetLocationScreenState();
}

class _BuffetLocationScreenState extends State<BuffetLocationScreen> {
  String selectedLocation = 'Downtown Buffet';

  void navigateToSelectedLocationScreen() {
    switch (selectedLocation) {
      case 'Polyom Buffet':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>LoginPage(),
          ),
        );
        break;
      case '70th Buffet':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage70(),
          ),
        );
        break;
      case '66 Buffet':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage66(),
          ),
        );
        break;
      default:
      // Handle default case or error
    }
  }

  void handleSaveData() {
    // Implement your logic to save the data here
    // For example, you can save it to a database or perform any necessary actions.
  }

  void _handleShareApp() {
    // Replace 'your_app_download_link' with your app's actual download link
    String appDownloadLink = 'your_app_download_link';

    // Share the app download link
    // You can use any sharing mechanism you prefer, such as the share package
    // or other methods to share the download link.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'BM BUFFET Admin panel',
          style: GoogleFonts.lato(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(height: 20),
            Text(
              "Mohamed Nazmy",
              style: GoogleFonts.cairo(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 40),
            Text(
              "Choose Your Buffet Location",
              style: GoogleFonts.cairo(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  CustomLocationButton(
                    title: 'Polyom Buffet',
                    isSelected: selectedLocation == 'Polyom Buffet',
                    onTap: () {
                      setState(() {
                        selectedLocation = 'Polyom Buffet';
                      });
                      navigateToSelectedLocationScreen();
                    },
                  ),
                  SizedBox(height: 16),
                  CustomLocationButton(
                    title: '70th Buffet',
                    isSelected: selectedLocation == '70th Buffet',
                    onTap: () {
                      setState(() {
                        selectedLocation = '70th Buffet';
                      });
                      navigateToSelectedLocationScreen();
                    },
                  ),
                  SizedBox(height: 16),
                  CustomLocationButton(
                    title: '66 Buffet',
                    isSelected: selectedLocation == '66 Buffet',
                    onTap: () {
                      setState(() {
                        selectedLocation = '66 Buffet';
                      });
                      navigateToSelectedLocationScreen();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          // Inside the Column's children list



        ],
      ),
    );
  }
}

class CustomLocationButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  CustomLocationButton({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.brown : Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
            Icon(
              Icons.arrow_forward,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}


