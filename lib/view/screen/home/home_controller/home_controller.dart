import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/core/global/api_url_container.dart';
import 'package:resid_plus_user/service/api_service.dart';
import 'package:resid_plus_user/utils/app_utils.dart';
import 'package:resid_plus_user/view/screen/auth/sign_up/contry_model/country_model.dart';
import 'package:resid_plus_user/view/screen/home/home_model/home_model.dart';
import 'package:resid_plus_user/view/screen/home/home_repo/home_repo.dart';
import 'package:resid_plus_user/view/screen/profile/profile_model/profile_model.dart';
import 'package:resid_plus_user/view/screen/residence_reservation/residence_reservation_model/residence_reservation_model.dart';

import '../../../../core/global/api_response_method.dart';

class HomeController extends GetxController {

  HomeModel homeModel = HomeModel();
  List<Residence> allHotelDataList = [];
  List<Residence> allResidencesDataList = [];
  List<Residence> allPersonalHouseDataList = [];
  List<Residence> newHotelDataList = [];
  List<Residence> newResidencesDataList = [];
  List<Residence> newPersonalHouseDataList = [];
  List<Residence> popularHotelDataList = [];
  List<Residence> popularResidencesDataList = [];
  List<Residence> popularPersonalHouseDataList = [];
  /// <===============pagination controller================>
  ///-------------------------------All Home Pagination -------------------------------____>
  bool hotelLoading = false;
  int hotelPage = 1;
  var isLoadMoreHotel = false;
  var  hotelTotalPage = (-1);
  var hotelCurrentPage = (-1);
  ScrollController hotelScrollController = ScrollController();

  hotelLoadMoreDat() async {
    print("load more");
    print("total Page $hotelTotalPage");
    print("current Page $hotelCurrentPage");
    print(hotelLoading);
    print(isLoadMoreHotel);
    if ( hotelLoading != true && isLoadMoreHotel == false && hotelTotalPage != hotelCurrentPage) {
      isLoadMoreHotel=true;
      update();
      hotelPage += 1;
      if (kDebugMode) {
        print("current Page $hotelCurrentPage");
      }
      // ApiResponseModel response = await apiService.request("${ApiUrlContainer.allResidenceEndPoint}?page=$residencePage",
      //     ApiResponseMethod.getMethod,
      //     null,
      //     passHeader: true);

      ApiResponseModel response =
      await homeRepo.allResidenceResponse(country, hotelPage.toString());
      if (response.statusCode == 200) {
        final HomeModel demoModel=  HomeModel.fromJson(jsonDecode(response.responseJson));
        hotelTotalPage=demoModel.data!.attributes!.pagination!.totalPage!;
        hotelCurrentPage=demoModel.data!.attributes!.pagination!.currentPage!;
        List<Residence>? tempList = demoModel.data?.attributes?.residences;
        if (tempList != null && tempList.isNotEmpty) {
          allHotelDataList.addAll(tempList);
          update();
        }
      } else {
        print("error  Page ${response.responseJson}");
        hotelPage =hotelPage - 1;
        // ApiChecker.checkApi(response);
      }
      isLoadMoreHotel=false;
    }
  }

  void hotelScrollListener() {
    if (hotelScrollController.position.pixels ==
        hotelScrollController.position.maxScrollExtent) {
      hotelLoadMoreDat();
      debugPrint("Residence Scroll Position change --------- ${hotelScrollController.position.pixels}");
    }
  }

  ///  <---------------------------- allResidencesDataList Pagination ----------------------------->

  bool isLoading = false;
  int residencePage = 1;
  var isLoadMoreResidence = false;
  var residenceTotalPage = (-1);
  var residenceCurrentPage = (-1);
   ScrollController residenceScrollController = ScrollController();
   String country = "";
   // var pageNum=1;

  bool dataLoading = false;

  ApiService apiService;

  /*fastLoad() async {
    residencePage = 1;
    isLoading=true;
    // update();
    // ApiResponseModel response = await apiService.request(
    //     "${ApiUrlContainer.allResidenceEndPoint}?page=$page", ApiResponseMethod.getMethod, null, passHeader: true);
    //
    //
    // if (response.statusCode == 200) {
    //   currentPage = homeModel.data!.attributes!.pagination!.currentPage!;
    //   totalPage = homeModel.data!.attributes!.pagination!.totalPage!;
    //
    //   for (int i = 0; i < allResidencesDataList.length; i++) {}
    //
    //   setRxRequestStatus(Status.completed);
    // }

  }*/

