import 'package:flutter/material.dart';
import 'package:whois_trosica/i18n/strings.g.dart';

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
              hintText: Translations.of(context).enter_domain,
              prefixIcon: Icon(Icons.search),
              border: InputBorder.none,
              alignLabelWithHint: true,
              contentPadding: EdgeInsets.only(top: 15.0),
            ),
            onEditingComplete: () => onSearch(searchController.text),
          ),
        ),
      ),
    );
  }
}
