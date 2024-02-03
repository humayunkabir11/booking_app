import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:resid_plus_user/core/app_route.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/utils/app_utils.dart';
import 'package:resid_plus_user/view/screen/booking_details/booking_details_repo/booking_details_repo.dart';
import 'package:http/http.dart' as http;
import 'package:resid_plus_user/view/screen/payment/payment_method_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/global/api_url_container.dart';
import '../../../../core/helper/shared_preference_helper.dart';

class BookingController extends GetxController{
  BookingRepo bookingRepo;
  BookingController({required this.bookingRepo});

  Future deleteResidenceResult({required String id}) async {
    ApiResponseModel responseModel = await bookingRepo.deleteResidence(id: id);

    if (responseModel.statusCode == 201) {
      Utils.toastMessageCenter(responseModel.message);
      Get.offAndToNamed(AppRoute.homeScreen);
    } else {
      Utils.toastMessageCenter(responseModel.message);
    }
  }

  var paymentLoading = false.obs;

  paymentResidence({required String id,required String paymentType})async{
    try {
      paymentLoading(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? t = prefs.getString(SharedPreferenceHelper.accessTokenKey);
      String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.paymentTokenEndPoint}";
      var headers = {
        'Authorization': 'Bearer $t',
      };
        Map<String ,dynamic>  body={
          "bookingId":id,
          "paymentTypes":paymentType
        };
      debugPrint("=======>  payment Data : id $id,payment type : $paymentType");
      debugPrint("======> Url : $uri");
      debugPrint("======> headers : $headers");
      var response= await http.post(Uri.parse(uri),body:body,headers: headers);
      if(response.statusCode==201){
        var data=  jsonDecode(response.body);
        // Get.to(PaymentSelectMethod(paymentId:data['data']['attributes']['_id'], token:data['data']['attributes']['paymentData']['token'],));
        Get.to(PaymentMethodScreen(paymentId:data['data']['attributes']['_id'], token:data['data']['attributes']['token'] ?? "",));
      }else{
          var errorData= jsonDecode(response.body);
            Fluttertoast.showToast(msg:errorData['message']);
        debugPrint("error :${response.statusCode} ${response.body}");

      }
    } on Exception catch (e) {
      Fluttertoast.showToast(msg:e.toString());
      debugPrint("Error exception $e");
      // TODO
    }finally{
      paymentLoading(false);
    }


  }




}