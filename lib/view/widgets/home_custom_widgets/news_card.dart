import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../resources/color_manager.dart';

class NewsCard extends StatelessWidget {

  String image;
  String title;
  String urlink;

  NewsCard({
    required this.image,
    required this.title,
    required this.urlink,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Stack(
              children: [
                Image.network(image, fit: BoxFit.fill),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.w),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      color: ColorManager.greyColor.withOpacity(0.6),
                      child: Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500
                          )
                      ),
                    ),
                  ),
                )
              ]
          ),
        ),

        onTap: () async{
          Uri url = Uri.parse(urlink);
          if (await canLaunchUrl(url)) {
          await launchUrl(url);
          } else {
          throw 'Could not launch $url';
          }
        }
    );
  }
}
