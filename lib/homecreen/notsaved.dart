import 'package:flutter/material.dart';

class NotSaved extends StatefulWidget {
  const NotSaved({super.key});

  @override
  State<NotSaved> createState() => _NotSavedState();
}

class _NotSavedState extends State<NotSaved> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: const SizedBox(
            child: Icon(
          Icons.arrow_back_ios_new_sharp,
          color: Colors.black,
        )),
        backgroundColor: Colors.white,
        title: const Text(
          'Saved',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black),
        ),
      ),
      body: Column(children: [
        const SizedBox(
          height: 127,
        ),
        Center(child: Image.asset('asset/images/NS.png')),
        const SizedBox(
          height: 32,
        ),
        Column(
          children: [
            const Center(
              child: Text(
                ' Course not saved',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Center(
              child: Text(
                'Try saving the course \nagain in a few minutes',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Container(
              width: 309,
              height: 56,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xffE3562A)),
              child: const Center(
                child: Text(
                  'Continue',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffffffff)),
                ),
              ),
            )
          ],
        )
      ]),
    );
  }
}
