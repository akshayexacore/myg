
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:travel_claim/configs/api_constants.dart';
import 'package:travel_claim/models/branch.dart';
import 'package:travel_claim/models/category.dart';
import 'package:travel_claim/models/claim_history.dart';
import 'package:travel_claim/models/employee.dart';
import 'package:travel_claim/models/employee.dart';
import 'package:travel_claim/models/notification.dart';
import 'package:travel_claim/models/success.dart';
import 'package:travel_claim/models/trip_type.dart';
import 'package:travel_claim/utils/api_base_helper.dart';
import 'package:travel_claim/utils/shared_preferences_data_provider.dart';

class MygRepository {
  late final ApiBaseHelper _api = ApiBaseHelper();
  late final _preferences = SharedPreferencesDataProvider();


  Future<BranchResponse> getBranches() async {
    final response = await _api.get(ApiConstants.branches,headers: {});
    return BranchResponse.fromJson(response);
  }

  Future<TripTypeResponse> getTripTypes() async {
    final response = await _api.get(ApiConstants.tripTypes,headers: {});
    return TripTypeResponse.fromJson(response);
  }

  Future<CategoryResponse> getCategories() async {
    final response = await _api.get(ApiConstants.categories,headers: {});
    return CategoryResponse.fromJson(response);
  }

  Future<EmployeeResponse> getEmployees({required String query}) async {
    final response = await _api.post(ApiConstants.employees,headers: {},body: {"emp_id":query});
    return EmployeeResponse.fromJson(response);
  }

  Future<EmployeeResponse> getApprovers() async {
    final response = await _api.get(ApiConstants.approvers,headers: {});
    return EmployeeResponse.fromJson(response);
  }

  Future<FileUploadResponse> uploadFile(String file) async {
    final response = await _api.postMultipart(ApiConstants.fileUpload,body: {}, headers: {},file: file,key: 'file');
    return FileUploadResponse.fromJson(response);
  }

  Future<PostResponse> saveClaim({required Map<String,dynamic> body}) async {
    Logger().i(body);
    final response = await _api.post(ApiConstants.tripClaim,headers: {},body: body);
    return PostResponse.fromJson(response);
  }

  Future<PostResponse> resubmitClaim({required Map<String,dynamic> body}) async {
    Logger().i(body);
    final response = await _api.post(ApiConstants.resubmitClaim,headers: {},body: body);
    return PostResponse.fromJson(response);
  }


  Future<ClaimHistoryResponse> getClaimHistory() async {
    final response = await _api.get(ApiConstants.history,headers: {});
    return ClaimHistoryResponse.fromJson(response);
  }

  Future<ClaimHistoryResponse> getClaimsForApproval() async {
    final response = await _api.get(ApiConstants.claimsForApproval,headers: {});
    return ClaimHistoryResponse.fromJson(response);
  }

  Future<PostResponse> rejectSingleClaimItem({required Map<String,dynamic> body}) async {
    final response = await _api.post(ApiConstants.rejectSingle,headers: {},body: body);
    return PostResponse.fromJson(response);
  }

  Future<PostResponse> removeSingleClaimItem({required Map<String,dynamic> body}) async {
    final response = await _api.post(ApiConstants.removeSingle,headers: {},body: body);
    return PostResponse.fromJson(response);
  }

  Future<PostResponse> sentForSpecialApproval({required Map<String,dynamic> body}) async {
    final response = await _api.post(ApiConstants.sentForSpecialApproval,headers: {},body: body);
    return PostResponse.fromJson(response);
  }

  Future<PostResponse> approveOrRejectAll({required Map<String,dynamic> body}) async {
    final response = await _api.post(ApiConstants.approveOrRejectAll,headers: {},body: body);
    return PostResponse.fromJson(response);
  }

  Future<PostResponse> specialApproveOrRejectAll({required Map<String,dynamic> body}) async {
    final response = await _api.post(ApiConstants.specialApproveOrRejectAll,headers: {},body: body);
    return PostResponse.fromJson(response);
  }

  Future<PostResponse> rejectSingleSpecialClaimItem({required Map<String,dynamic> body}) async {
    final response = await _api.post(ApiConstants.specialApproverRejectSingle,headers: {},body: body);
    return PostResponse.fromJson(response);
  }


  Future<NotificationResponse> getNotifications() async {
    final response = await _api.get(ApiConstants.notifications,headers: {});
    return NotificationResponse.fromJson(response);
  }

  Future<NotificationCountResponse> getNotificationCount() async {
    final response = await _api.get(ApiConstants.notificationsCount,headers: {});
    return NotificationCountResponse.fromJson(response);
  }

  Future<ClaimDetailResponse> getClaimDetail(String id) async {
    final response = await _api.post(ApiConstants.viewClaim,headers: {},body: {"trip_claim_id":id});
    return ClaimDetailResponse.fromJson(response);
  }

  Future<ClaimHistoryResponse> getClaimsForSpecialApproval() async {
    final response = await _api.get(ApiConstants.claimsForSpecialApproval,headers: {});
    return ClaimHistoryResponse.fromJson(response);
  }

/*Future<PostResponse> toggleFavorite(int id,bool favorite) async {
    final response = await _api.post('${ApiConstants.favorites}$id/${favorite?'favorite/' : 'unfavorite/'}',headers: {});
    return PostResponse.fromFavJson(response);
  }

  Future<BillUploadResponse> uploadBill(List<String> files, ValueChanged<int> onProgress,) async {
    final response =
    await _api.postMultipart(ApiConstants.uploadBill,body: {},
        files: files,key: 'images',baseUrl: 'https://api.centresquaremallkochi.com');
    return BillUploadResponse.fromJson(response);
  }*/

}
