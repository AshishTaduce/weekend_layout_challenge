import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: RegisterPage());
  }
}

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
                      height: height * 0.15,
                    ),
                    //Heading
                    Text(
                      'Learn to code by watching others.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //Content
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 48, horizontal: 0),
                      child: Text(
                        'See how experienced developer solve\n problems in real time.'
                            'Watching\n scripted tutorials is great, but\n understaning'
                            ', how developers think is\n invaluable.',
                        textAlign: TextAlign.center,
                        style:
                        TextStyle(color: whiteSmoke, height: 1.5, fontSize: 16),
                      ),
                    ),
                    //PurpleButton
                    buildButton(darkSlateBlue, whiteSmoke, [
                      TextSpan(
                        text: 'Try it free 7 days ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(text: 'then \n'),
                      TextSpan(text: '\$20/mo. thereafter'),
                    ],
                      Color.fromARGB(255,218,101,103),
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
                              //Input Fields
                              buildInputField(whiteSmoke, inputFieldsBorder, 'First name'),
                              buildInputField(whiteSmoke, inputFieldsBorder, 'Last name'),
                              buildInputField(whiteSmoke, inputFieldsBorder, 'Email address'),
                              buildInputField(whiteSmoke, inputFieldsBorder, 'Password'),
                              //Submit button
                              buildButton(mediumSeaGreen, whiteSmoke, [TextSpan(
                                text: 'CLAIM YOUR FREE TRAIL ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),], Color.fromRGBO(108, 185, 153,1)),
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
                                            text: 'By clicking the button you are agreeing to ',),
                                          TextSpan(text: 'our '),
                                          TextSpan(text: 'Terms and Services', style: TextStyle(color: salmon, fontWeight: FontWeight.bold)),
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
//        ],
//      ),
    );
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
                              hintText: hintText,
                              hintStyle: TextStyle(color: Colors.black.withOpacity(0.70), fontWeight: FontWeight.bold),
                              fillColor: whiteSmoke,
                              border: inputFieldsBorder,
                              focusedBorder: inputFieldsBorder,
                              disabledBorder: inputFieldsBorder,
                              enabledBorder: inputFieldsBorder,
                            ),
                          ),
                        );
  }
}
