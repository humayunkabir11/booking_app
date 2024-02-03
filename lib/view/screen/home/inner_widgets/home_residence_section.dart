import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/service/api_service.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/view/screen/home/home_controller/home_controller.dart';
import 'package:resid_plus_user/view/screen/home/home_repo/home_repo.dart';


class HomeResidenceSection extends StatefulWidget {
  const HomeResidenceSection({super.key});

  @override
  State<HomeResidenceSection> createState() => _HomeResidenceSectionState();
}

String residenceName = "Residence";

class _HomeResidenceSectionState extends State<HomeResidenceSection> {

@override
  void initState() {

    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(HomeRepo(apiService: Get.find()));
    Get.put(HomeController(homeRepo: Get.find(), apiService: Get.find()));
    final controller = Get.put(HomeController(homeRepo: Get.find(), apiService: Get.find()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(

                "Residence".tr,
                style: GoogleFonts.raleway(
                  color: const Color(0xFF333333),

                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              /*GestureDetector(
                  onTap: () => Get.toNamed(AppRoute.seeAllScreen,
                      arguments: [
                        residenceName,
                        controller.allResidencesDataList
                      ]),
                  child: Text(
                    "seeAll".tr,
                    style: GoogleFonts.raleway(
                      color: const Color(0xFF333333),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),*/
            ],
          ),
          const SizedBox(height: 16),
          ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.dataLoading
                ? controller.allResidencesDataList.length + 1
                : controller.allResidencesDataList.length,
            itemBuilder: (context, index) {
              if (index<controller.allResidencesDataList.length){
                return  GestureDetector(
                  onTap: () => Get.toNamed(AppRoute.residenceDetailsScreen,
                      arguments: [controller.allResidencesDataList, index]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: 360,
                        padding: const EdgeInsetsDirectional.only(top: 4, end: 4),
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: NetworkImage(controller.allResidencesDataList[index].photo![0].publicFileUrl ?? ""),
                            fit: BoxFit.fill,
                          ),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    controller.allResidencesDataList[index].residenceName ?? "",
                                    maxLines: 1,overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.raleway(
                                      color: const Color(0xFF333333),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.star, color: Color(0xFFFBA91D), size: 18),
                                    const SizedBox(width: 4),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '(',
                                            style: GoogleFonts.raleway(
                                              color: const Color(0xFF333333),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '${controller.allResidencesDataList[index].ratings}',
                                            style: GoogleFonts.openSans(
                                              color: const Color(0xFF333333),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          TextSpan(
                                            text: ')',
                                            style: GoogleFonts.raleway(
                                              color: const Color(0xFF333333),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                SvgPicture.asset("assets/icons/location.svg"),
                                const SizedBox(width: 4),
                                Text(
                                  controller.allResidencesDataList[index].city ?? "",
                                  maxLines: 1,overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.raleway(
                                    color: const Color(0xFF818181),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                );
              }
              else {
                return const Center(
                    child: CircularProgressIndicator(color: AppColors.blackPrimary,));
              }
            },
          ),
        ],
      ),
    );
  }
}
