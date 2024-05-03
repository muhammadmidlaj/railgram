
import 'package:flutter/material.dart';

class TitleTextWidget extends StatelessWidget {
  const TitleTextWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, color: Color(0xFF9198a2)),
      ),
    );
  }
}

class ShowDetailsWidget extends StatelessWidget {
  const ShowDetailsWidget({super.key, required this.items});
  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
          width: double.infinity,
          //padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10,
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: items,
          )),
    );
  }
}

class DetailsItemsWidget extends StatelessWidget {
  const DetailsItemsWidget(
      {super.key, required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 0.5, color: Color(0xFF9198a2)))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
            ),
            Flexible(
              child: Text(
                subtitle,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
              ),
            )
          ],
        ));
  }
}