  loadMore() async {
    print("load more");
    print("total Page $residenceTotalPage");
    print("current Page $residenceCurrentPage");
    print(isLoading);
    print(isLoadMoreResidence);
    if ( isLoading != true && isLoadMoreResidence == false && residenceTotalPage != residenceCurrentPage) {
      isLoadMoreResidence=true;
      update();
      residencePage += 1;
      print("current Page ${residenceCurrentPage}");
      // ApiResponseModel response = await apiService.request("${ApiUrlContainer.allResidenceEndPoint}?page=$residencePage",
      //     ApiResponseMethod.getMethod,
      //     null,
      //     passHeader: true);

      ApiResponseModel response =
      await homeRepo.allResidenceResponse(country, residencePage.toString());
      if (response.statusCode == 200) {
        final HomeModel demoModel=  HomeModel.fromJson(jsonDecode(response.responseJson));
        residenceTotalPage=demoModel.data!.attributes!.pagination!.totalPage!;
        residenceCurrentPage=demoModel.data!.attributes!.pagination!.currentPage!;
        List<Residence>? tempList = demoModel.data?.attributes?.residences;
        if (tempList != null && tempList.isNotEmpty) {
          allResidencesDataList.addAll(tempList);
          update();
        }
      } else {
        print("error  Page ${response.responseJson}");
        residencePage =residencePage - 1;
        // ApiChecker.checkApi(response);
      }
      isLoadMoreResidence=false;
    }
  }

  void addScrollListener() {
    if (residenceScrollController.position.pixels ==
        residenceScrollController.position.maxScrollExtent) {
      loadMore();
      debugPrint("Residence Scroll Position change --------- ${residenceScrollController.position.pixels}");
    }
  }
/// <------------------------------Personal house data List ---------------------------------->

  bool personalHouseIsLoading = false;
  int personalHousePage = 1;
  var isLoadMorePersonalHouse = false;
  var personalHouseTotalPage = (-1);
  var personalHouseCurrentPage = (-1);
  ScrollController personalHouseScrollController = ScrollController();

  // var pageNum=1;





  /*fastLoad() async {
    residencePage = 1;
    isLoading=true;
    // update();
    // ApiResponseModel response = await apiService.request(
    //     "${ApiUrlContainer.allResidenceEndPoint}?page=$page", ApiResponseMethod.getMethod, null, passHeader: true);
    //
    //
    // if (response.statusCode == 200) {
    //   currentPage = homeModel.data!.attributes!.pagination!.currentPage!;
    //   totalPage = homeModel.data!.attributes!.pagination!.totalPage!;
    //
    //   for (int i = 0; i < allResidencesDataList.length; i++) {}
    //
    //   setRxRequestStatus(Status.completed);
    // }

  }*/

  personalHouseloadMoreData() async {
    print("load more");
    print("total Page $residenceTotalPage");
    print("current Page $residenceCurrentPage");
    print(isLoading);
    print(isLoadMoreResidence);
    if ( isLoading != true && isLoadMoreResidence == false && residenceTotalPage != residenceCurrentPage) {
      isLoadMoreResidence=true;
      update();
      residencePage += 1;
      print("current Page ${residenceCurrentPage}");
      // ApiResponseModel response = await apiService.request("${ApiUrlContainer.allResidenceEndPoint}?page=$residencePage",
      //     ApiResponseMethod.getMethod,
      //     null,
      //     passHeader: true);

      ApiResponseModel response =
      await homeRepo.allResidenceResponse(country, residencePage.toString());
      if (response.statusCode == 200) {
        final HomeModel demoModel=  HomeModel.fromJson(jsonDecode(response.responseJson));
        residenceTotalPage=demoModel.data!.attributes!.pagination!.totalPage!;
        residenceCurrentPage=demoModel.data!.attributes!.pagination!.currentPage!;
        List<Residence>? tempList = demoModel.data?.attributes?.residences;
        if (tempList != null && tempList.isNotEmpty) {
          allResidencesDataList.addAll(tempList);
          update();
        }
      } else {
        print("error  Page ${response.responseJson}");
        residencePage =residencePage - 1;
        // ApiChecker.checkApi(response);
      }
      isLoadMoreResidence=false;
    }
  }

  void personalHouseScrollListener() {
    if (personalHouseScrollController.position.pixels ==
        personalHouseScrollController.position.maxScrollExtent) {
      personalHouseloadMoreData();
      debugPrint("Residence Scroll Position change --------- ${personalHouseScrollController.position.pixels}");
    }
  }


  HomeRepo homeRepo;
  HomeController({required this.homeRepo, required this.apiService});


  bool isSubmit = false;

  int selectedTabIndex = 0;

