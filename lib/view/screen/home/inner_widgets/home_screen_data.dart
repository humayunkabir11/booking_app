import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/view/screen/home/home_controller/home_controller.dart';
import 'package:resid_plus_user/view/screen/home/inner_widgets/home_hotel_section.dart';
import 'package:resid_plus_user/view/screen/home/inner_widgets/home_personal_house_section.dart';
import 'package:resid_plus_user/view/screen/home/inner_widgets/home_residence_section.dart';

class HomeScreenData extends StatefulWidget {
  const HomeScreenData({super.key});

  @override
  State<HomeScreenData> createState() => _HomeScreenDataState();
}

class _HomeScreenDataState extends State<HomeScreenData> {
  @override
  Widget build(BuildContext context) {

    List<String> tabList = ["Hotel".tr, "Residence".tr, "PersonalHouse".tr];

    return Scaffold(
      body: GetBuilder<HomeController>(
        builder: (controller) => Column(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 24),
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 8),
                decoration: ShapeDecoration(
                  color: const Color(0xFFFDFBFB),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 0.50, color: Color(0xFFE2E2E2)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    tabList.length,
                    (index) => Flexible(
                      child: GestureDetector(
                        onTap: () => controller.changeTabValue(index),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(10),
                          margin: index == 2
                              ? const EdgeInsetsDirectional.only(end: 0)
                              : const EdgeInsetsDirectional.only(end: 12),
                          decoration: ShapeDecoration(
                            gradient: index == controller.selectedTabIndex
                                ? const LinearGradient(
                                    begin: Alignment(-0.00, -1.00),
                                    end: Alignment(0, 1),
                                    colors: [
                                      Color(0xFF787878),
                                      Color(0xFF434343),
                                      Colors.black
                                    ],
                                  )
                                : const LinearGradient(
                                    begin: Alignment(-0.00, -1.00),
                                    end: Alignment(0, 1),
                                    colors: [
                                      Color(0xFFFDFBFB),
                                      Color(0xFFFDFBFB),
                                      Color(0xFFFDFBFB)
                                    ],
                                  ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Text(
                            tabList[index].tr,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.raleway(
                              color: index == controller.selectedTabIndex
                                  ? Colors.white
                                  : AppColors.blackPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            controller.selectedTabIndex == 0
                ? Flexible(
                    child: controller.allHotelDataList.isNotEmpty
                        ?  SingleChildScrollView(
                      controller: controller.hotelScrollController,
                            padding: const EdgeInsetsDirectional.only(start: 20, bottom: 24, end: 20),
                            physics: const BouncingScrollPhysics(),
                            child:  Column(
                              children: [
                                Column(
                                  children: [
                                    const HomeHotelSection(),
                                    if(controller.isLoadMoreHotel)
                                      const CircularProgressIndicator(color: AppColors.blackPrimary,),
                                    const SizedBox(height: 24),
                                  ],
                                ),
                                /*controller.allResidencesDataList.isNotEmpty
                              ? const Column(
                                  children: [
                                    HomeResidenceSection(),
                                    SizedBox(height: 24),
                                  ],
                                )
                              : Center(
                            child: Align(
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("assets/icons/empty.svg"),
                                  const SizedBox(height: 24),
                                  Text(
                                    "No Data Found".tr,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.raleway(
                                        fontSize: 16,
                                        color: AppColors.blackPrimary,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          controller.allPersonalHouseDataList.isNotEmpty
                              ? const Column(
                                children: [
                                  HomePersonalHouseSection(),
                                  SizedBox(height: 24),
                                ],
                              )
                              : Center(
                            child: Align(
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("assets/icons/empty.svg"),
                                  const SizedBox(height: 24),
                                  Text(
                                    "No Data Found".tr,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.raleway(
                                        fontSize: 16,
                                        color: AppColors.blackPrimary,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),*/
                              ],
                            ),
                          )
                        : Center(
                            child: Align(
                              alignment: Alignment.center,
                              child: SingleChildScrollView(
                                physics: const ClampingScrollPhysics(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset("assets/icons/empty.svg"),
                                    const SizedBox(height: 24),
                                    Text(
                                      "No Data Found".tr,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.raleway(
                                          fontSize: 16,
                                          color: AppColors.blackPrimary,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                  )
                : controller.selectedTabIndex == 1
                    ? Flexible(
                        child: controller.allResidencesDataList.isNotEmpty
                            ?  SingleChildScrollView(
                                controller:controller.residenceScrollController,
                                padding: const EdgeInsetsDirectional.only(start: 20, bottom: 24, end: 20),
                                physics: const BouncingScrollPhysics(),
                                child:  Column(
                                  children: [
                                    const HomeResidenceSection(),

                                    if(controller.isLoadMoreResidence)
                                      const CircularProgressIndicator(color: AppColors.blackPrimary,),
                                    const SizedBox(height: 24),
                                  ],
                                ),

                              )
                            : Center(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: SingleChildScrollView(
                                    physics: const ClampingScrollPhysics(),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                            "assets/icons/empty.svg"),
                                        const SizedBox(height: 24),
                                        Text(
                                          "No Data Found".tr,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.raleway(
                                              fontSize: 16,
                                              color: AppColors.blackPrimary,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                      )
                    : controller.selectedTabIndex == 2
                        ? Flexible(
                            child: controller.allPersonalHouseDataList.isNotEmpty
                                ?   SingleChildScrollView(
                                     controller: controller.personalHouseScrollController,
                                    padding: const EdgeInsetsDirectional.only(start: 20, bottom: 24, end: 20),
                                    physics: const BouncingScrollPhysics(),
                                    child:  Column(
                                      children: [
                                       const HomePersonalHouseSection(),

                                        if(controller.isLoadMorePersonalHouse)
                                          const CircularProgressIndicator(color: AppColors.blackPrimary,),
                                        const SizedBox(height: 24),
                                      ],
                                    ),
                                    /*Column(
                                  children: [
                                    controller.popularHotelDataList.isNotEmpty
                                        ? const Column(
                                            children: [
                                              HomePopularHotelSection(),
                                              SizedBox(height: 24),
                                            ],
                                          )
                                        : const SizedBox(),
                                    controller
                                            .popularResidencesDataList.isNotEmpty
                                        ? const Column(
                                            children: [
                                              HomePopularResidenceSection(),
                                              SizedBox(height: 24),
                                            ],
                                          )
                                        : const SizedBox(),
                                    controller.popularPersonalHouseDataList
                                            .isNotEmpty
                                        ? const HomePopularPersonalHouseSection()
                                        : const SizedBox(),
                                  ],
                                )*/
                                  )
                                : Center(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: SingleChildScrollView(
                                        physics: const ClampingScrollPhysics(),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset("assets/icons/empty.svg"),
                                            const SizedBox(height: 24),
                                            Text(
                                              "No Data Found".tr,
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.raleway(
                                                  fontSize: 16,
                                                  color: AppColors.blackPrimary,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                          )
                        : Center(
                            child: Align(
                              alignment: Alignment.center,
                              child: SingleChildScrollView(
                                physics: const ClampingScrollPhysics(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset("assets/icons/empty.svg"),
                                    const SizedBox(height: 24),
                                    Text(
                                      "No Data Found".tr,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.raleway(
                                          fontSize: 16,
                                          color: AppColors.blackPrimary,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
          ],
        ),
      ),
    );
  }
}
