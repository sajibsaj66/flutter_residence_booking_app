import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/view/screen/favorite/favorite_model/favorite_model.dart';
import 'package:resid_plus_user/view/screen/favorite/favorite_repo/favorite_repo.dart';

class FavoriteListController extends GetxController {
  FavoriteRepo favoriteRepo;
  FavoriteListController({required this.favoriteRepo});

  bool isLoading = false;

  FavoriteModel favoriteModel = FavoriteModel();

  Future<FavoriteModel> favoriteList() async {
    isLoading = true;
    update();
    ApiResponseModel responseModel = await favoriteRepo.favoriteList();

    if(responseModel.statusCode == 200) {
      favoriteModel = FavoriteModel.fromJson(jsonDecode(responseModel.responseJson));
      if (kDebugMode) {
        print(favoriteModel.data);
      }
      isLoading = false;
      update();

      if (kDebugMode) {
        print("$favoriteModel");
      }
    }else {
      isLoading = false;
      update();

      return FavoriteModel();
    }
    return favoriteModel;
  }
}