import 'package:flutter/material.dart';

class ListStudentEmpty extends StatelessWidget {
  const ListStudentEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [

        Positioned.fill(
          child: Center(
            child: Icon(
              Icons.people_alt_outlined,
              color: const Color(0xFFf3f3f3),
              size: MediaQuery.of(context).size.width * 3 /4
            ),
          ),
        ),

        const Positioned.fill(
          child:  Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15
              ),
              child: Text(
                "Silakan masukan data murid.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 95, 53, 53),
                  fontWeight: FontWeight.w300,
                  fontSize: 13
                ),
              ) ,
            ),
          )
        )
      ],
    );
  }
}