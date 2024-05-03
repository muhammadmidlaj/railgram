import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget loaderList() {
  return Shimmer.fromColors(
      period: const Duration(seconds: 3),
      baseColor: Colors.white,
      highlightColor: Colors.grey,
      child: ListView.builder(
        itemCount: 15,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.grey,
                ),
                title: Container(
                  height: 15,
                  width: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                subtitle: Container(
                  height: 15,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              ListTile(
                title: Container(
                  height: 15,
                  width: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                subtitle: Container(
                  height: 50,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              )
            ],
          );
        },
      ));
}
