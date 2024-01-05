import 'package:resid_plus_user/core/global/api_response_method.dart';
import 'package:resid_plus_user/core/global/api_response_model.dart';
import 'package:resid_plus_user/core/global/api_url_container.dart';
import 'package:resid_plus_user/service/api_service.dart';

class BookingRepo{
  ApiService apiService;
  BookingRepo({required this.apiService});

  Future<ApiResponseModel> deleteResidence({required String id}) async {
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.deleteResidenceEndPoint}$id";
    String requestMethod = ApiResponseMethod.deleteMethod;
    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, null, passHeader: true);
    return responseModel;
  }
}