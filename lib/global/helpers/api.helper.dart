import 'package:get/get.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'snackbar.helper.dart';

import 'storage.dart';

class ApiHelper extends GetConnect {
  // This is where you change your API Domain
  final String baseUrl = 'https://core.relaxury.io/api/';

  bool? enableLoader = false;
  bool? enableNotifier = false;

  ApiHelper({this.enableLoader, this.enableNotifier});

  Map<String, String> get headersAuth => {
        "Content-type": "application/json",
        'Authorization': Storage(StorageName.token).read() ?? "",
      };

  responseNotification(String url, Response response) {
    print("Api Address: " + baseUrl + url);
    print("Status Code: " + response.statusCode.toString());
    print("Response   : " + response.body.toString());

    if (response.statusCode == 200) {
      if (enableNotifier != null) {
        if (enableNotifier!) {
          AlertSnackbar.open(title: "Success", message: response.body['message'] ?? "Request finished successfully", status: AlertType.success);
        }
      }
    } else if (response.statusCode == 401) {
      AlertSnackbar.open(title: "Failed", message: response.body['message'] ?? "Access Token expired, please login again", status: AlertType.warning);
    } else {
      AlertSnackbar.open(title: "Failed", message: response.body['message'] ?? "Please try again", status: AlertType.danger);
    }
  }

  @override
  Future<Response<T>> get<T>(String url, {Map<String, String>? headers, String? contentType, Map<String, dynamic>? query, Decoder<T>? decoder}) async {
    // If enable loader
    if (enableLoader != null) if (enableLoader!) Get.dialog(GFLoader());

    Response<T> response = await super.get(url, headers: headersAuth, contentType: contentType, query: query, decoder: decoder);

    if (Get.isDialogOpen != null) if (Get.isDialogOpen!) Get.back();

    responseNotification(url, response);

    return response;
  }

  @override
  Future<Response<T>> post<T>(String? url, body, {String? contentType, Map<String, String>? headers, Map<String, dynamic>? query, Decoder<T>? decoder, Progress? uploadProgress}) async {
    // If enable loader
    if (enableLoader != null) if (enableLoader!) Get.dialog(GFLoader());

    Response<T> response = await super.post(url, body, contentType: contentType, headers: headersAuth, query: query, decoder: decoder, uploadProgress: uploadProgress);

    if (Get.isDialogOpen != null) if (Get.isDialogOpen!) Get.back();

    // If enable notifier
    if (enableNotifier != null) if (enableNotifier!) responseNotification(url!, response);

    return response;
  }

  @override
  void onInit() {
    httpClient.baseUrl = baseUrl;
    httpClient.timeout = Duration(seconds: 30);
  }
}
