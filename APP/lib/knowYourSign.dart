import 'package:flutter/material.dart';
import 'package:flutter_app_with_flask_api/CustomListTile.dart';

class KnowYourSign extends StatelessWidget {
  const KnowYourSign({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Know Your Signs'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            CustomListTile(
              height: 100,
              leading: Container(
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/Okay.jpg'), fit: BoxFit.cover),
                ),
              ),
              title: Center(child: Text('Okay')),
            ),
            SizedBox(
              height: 10,
            ),
            CustomListTile(
              height: 100,
              leading: Container(
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/Thankyou.png'),
                      fit: BoxFit.cover),
                ),
              ),
              title: Center(child: Text('Thank You')),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            CustomListTile(
              height: 100,
              leading: Container(
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/Please.jpg'),
                      fit: BoxFit.contain),
                ),
              ),
              title: Center(child: Text('Please')),
            ),
            SizedBox(
              height: 10,
            ),
            CustomListTile(
              height: 100,
              leading: Container(
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/IloveYou.jpg'),
                      fit: BoxFit.cover),
                ),
              ),
              title: Center(child: Text('I Love You')),
            ),
            SizedBox(
              height: 10,
            ),
            CustomListTile(
              height: 100,
              leading: Container(
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/Yes.jpg'), fit: BoxFit.cover),
                ),
              ),
              title: Center(child: Text('Yes')),
            ),
            SizedBox(
              height: 10,
            ),
            CustomListTile(
              height: 100,
              leading: Container(
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/NO.jpg'), fit: BoxFit.contain),
                ),
              ),
              title: Center(child: Text('No')),
            ),
          ],
        ),
      ),
    );
  }
}