  Attribute dropdownCode = Attribute();
  Attribute selectedCountry = Attribute();
  List<Attribute> countyName = [];

  CountryModel countryModel = CountryModel();
  Future<void> getCountry() async {
    isSubmit = true;
    ApiResponseModel responseModel = await homeRepo.responseCountry();
    if (responseModel.statusCode == 200) {
      countryModel = CountryModel.fromJson(jsonDecode(responseModel.responseJson));
      countyName = countryModel.data!.attributes!;
      selectedCountry = countyName[0];
      dropdownCode = countyName[0];
      allHotelData(dropdownCode.id);
      isSubmit = false;
      update();
    }
  }

  void changeTabValue(int index) {
    selectedTabIndex = index;
    initialState();
    update();
  }



  void initialState() async {
    print("--------------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>${dropdownCode.id}");

    allHotelDataList.clear();
    allResidencesDataList.clear();
    allPersonalHouseDataList.clear();

    newHotelDataList.clear();
    newResidencesDataList.clear();
    newPersonalHouseDataList.clear();

    popularHotelDataList.clear();
    popularResidencesDataList.clear();
    popularPersonalHouseDataList.clear();

    isLoading = true;
    update();

    debugPrint("Selected: $selectedTabIndex");

    if (selectedTabIndex == 0) {
      await allHotelData(dropdownCode.id);
    }

    if (selectedTabIndex == 1) {
      await allResidencesData(dropdownCode.id);
    }

    if (selectedTabIndex == 2) {
      await allPersonalHouseData(dropdownCode.id);
    }
    isLoading = false;
    update();
  }


  ///  <-----------------  Hotel All Data ----------->


  Future<void> allHotelData(String? countryID) async {
    hotelPage = 1;
    ApiResponseModel responseModel =
        await homeRepo.allHotelResponse("$countryID", hotelPage.toString());

    if (responseModel.statusCode == 200) {
      homeModel = HomeModel.fromJson(jsonDecode(responseModel.responseJson));

      List<Residence>? tempList = homeModel.data?.attributes?.residences;
      if (tempList != null && tempList.isNotEmpty) {
        allHotelDataList.addAll(tempList);
        country = countryID.toString();
        update();
      }
    } else {
      debugPrint("Error");
    }
  }
///  <-----------------  All residences Data ----------->
  Future<void> allResidencesData(String? countryID) async {
    residencePage = 1;
    ApiResponseModel responseModel =
        await homeRepo.allResidenceResponse(countryID, residencePage.toString());

    if (responseModel.statusCode == 200) {
      homeModel = HomeModel.fromJson(jsonDecode(responseModel.responseJson));
      List<Residence>? tempList = homeModel.data?.attributes?.residences;
      residenceTotalPage=homeModel.data!.attributes!.pagination!.totalPage!;
      residenceCurrentPage=homeModel.data!.attributes!.pagination!.currentPage!;
      update();
      if (tempList != null && tempList.isNotEmpty) {
        allResidencesDataList.addAll(tempList);
        country = countryID.toString();
        update();
      }
    } else {
      debugPrint("Error");
    }
  }

  ///  <----------------- Personal House Data ----------->

  Future<void> allPersonalHouseData(String? countryID) async {
    personalHousePage = 1;
    ApiResponseModel responseModel = await homeRepo.allPersonalHouseResponse(
        "$countryID", personalHousePage.toString());

    if (responseModel.statusCode == 200) {
      homeModel = HomeModel.fromJson(jsonDecode(responseModel.responseJson));
      List<Residence>? tempList = homeModel.data?.attributes?.residences;
      if (tempList != null && tempList.isNotEmpty) {
        allPersonalHouseDataList.addAll(tempList);
        country = countryID.toString();
        update();
      }
    } else {
      debugPrint("Error");
    }
  }


