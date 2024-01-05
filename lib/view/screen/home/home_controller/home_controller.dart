import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/utils/app_colors.dart';
import 'package:resid_plus_user/utils/app_utils.dart';
import 'package:resid_plus_user/view/screen/home/home_model/home_model.dart';
import 'package:resid_plus_user/view/screen/home/home_repo/home_repo.dart';
import 'package:resid_plus_user/view/screen/profile/profile_model/profile_model.dart';

class HomeController extends GetxController {

  HomeRepo homeRepo;
  HomeController({required this.homeRepo});

  bool isLoading = false;

  List<String> tabList = ["All", "New", "Popular"];
  int selectedTabIndex = 0;

  void changeTabValue(int index) {
    selectedTabIndex = index;
    initialState();
    update();
  }

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

  void initialState() async{
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

    print("Selected: $selectedTabIndex");

    if(selectedTabIndex == 0){
      await allHotelData();
      await allResidencesData();
      await allPersonalHouseData();
    }

    if(selectedTabIndex == 1){
      await newHotelData();
      await newResidencesData();
      await newPersonalHouseData();
    }

    if(selectedTabIndex == 2){

      await popularHotelData();
      await popularResidencesData();
      await popularPersonalHouseData();
    }

    isLoading = false;
    update();
  }



  Future<void> allHotelData() async{

    ApiResponseModel responseModel = await homeRepo.allHotelResponse();

    if(responseModel.statusCode == 200){
      homeModel = HomeModel.fromJson(jsonDecode(responseModel.responseJson));

      List<Residence>? tempList = homeModel.data?.attributes?.residences;
      if(tempList != null && tempList.isNotEmpty){
        allHotelDataList.addAll(tempList);
      }
    }
    else{
      print("Error");
    }
  }

  Future<void> allResidencesData() async{

    ApiResponseModel responseModel = await homeRepo.allResidenceResponse();

    if(responseModel.statusCode == 200){
      homeModel = HomeModel.fromJson(jsonDecode(responseModel.responseJson));
      List<Residence>? tempList = homeModel.data?.attributes?.residences;
      if(tempList != null && tempList.isNotEmpty){
        allResidencesDataList.addAll(tempList);
      }
    }
    else{
      print("Error");
    }
  }


  Future<void> allPersonalHouseData() async{

    ApiResponseModel responseModel = await homeRepo.allPersonalHouseResponse();

    if(responseModel.statusCode == 200){
      homeModel = HomeModel.fromJson(jsonDecode(responseModel.responseJson));
      List<Residence>? tempList = homeModel.data?.attributes?.residences;
      if(tempList != null && tempList.isNotEmpty){
        allPersonalHouseDataList.addAll(tempList);
      }
    }
    else{
      print("Error");
    }
  }

  Future<void> newHotelData() async{

    ApiResponseModel responseModel = await homeRepo.newHotelResponse();

    if(responseModel.statusCode == 200){
      homeModel = HomeModel.fromJson(jsonDecode(responseModel.responseJson));
      List<Residence>? tempList = homeModel.data?.attributes?.residences;
      if(tempList != null && tempList.isNotEmpty){
        newHotelDataList.addAll(tempList);
      }
    }
    else{
      print("Error");
    }
  }

  Future<void> newResidencesData() async{

    ApiResponseModel responseModel = await homeRepo.newResidenceResponse();

    if(responseModel.statusCode == 200){
      homeModel = HomeModel.fromJson(jsonDecode(responseModel.responseJson));
      List<Residence>? tempList = homeModel.data?.attributes?.residences;
      if(tempList != null && tempList.isNotEmpty){
        newResidencesDataList.addAll(tempList);
      }
    }
    else{
      print("Error");
    }
  }

  Future<void> newPersonalHouseData() async{

    ApiResponseModel responseModel = await homeRepo.newPersonalHouseResponse();

    if(responseModel.statusCode == 200){
      homeModel = HomeModel.fromJson(jsonDecode(responseModel.responseJson));
      List<Residence>? tempList = homeModel.data?.attributes?.residences;
      if(tempList != null && tempList.isNotEmpty){
        newPersonalHouseDataList.addAll(tempList);
      }
    }
    else{
      print("Error");
    }
  }

  Future<void> popularHotelData() async{

    ApiResponseModel responseModel = await homeRepo.popularHotelResponse();

    if(responseModel.statusCode == 200){
      homeModel = HomeModel.fromJson(jsonDecode(responseModel.responseJson));
      List<Residence>? tempList = homeModel.data?.attributes?.residences;
      if(tempList != null && tempList.isNotEmpty){
        popularHotelDataList.addAll(tempList);
      }
    }
    else{
      print("Error");
    }
  }

  Future<void> popularResidencesData() async{

    ApiResponseModel responseModel = await homeRepo.popularResidenceResponse();

    if(responseModel.statusCode == 200){
      homeModel = HomeModel.fromJson(jsonDecode(responseModel.responseJson));
      List<Residence>? tempList = homeModel.data?.attributes?.residences;
      if(tempList != null && tempList.isNotEmpty){
        popularResidencesDataList.addAll(tempList);
      }
    }
    else{
      print("Error");
    }
  }

  Future<void> popularPersonalHouseData() async{

    ApiResponseModel responseModel = await homeRepo.popularPersonalHouseResponse();

    if(responseModel.statusCode == 200){
      homeModel = HomeModel.fromJson(jsonDecode(responseModel.responseJson));
      List<Residence>? tempList = homeModel.data?.attributes?.residences;
      if(tempList != null && tempList.isNotEmpty){
        popularPersonalHouseDataList.addAll(tempList);
      }
    }
    else{
      print("Error");
    }
  }


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
      var data = jsonDecode(responseModel.responseJson);
      Utils.toastMessageCenter(data['message']);
    }else if (responseModel.statusCode == 201) {
      var data = jsonDecode(responseModel.responseJson);
      Utils.toastMessageCenter(data['message']);
    }else {
      Utils.toastMessageCenter(responseModel.message);
    }
  }

  String img = "";
  ProfileModel profileModel = ProfileModel();

  Future<void> profile() async {
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
  }
}