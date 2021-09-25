import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  final Function(String) onSearch;

  SearchBox(this.onSearch);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
          bottomLeft: Radius.circular(4),
          bottomRight: Radius.circular(4),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.07000000029802322),
            offset: Offset(0, 5),
            blurRadius: 20,
          )
        ],
        color: Color.fromRGBO(255, 255, 255, 1),
        border: Border.all(
          color: Color.fromRGBO(218, 225, 231, 1),
          width: 1,
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 0),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
                hintText: 'Unesi domen ovde',
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
                alignLabelWithHint: true,
                contentPadding: EdgeInsets.only(top: 15.0)),
          ),
        ),
      ),
    );

    // return Container(
    //   width: 343,
    //   height: 60,
    //   child: Stack(
    //     children: <Widget>[
    //       Positioned(
    //         top: 0,
    //         left: 0,
    //         child: Container(
    //           width: 343,
    //           height: 60,
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.only(
    //               topLeft: Radius.circular(4),
    //               topRight: Radius.circular(4),
    //               bottomLeft: Radius.circular(4),
    //               bottomRight: Radius.circular(4),
    //             ),
    //             boxShadow: [
    //               BoxShadow(
    //                   color: Color.fromRGBO(0, 0, 0, 0.07000000029802322),
    //                   offset: Offset(0, 5),
    //                   blurRadius: 20)
    //             ],
    //             color: Color.fromRGBO(255, 255, 255, 1),
    //             border: Border.all(
    //               color: Color.fromRGBO(218, 225, 231, 1),
    //               width: 1,
    //             ),
    //           ),
    //         ),
    //       ),
    //       Positioned(
    //         top: 23,
    //         left: 46,
    //         child: TextField(
    //           controller: searchController,
    //           decoration: InputDecoration(
    //             hintText: "Ukucaj domen ovde",
    //             suffixIcon: IconButton(
    //               onPressed: onSearch,
    //               icon: Icon(Icons.search),
    //             ),
    //           ),
    //         ),

    //         //  Text(
    //         //   'Ukucaj domen ovde',
    //         //   textAlign: TextAlign.left,
    //         //   style: TextStyle(
    //         //     color: Color.fromRGBO(35, 41, 46, 1),
    //         //     fontFamily: 'Inter',
    //         //     fontSize: 13,
    //         //     letterSpacing:
    //         //         0 /*percentages not used in flutter. defaulting to zero*/,
    //         //     fontWeight: FontWeight.normal,
    //         //     height: 1,
    //         //   ),
    //         // )
    //       ),
    //       Positioned(top: 25, left: 18, child: Container()),
    //     ],
    //   ),
    // );
  }
}
