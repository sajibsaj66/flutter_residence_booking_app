import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/utils/app_utils.dart';
import 'package:resid_plus_user/view/screen/search/search_model/search_model.dart';
import 'package:resid_plus_user/view/screen/search/search_repo/search_repo.dart';

class SearchResidenceController extends GetxController {

  SearchResidenceRepo searchResidenceRepo;
  SearchResidenceController({required this.searchResidenceRepo});

  bool isLoading = false;
  SearchModel searchModel = SearchModel();
  List<Residences> searchList = [];

  TextEditingController searchEditingController = TextEditingController();

  Future<void> searchedResidence({required String search}) async {
    searchList.clear();
    isLoading = true;
    update();

    ApiResponseModel responseModel = await searchResidenceRepo.mySearchedResidence(search: search);
    if (responseModel.statusCode == 200) {
      searchModel = SearchModel.fromJson(jsonDecode(responseModel.responseJson));
      searchList.clear();
      List<Residences>? tempList = searchModel.data?.attributes?.residences;
      if(tempList != null && tempList.isNotEmpty){
        searchList.addAll(tempList);
      }
    } else {
      Utils.toastMessage("Something went wrong");
    }

    isLoading = false;
    update();
  }


  Future<void> addFavoriteResult({required String id}) async {
    ApiResponseModel responseModel = await searchResidenceRepo.addFavoriteResponse(id: id);
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
      var data = jsonDecode(responseModel.responseJson);
      Utils.toastMessageCenter(data['message']);
    }else if (responseModel.statusCode == 201) {
      var data = jsonDecode(responseModel.responseJson);
      Utils.toastMessageCenter(data['message']);
    }else {
      Utils.toastMessageCenter(responseModel.message);
    }
  }
}
