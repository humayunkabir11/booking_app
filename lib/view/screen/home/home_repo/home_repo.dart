import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:resid_plus_user/core/global/api_response_method.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/core/global/api_url_container.dart';
import 'package:resid_plus_user/core/helper/shared_preference_helper.dart';
import 'package:resid_plus_user/service/api_service.dart';
import 'package:http/http.dart' as http;

class HomeRepo{
  ApiService apiService;
  HomeRepo({required this.apiService});

  Future<ApiResponseModel> allHotelResponse(String ? country,String ? pageNo) async{
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.allHotelEndPoint}?category=656184a880b6b1c2ef30998a&requestType=all&country=$country&page=$pageNo";
    String requestMethod = ApiResponseMethod.getMethod;
    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, null, passHeader: true);
    return responseModel;
  }

  ///======================all  residence ================

  Future<ApiResponseModel> allResidenceResponse(String ? country,String ? pageNo) async{
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.allHotelEndPoint}?category=656184a880b6b1c2ef30998b&requestType=all&country=$country&page=$pageNo";
    String requestMethod = ApiResponseMethod.getMethod;
    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ApiResponseModel> allPersonalHouseResponse(String ? country,String ?pageNo) async{
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.allHotelEndPoint}?category=656184a880b6b1c2ef30998c&requestType=all&country=$country&page=$pageNo";
    String requestMethod = ApiResponseMethod.getMethod;
    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ApiResponseModel> newHotelResponse() async{
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.allHotelEndPoint}?category=656184a880b6b1c2ef30998a&requestType=new";
    String requestMethod = ApiResponseMethod.getMethod;
    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, null, passHeader: true);

    print("Response: ${responseModel.responseJson.toString()}");
    return responseModel;
  }

  Future<ApiResponseModel> newResidenceResponse() async{
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.allHotelEndPoint}?category=656184a880b6b1c2ef30998b&requestType=new";
    String requestMethod = ApiResponseMethod.getMethod;
    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ApiResponseModel> newPersonalHouseResponse() async{
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.allHotelEndPoint}?category=656184a880b6b1c2ef30998c&requestType=new";
    String requestMethod = ApiResponseMethod.getMethod;
    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ApiResponseModel> popularHotelResponse() async{
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.allHotelEndPoint}?category=656184a880b6b1c2ef30998a&requestType=popular";
    String requestMethod = ApiResponseMethod.getMethod;
    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ApiResponseModel> popularResidenceResponse() async{
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.allHotelEndPoint}?category=656184a880b6b1c2ef30998b&requestType=popular";
    String requestMethod = ApiResponseMethod.getMethod;
    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ApiResponseModel> popularPersonalHouseResponse() async{
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.allHotelEndPoint}?category=656184a880b6b1c2ef30998c&requestType=popular";
    String requestMethod = ApiResponseMethod.getMethod;
    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ApiResponseModel> addFavoriteResponse({required String id}) async{
    String? t = apiService.sharedPreferences.getString(SharedPreferenceHelper.accessTokenKey);
    String? tType = apiService.sharedPreferences.getString(SharedPreferenceHelper.accessTokenType);
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.addFavoriteEndPoint}";
    Map<String, String> params = {
      "residenceId" : id
    };
    Map<String, String> head = {
      "Content-Type": "application/json",
      "Authorization": "$tType $t",
    };
    if (kDebugMode) {
      print(uri);
    }
    if (kDebugMode) {
      print(params);
    }
    http.Response response = await http.post(Uri.parse(uri), body: jsonEncode(params), headers: head);
    ApiResponseModel responseModel = ApiResponseModel(200, 'Success', response.body);
    return responseModel;
  }

  Future<ApiResponseModel> profileRepo() async {

    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.profile}/${apiService.sharedPreferences.getString(SharedPreferenceHelper.userIdKey)}";
    String requestMethod = ApiResponseMethod.getMethod;

    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, null, passHeader: true);

    return responseModel;
  }


  responseCountry() async{
    String uri ="${ApiUrlContainer.baseUrl}${ApiUrlContainer.countryEndpoint}";
    String requestMethod =  ApiResponseMethod.getMethod;
    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, null, passHeader: true);

    return responseModel;
  }
}