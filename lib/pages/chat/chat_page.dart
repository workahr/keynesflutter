// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Keynes Construction',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Color(0xFF0151AF),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 32,
            height: 32,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                'K',
                style: TextStyle(
                  color: Color(0xFF0151AF),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              height: screenHeight * 0.14,
              decoration: BoxDecoration(
                  // color: Color(0xFF0151AF),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Color(0xFFDAD9D9))),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      CircleAvatar(
                        backgroundColor: Color(0xFF0151AF),
                        maxRadius: 25,
                        child: Text(
                          'R',
                          style: TextStyle(
                              color: Color(0xFFDAD9D9),
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rewhip',
                            style: TextStyle(
                                color: Color.fromARGB(255, 164, 198, 236),
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            'Lorem iposum',
                            style: TextStyle(
                                color: Color.fromRGBO(126, 126, 126, 1),
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ]),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '12:30PM',
                          style: TextStyle(
                              color: Color(0xFF716969),
                              fontSize: 13,
                              fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CircleAvatar(
                          backgroundColor: Color(0xFF0151AF),
                          maxRadius: 16,
                          child: Text(
                            '1',
                            style: TextStyle(
                                color: Color(0xFFDAD9D9),
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
