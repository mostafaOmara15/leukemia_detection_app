import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leukemia_detection_app/view/resources/padding_manager.dart';
import 'package:leukemia_detection_app/view/screens/app_layout/home_screen/patients_history/patients_history.dart';
import 'package:leukemia_detection_app/view/screens/app_layout/test_screen/test_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../resources/color_manager.dart';
import '../../../widgets/home_custom_widgets/news_card.dart';
import 'leukemia_info/leukemia_info.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Padding(
        padding: PaddingManger.sidePadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 3.h),
              Text("Latest news...", style: TextStyle(color: ColorManager.blackColor, fontWeight: FontWeight.w500, fontSize: 16.sp)),
              SizedBox(height: 1.5.h),

              ImageSlideshow(
                width: double.infinity,
                height: 31.2.h,
                indicatorRadius: 4,
                initialPage: 0,
                indicatorColor: ColorManager.yellowColor,
                indicatorBackgroundColor: ColorManager.blackColor,
                autoPlayInterval: 3000,
                isLoop: true,
                children: [
                  NewsCard(
                    image:"https://www.cancer.gov/sites/g/files/xnrzdm211/files/styles/cgov_article/public/cgov_image/media_image/100/300/6/files/leukemia-aml-cells-article.jpg?h=3fdee236&itok=ByNP-X6j",
                    title:"Advances in Leukemia Research",
                    urlink:'https://www.cancer.gov/types/leukemia/research',
                  ),
                  NewsCard(
                    image:"https://cdn.cancercenter.com/-/media/ctca/images/others/blogs/2017/09-september/04-blog-leukemia-l.jpg?h=630&w=1200&hash=22E0114B12D2D61FE8D07C7B92972DB1",
                    title:"New leukemia treatment",
                    urlink:'https://www.cancercenter.com/community/blog/2017/09/new-leukemia-treatment-marks-shift-in-helping-the-body-to-fight-cancer',
                  ),
                  NewsCard(
                    image:"https://post.medicalnewstoday.com/wp-content/uploads/sites/3/2023/03/leukaemia_protein_Stocksy_txp6ce8be23U4f300_Medium_3823420_Header-1024x575.jpg",
                    title:"Acute leukemia: 30% of participants achieve remission with new drug",
                    urlink:'https://www.medicalnewstoday.com/articles/acute-leukemia-30-of-participants-achieve-remission-with-new-drug',
                  ),
                  InkWell(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 5.h,
                              backgroundColor: ColorManager.yellowColor,
                              child: Icon(
                                Icons.arrow_forward,
                                color: ColorManager.blackColor,
                                size: 7.w,
                              ),
                            ),
                            SizedBox(height: 1.h,),
                            Text(
                              "Read more from google",
                              style: TextStyle(
                                  color: ColorManager.blackColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                      onTap: () async{
                        Uri url = Uri.parse('https://www.google.com/search?q=leukemia+articles&sxsrf=APwXEdc-P2tv8k1q_eZiPC0wtVVjBD-dYg%3A1683769791211&ei=v0lcZPfGDO3jsAf9upygDw&oq=leukemia+ar&gs_lcp=Cgxnd3Mtd2l6LXNlcnAQARgAMggIABCABBDLATIICAAQgAQQywEyCAgAEIAEEMsBMggIABCABBDLATIICAAQgAQQywEyCAgAEIAEEMsBMggIABCABBDLATIICAAQgAQQywEyCAgAEIAEEMsBMggIABCABBDLAToKCAAQRxDWBBCwAzoFCAAQgAQ6DgguEIAEEMcBENEDEMsBSgQIQRgAUKQFWPIIYM8QaAJwAXgAgAF1iAHlAZIBAzAuMpgBAKABAcgBCMABAQ&sclient=gws-wiz-serp');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      }

                  ),
                ],
              ),
              SizedBox(height: 1.5.h),
              InkWell(
                child: Container(
                  height: 16.h,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/LeukemiaWBC_share (1).jpg")
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "What is leukemia?",
                      style: GoogleFonts.dmSerifDisplay(
                        textStyle: const TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    )
                  ),
                ),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => InformationScreen())),
              ),
              SizedBox(height: 1.5.h),

              InkWell(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TestScreen(),)),
                child: Container(
                  height: 16.h,
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Test a sample...",
                        style: GoogleFonts.gayathri(
                          textStyle: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Image.asset("assets/logo.png", color: Colors.white,),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 1.5.h),

              InkWell(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PatientsHistory())),
                child: Container(
                  height: 16.h,
                  width: double.infinity,
                  padding: const EdgeInsets.only(right: 10),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/history_pic.png")
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "View patients history",
                        style: GoogleFonts.dmSerifDisplay(
                          textStyle: const TextStyle(color: Color(0xff2a454e), fontSize: 22),
                        ),
                      )
                  ),
                ),
              ),
              SizedBox(height: 1.5.h),
            ]
          ),
        ),
      ),
    );
  }
}
