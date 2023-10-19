import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListStudentPrepare extends StatelessWidget {
  const ListStudentPrepare({super.key});



  @override
  Widget build(BuildContext context) {
    double pageWidth = MediaQuery.of(context).size.width * 0.75;
    double pageHeight = pageWidth * 13 / 9;
    return Container(
      color: Colors.white,
      child: Shimmer.fromColors(
        baseColor: const Color.fromARGB(255, 244, 244, 244),
        highlightColor: const Color.fromARGB(255, 251, 251, 251),
        direction: ShimmerDirection.ltr, 
        enabled: true,
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: pageHeight,
            child: PageView(
              controller: PageController(
                initialPage: 1,
              
                viewportFraction: 0.75
              ),
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Transform.scale(
                  scale: 0.8,
                  child: childItem(
                    height: pageHeight,
                    width: pageWidth
                  ),
                ),
                childItem(
                  height: pageHeight,
                  width: pageWidth
                ),
                Transform.scale(
                  scale: 0.8,
                  child: childItem(
                    height: pageHeight,
                    width: pageWidth
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }


  Widget childItem({double? width, double? height}){
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10
      ),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 238, 238, 238),
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
    );
  }
}