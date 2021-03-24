import 'package:flutter/material.dart';

class MerchantSignIn extends StatefulWidget {
  @override
  _MerchantSignInState createState() => _MerchantSignInState();
}

class _MerchantSignInState extends State<MerchantSignIn> {

  final TextEditingController merchantIdController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[800],
          title: Text('Merchant Sign in'),
          centerTitle: true,
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Enter your ID',
                style: TextStyle(
                    fontSize: 25
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextField(
                  controller: merchantIdController,
                  style: TextStyle(fontSize: 16),
                  decoration: new InputDecoration(
                    fillColor: Color(0xFFF8F8F8),
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    hintText: 'e.g: 28',
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextButton(onPressed: ()  {
                final String merchantID = merchantIdController.text;
                print('Entered text is $merchantID');
                Navigator.pushNamed(context,'/merchantHomePage',arguments: merchantID);
              }, child: Text('Sign in'),
              ),
              SizedBox(height: 20),
            ]
        )

    );
  }
}
