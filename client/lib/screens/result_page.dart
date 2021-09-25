import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whois_trosica/constants/colors.dart';
import 'package:whois_trosica/widgets/result_card.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  Widget _buildAppBar() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      decoration: BoxDecoration(
          color: Colors.white, border: Border(bottom: BorderSide(width: 1, color: ColorsHelper.borderColor))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                FontAwesomeIcons.search,
                color: ColorsHelper.iconColor,
                size: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'donesi.rs',
                style: TextStyle(color: ColorsHelper.darkTextColor, fontWeight: FontWeight.w500, fontSize: 13),
              ),
            ],
          ),
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                FontAwesomeIcons.times,
                color: ColorsHelper.iconColor,
              )),
        ],
      ),
    );
  }

  Widget _buildDomenTitle() {
    return Container(
      padding: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(top: 3, bottom: 3),
            color: ColorsHelper.domenTextContainer,
            child: Text(
              'donesi.rs',
              style: TextStyle(
                color: ColorsHelper.darkTextColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            'je pronadjen!',
            style: TextStyle(
              color: ColorsHelper.lightTextColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: ColorsHelper.backgroundColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildAppBar(),
              _buildDomenTitle(),
              ResultCardWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