  //
  //
  // Future<void> newHotelData() async {
  //   ApiResponseModel responseModel = await homeRepo.newHotelResponse();
  //
  //   if (responseModel.statusCode == 200) {
  //     homeModel = HomeModel.fromJson(jsonDecode(responseModel.responseJson));
  //     List<Residence>? tempList = homeModel.data?.attributes?.residences;
  //     if (tempList != null && tempList.isNotEmpty) {
  //       newHotelDataList.addAll(tempList);
  //       update();
  //     }
  //   } else {
  //     debugPrint("Error");
  //   }
  // }
  //
  // Future<void> newResidencesData() async {
  //   ApiResponseModel responseModel = await homeRepo.newResidenceResponse();
  //
  //   if (responseModel.statusCode == 200) {
  //     homeModel = HomeModel.fromJson(jsonDecode(responseModel.responseJson));
  //     List<Residence>? tempList = homeModel.data?.attributes?.residences;
  //     if (tempList != null && tempList.isNotEmpty) {
  //       newResidencesDataList.addAll(tempList);
  //       update();
  //     }
  //   } else {
  //     debugPrint("Error");
  //   }
  // }
  //
  // Future<void> newPersonalHouseData() async {
  //   ApiResponseModel responseModel = await homeRepo.newPersonalHouseResponse();
  //
  //   if (responseModel.statusCode == 200) {
  //     homeModel = HomeModel.fromJson(jsonDecode(responseModel.responseJson));
  //     List<Residence>? tempList = homeModel.data?.attributes?.residences;
  //     if (tempList != null && tempList.isNotEmpty) {
  //       newPersonalHouseDataList.addAll(tempList);
  //       update();
  //     }
  //   } else {
  //     debugPrint("Error");
  //   }
  // }
  //
  // Future<void> popularHotelData() async {
  //   ApiResponseModel responseModel = await homeRepo.popularHotelResponse();
  //
  //   if (responseModel.statusCode == 200) {
  //     homeModel = HomeModel.fromJson(jsonDecode(responseModel.responseJson));
  //     List<Residence>? tempList = homeModel.data?.attributes?.residences;
  //     if (tempList != null && tempList.isNotEmpty) {
  //       popularHotelDataList.addAll(tempList);
  //       update();
  //     }
  //   } else {
  //     debugPrint("Error");
  //   }
  // }
  //
  // Future<void> popularResidencesData() async {
  //   ApiResponseModel responseModel = await homeRepo.popularResidenceResponse();
  //
  //   if (responseModel.statusCode == 200) {
  //     homeModel = HomeModel.fromJson(jsonDecode(responseModel.responseJson));
  //     List<Residence>? tempList = homeModel.data?.attributes?.residences;
  //     if (tempList != null && tempList.isNotEmpty) {
  //       popularResidencesDataList.addAll(tempList);
  //       update();
  //     }
  //   } else {
  //     debugPrint("Error");
  //   }
  // }
  //
  // Future<void> popularPersonalHouseData() async {
  //   ApiResponseModel responseModel =
  //       await homeRepo.popularPersonalHouseResponse();
  //
  //   if (responseModel.statusCode == 200) {
  //     homeModel = HomeModel.fromJson(jsonDecode(responseModel.responseJson));
  //     List<Residence>? tempList = homeModel.data?.attributes?.residences;
  //     if (tempList != null && tempList.isNotEmpty) {
  //       popularPersonalHouseDataList.addAll(tempList);
  //       update();
  //     }
  //   } else {
  //     debugPrint("Error");
  //   }
  // }

  Future<void> addFavoriteResult({required String id}) async {
    ApiResponseModel responseModel = await homeRepo.addFavoriteResponse(id: id);
    if (kDebugMode) {
      print("status code: ${responseModel.statusCode}");
    }
    if (kDebugMode) {
      print("status code: ${responseModel.message}");
    }
    if (kDebugMode) {
      print("status code: ${responseModel.responseJson}");
    }

    if (responseModel.statusCode == 200) {
      Utils.snackBar("Successful".tr, "Add to favorite successful".tr);
    } else if (responseModel.statusCode == 201) {
      Utils.snackBar("Successful".tr, "Add to favorite successful".tr);
    } else {
      Utils.snackBar("Error".tr, "Failed add to favorite".tr);
    }
  }

  String img = "";
  ProfileModel profileModel = ProfileModel();

  @override
  void onInit() {

    try {
       residenceScrollController.addListener(addScrollListener);
    } catch (e, stackTrace) {
      print('Error in onInit: $e\n$stackTrace');
    }
    super.onInit();
  }

  // @override
  // void dispose() {
  //   pageNum;
  //   super.dispose();
  // }

/*  Future<void> profile() async {
    ApiResponseModel responseModel = await homeRepo.profileRepo();

    if(responseModel.statusCode == 200) {
      profileModel = ProfileModel.fromJson(jsonDecode(responseModel.responseJson));
      img = profileModel.data!.attributes!.user!.image!.publicFileUrl!;

      isLoading = false;
      update();
    }else {
      ProfileModel profileModel = ProfileModel.fromJson(jsonDecode(responseModel.responseJson));
      Get.snackbar("Error", profileModel.message.toString(),snackPosition: SnackPosition.BOTTOM,colorText: AppColors.bgColor,backgroundColor: AppColors.black80);
      isLoading = false;
      update();
    }
  }*/
}

enum Status { loading, error, completed, internetError }
