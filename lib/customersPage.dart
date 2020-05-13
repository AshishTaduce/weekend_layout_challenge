import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
class Customers extends StatefulWidget {
  final String userId;
  final Cookie cookie1;
  final Cookie cookie2;

  const Customers({Key key, this.userId, this.cookie1, this.cookie2, }) : super(key: key);

  @override
  _CustomersState createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  List usersList ;
  bool loggedIn = true;
  @override
  void initState() {
    getCustomers();
    super.initState();
  }

  getCustomers() async {
    String url = "http://10.0.2.2:5004/customers";
    print('${widget.cookie1.name}=${widget.cookie1.value}; ${widget.cookie2.name}=${widget.cookie2.value}');
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'cookie': '${widget.cookie1.name}=${widget.cookie1.value};${widget.cookie2.name}=${widget.cookie2.value}'
    };
    Response response = await get(url, headers: headers);
    dynamic data = jsonDecode(response.body);
    print(data);
    setState(() {
      usersList = data;
    });
  }
  Color salmon = Color.fromRGBO(255, 121, 120, 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: salmon,
        title: Text('Customers', style: TextStyle(color: Colors.white),),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: (() async {
            setState(() {
              usersList = null;
            });
            await Future.delayed(Duration(seconds: 3));
            getCustomers();
          })),
          IconButton(icon: Icon(Icons.exit_to_app), onPressed: (() async{
            String url = "http://10.0.2.2:5004/logout";
            Map<String, String> headers = {
              'Content-type': 'application/json',
              'cookie': '${widget.cookie1.name}=${widget.cookie1.value};${widget.cookie2.name}=${widget.cookie2.value}'
            };
            Response response = await get(url, headers: headers);
            if(response.statusCode == 200)
              Navigator.pop(context);
            else throw ArgumentError;
          }))
        ],
      ),
      body: Container(
        child: usersList != null ? ListView.builder(
            itemCount: usersList.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return Card(child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(usersList[index]['name'], style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
                        Text(usersList[index]['number'], style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(usersList[index]['gender']),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(usersList[index]['_id']),
                  ),
                ],
              ),);
            }
        ) : Center(child: CircularProgressIndicator(
          strokeWidth: 7,
        ))
      ),
    );
  }
}
