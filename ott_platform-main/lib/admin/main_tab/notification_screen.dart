import 'package:flutter/material.dart';

class notificationScreen extends StatefulWidget {
  const notificationScreen({super.key});

  @override
  State<notificationScreen> createState() => _notificationScreenState();
}

class _notificationScreenState extends State<notificationScreen> {
  List<String> notifications = [];

  @override
  Widget build(BuildContext context) {
    return /*Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          title: Center(
              child: Text(
                'Notification',
                style: TextStyle(color: Colors.white),
              )),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            color: Colors.black,
            child: Column(
              children: [
                Container(
                  child: Expanded(
                    child: ListView(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/profilesetting');
                          },
                          child: Card(
                            color: Colors.white70,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: const ListTile(
                              leading: Icon(
                                Icons.account_circle_outlined,
                                color: Colors.black54,
                              ),
                              title: Text(
                                'Profile',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          color: Colors.white70,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: const ListTile(
                            leading: Icon(
                              Icons.car_rental,
                              color: Colors.black54,
                            ),
                            title: Text(
                              'Car Details',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          color: Colors.white70,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: const ListTile(
                            leading: Icon(
                              Icons.privacy_tip_sharp,
                              color: Colors.black54,
                            ),
                            title: Text(
                              'Privacy',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          color: Colors.white70,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: const ListTile(
                            leading: Icon(
                              Icons.history,
                              color: Colors.black54,
                            ),
                            title: Text(
                              'Purchase History',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          color: Colors.white70,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: const ListTile(
                            leading: Icon(Icons.help_outline, color: Colors.black54),
                            title: Text(
                              'Help & Support',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          color: Colors.white70,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: const ListTile(
                            leading: Icon(
                              Icons.privacy_tip_sharp,
                              color: Colors.black54,
                            ),
                            title: Text(
                              'Settings',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios_outlined),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          color: Colors.white70,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: const ListTile(
                            leading: Icon(
                              Icons.add_reaction_sharp,
                              color: Colors.black54,
                            ),
                            title: Text(
                              'Invite a Friend',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          color: Colors.white70,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: const ListTile(
                            leading: Icon(
                              Icons.logout,
                              color: Colors.black54,
                            ),
                            title: Text(
                              'Logout',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios_outlined),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );*/
        Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Center(
            child: Text(
          'Notification',
          style: TextStyle(color: Colors.white),
        )),
      ),
      body: Center(
          child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Divider(
              color: Colors.grey[400],
              thickness: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Give permission to upload video',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle accept action here
                            Navigator.of(context).pop(); // Close the dialog
                            // Add your accept action code here
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                          child: Text('Accept'),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle decline action here
                            Navigator.of(context).pop(); // Close the dialog
                            // Add your decline action code here
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                          child: Text('Decline'),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Divider(
              color: Colors.grey[400],
              thickness: 1,
            ),
          ),


          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Give permission to upload video',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle accept action here
                            Navigator.of(context).pop(); // Close the dialog
                            // Add your accept action code here
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                          child: Text('Accept'),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle decline action here
                            Navigator.of(context).pop(); // Close the dialog
                            // Add your decline action code here
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                          child: Text('Decline'),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Divider(
              color: Colors.grey[400],
              thickness: 1,
            ),
          ),


          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Give permission to upload video',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle accept action here
                            Navigator.of(context).pop(); // Close the dialog
                            // Add your accept action code here
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                          child: Text('Accept'),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle decline action here
                            Navigator.of(context).pop(); // Close the dialog
                            // Add your decline action code here
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                          child: Text('Decline'),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Divider(
              color: Colors.grey[400],
              thickness: 1,
            ),
          ),


          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Give permission to upload video',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle accept action here
                            Navigator.of(context).pop(); // Close the dialog
                            // Add your accept action code here
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                          child: Text('Accept'),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle decline action here
                            Navigator.of(context).pop(); // Close the dialog
                            // Add your decline action code here
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                          child: Text('Decline'),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Divider(
              color: Colors.grey[400],
              thickness: 1,
            ),
          ),


          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Give permission to upload video',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle accept action here
                            Navigator.of(context).pop(); // Close the dialog
                            // Add your accept action code here
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                          child: Text('Accept'),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle decline action here
                            Navigator.of(context).pop(); // Close the dialog
                            // Add your decline action code here
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                          child: Text('Decline'),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Divider(
              color: Colors.grey[400],
              thickness: 1,
            ),
          ),


          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Give permission to upload video',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle accept action here
                            Navigator.of(context).pop(); // Close the dialog
                            // Add your accept action code here
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                          child: Text('Accept'),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle decline action here
                            Navigator.of(context).pop(); // Close the dialog
                            // Add your decline action code here
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                          child: Text('Decline'),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Divider(
              color: Colors.grey[400],
              thickness: 1,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Give permission to upload video',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle accept action here
                            Navigator.of(context).pop(); // Close the dialog
                            // Add your accept action code here
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                          child: Text('Accept'),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle decline action here
                            Navigator.of(context).pop(); // Close the dialog
                            // Add your decline action code here
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                          child: Text('Decline'),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Divider(
              color: Colors.grey[400],
              thickness: 1,
            ),
          ),
        ],
      )),
    );
  }

  void _showNotificationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Notification'),
          content: Text('You have a new notification.'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Handle accept action here
                Navigator.of(context).pop(); // Close the dialog
                // Add your accept action code here
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              child: Text('Accept'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle decline action here
                Navigator.of(context).pop(); // Close the dialog
                // Add your decline action code here
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              child: Text('Decline'),
            ),
          ],
        );
      },
    );
  }
}
