import 'package:awc_complaints_app/ApiCall/ApiCall.dart';
import 'package:awc_complaints_app/Model/MyComplaintsResponse.dart';
import 'package:flutter/cupertino.dart';

enum LoadMoreStatus { LOADING, STABLE }

class DataProvider with ChangeNotifier {
  ApiService? _apiService;
  MyComplaintsResponse? _myComplaintsResponse;
  int totalPages = 0;
  int pageSize = 25;

  List<ComplaintLists> get getAllComplaint =>
      _myComplaintsResponse!.data!.complaintLists!;

  double get totalRecords =>
      _myComplaintsResponse!.data!.pagination!.totalRecords!.toDouble();

  LoadMoreStatus _loadMoreStatus = LoadMoreStatus.STABLE;

  getLoadMoreStatus() => _loadMoreStatus;

  DataProvider() {
    _initStreams();
  }

  void _initStreams() {
    _apiService = ApiService();
    _myComplaintsResponse = MyComplaintsResponse();
  }

  void resetStreams() {
    _initStreams();
  }

  fetchAllComplaint(pageNumber) async {
    if ((totalPages == 0) || pageNumber <= totalPages) {
      MyComplaintsResponse itemModel =
          await _apiService!.my_complaint("56", "", "1");
      if (_myComplaintsResponse!.data == null) {
        totalPages =
            ((itemModel.data!.pagination!.totalRecords! - 1) / pageSize).ceil();
        _myComplaintsResponse = itemModel;
      } else {
        _myComplaintsResponse!.data!.complaintLists!
            .addAll(itemModel.data!.complaintLists!);
        _myComplaintsResponse = _myComplaintsResponse;

        // One load more is done will make it status as stable.
        setLoadingState(LoadMoreStatus.STABLE);
      }

      notifyListeners();
    }

    if (pageNumber > totalPages) {
      // One load more is done will make it status as stable.
      setLoadingState(LoadMoreStatus.STABLE);
      notifyListeners();
    }
  }

  setLoadingState(LoadMoreStatus loadMoreStatus) {
    _loadMoreStatus = loadMoreStatus;
    notifyListeners();
  }
}
