import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'customersPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
        home: RegisterPage());
  }
}

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
bool loggingIn = false;
    Color whiteSmoke = Color.fromRGBO(243, 241, 249, 1);
    Color salmon = Color.fromRGBO(255, 121, 120, 1);
    Color darkSlateBlue = Color.fromRGBO(93,84,163,1);
    Color mediumSeaGreen = Color.fromRGBO(55,204,138,1);
    OutlineInputBorder inputFieldsBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: Colors.grey),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg-intro-mobile.png'),
                fit: BoxFit.cover,
              ),
              color: salmon,
              backgroundBlendMode: BlendMode.srcOver

          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: height * 0.10,
                ),
                //Heading
                Text(
                  'Use the best CRM to grow your business',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //Form
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: whiteSmoke,
                        borderRadius: BorderRadius.all(Radius.circular(16))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                            child: Text('Login', style: TextStyle(fontSize: 32,), textAlign: TextAlign.center,),
                          ),
                          //Input Fields
                          Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,0,24.0),
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(24),
                          labelText: 'Email address',
                          labelStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700),
                          hintStyle: TextStyle(color: Colors.black.withOpacity(0.60), fontWeight: FontWeight.w600),
                          fillColor: whiteSmoke,
                          border: inputFieldsBorder,
                          focusedBorder: inputFieldsBorder,
                          disabledBorder: inputFieldsBorder,
                          enabledBorder: inputFieldsBorder,
                        ),
                        onChanged: ((string){
                          setState(() {
                            email = string;
                          });
                        }),
                      ),
                    ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0,0,0,24.0),
                            child: TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(24),
                                labelText: 'Password',
                                labelStyle: TextStyle(color: Colors.black.withOpacity(0.60), fontWeight: FontWeight.w700),
                                hintStyle: TextStyle(color: Colors.black.withOpacity(0.60), fontWeight: FontWeight.w600),
                                fillColor: whiteSmoke,
                                border: inputFieldsBorder,
                                focusedBorder: inputFieldsBorder,
                                disabledBorder: inputFieldsBorder,
                                enabledBorder: inputFieldsBorder,
                              ),
                              onChanged: ((string){
                                setState(() {
                                  password = string;
                                });
                              }),
                            ),
                          ),
                          //Submit button
                          GestureDetector(
                            onTap: (() async{
                              setState(() {
                                loggingIn = true;
                              });
                              Map<String, String> json = {'email': email, 'password': password};
                              String url = 'http://10.0.2.2:5004/login';
                              Response response = await post(url, body: jsonEncode(json), headers: {'Content-type': 'application/json'});
                              Map data = jsonDecode(response.body);
//                              print(data['_id']);
                              List<String> cookies = (response.headers['set-cookie']).split('; ');
                              String cookie2Data = (cookies[3].split(',')[1]);
//                              print(cookie2Data);
                              Cookie cookie1 = Cookie(cookies[0].substring(0, 7), cookies[0].substring(8, 60));
                              Cookie cookie2 = Cookie(cookie2Data.substring(0, 11), cookie2Data.substring(12));
//                              print(cookie2.name);
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Customers(userId: data['_id'], cookie1: cookie1, cookie2: cookie2,)),
                              );
                            }),
                            child: Container(
                              decoration: BoxDecoration(
                                color: mediumSeaGreen,
                                boxShadow: [ BoxShadow(
                                  color: Color.fromRGBO(108, 185, 153,1),
                                  blurRadius: 0.0, // soften the shadow
                                  spreadRadius: 0.0, //extend the shadow
                                  offset: Offset(
                                    0.0, // Move to right 10  horizontally
                                    7.0, // Move to bottom 10 Vertically
                                  ),),],
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: loggingIn ? CircularProgressIndicator() : RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: TextStyle(color: whiteSmoke, height: 1.5),
                                      children: [TextSpan(
                                        text: 'SUBMIT',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1.0,
                                          fontSize: 16,
                                        ),
                                      ),],
                                    )),
                              ),
                            ),
                          ),
                          //Terms and Services
                          Padding(
                            padding: EdgeInsets.fromLTRB(24, 28, 24, 0),
                            child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      height: 1.25,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Create a new account',),
                                      TextSpan(text: 'SignUp', style: TextStyle(color: salmon, fontWeight: FontWeight.w500)),
                                    ]
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //Spacer Alternative
                SizedBox(height: height * 0.05,),
              ],
            ),
          ),
        ),
      )
    );
  }
  Future readResponse(HttpClientResponse response) {
    var completer = new Completer();
    var contents = new StringBuffer();
    response.transform(utf8.decoder).listen((data) {
      contents.write(data);
    }, onDone: () => completer.complete(contents.toString()));
    return completer.future;
  }

  GestureDetector buildButton(Color backGroundColor, Color textColor, List<TextSpan> textChildren, Color shadowColor) {
    return GestureDetector(
                          onTap: null,
                          child: Container(
                            decoration: BoxDecoration(
                              color: backGroundColor,
                              boxShadow: [ BoxShadow(
                                color: shadowColor,
                                blurRadius: 0.0, // soften the shadow
                                spreadRadius: 0.0, //extend the shadow
                                offset: Offset(
                                  0.0, // Move to right 10  horizontally
                                  7.0, // Move to bottom 10 Vertically
                                ),),],
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    style: TextStyle(color: textColor, height: 1.5),
                                    children: textChildren,
                                  )),
                            ),
                          ),
                        );
  }

  Padding buildInputField(Color whiteSmoke, OutlineInputBorder inputFieldsBorder, String hintText) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,0,0,24.0),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(24),
          labelText: hintText,
          hintText: hintText,
          labelStyle: TextStyle(color: Colors.black.withOpacity(0.60), fontWeight: FontWeight.w600),
          hintStyle: TextStyle(color: Colors.black.withOpacity(0.60), fontWeight: FontWeight.w600),
          fillColor: whiteSmoke,
          border: inputFieldsBorder,
          focusedBorder: inputFieldsBorder,
          disabledBorder: inputFieldsBorder,
          enabledBorder: inputFieldsBorder,
                            ),
        onChanged: ((string){

        }),
      ),
    );
  }
}
