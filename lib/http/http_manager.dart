//
//  http_manager
//  app_flutter
//
//  Created by dingyang on2021/7/14 .
//  Copyright ©2021/7/14 app_flutter. All rights reserved.

import 'dart:collection';

import 'package:app_flutter/http/code.dart';
import 'package:app_flutter/http/result_data.dart';
import 'package:app_flutter/log/logger.dart';
import 'package:app_flutter/log/pretty_dio_logger.dart';
import 'package:app_flutter/model/request/base_request.dart';
import 'package:app_flutter/model/response/base_response.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:package_info/package_info.dart';

class HttpManager {
  static BuildContext? context;

  // 单例公开访问点
  factory HttpManager() => getInstance(context);

  // 静态私有成员，没有初始化
  static HttpManager? _instance;
  static Dio? _dio;

  Map<String, int> loading = new Map(); //当前下载的进程

  // 私有构造函数
  HttpManager._() {
    // 具体初始化代码
  }

  // 静态、同步、私有访问点
  static HttpManager getInstance(BuildContext? mContext) {
    context = mContext;
    if (_dio == null) {
      _dio = new Dio();
      // _dio.interceptors.add(PrettyDioLogger());
// customization
      _dio!.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 70));
    }
    if (_instance == null) {
      _instance = HttpManager._();
    }
    return _instance!;
  }

  ///发起网络请求
  ///[ url] 请求url
  ///[ params] 请求参数
  ///[ header] 外加头
  ///[ option] 配置
  netFetch(url, BaseRequest baseRequest, BaseResponse baseResponse,
      {Map<String, String>? header,
        Options? option,
        noTip = false,
        netError = true}) async {
    if (baseRequest.isMock) {
      BaseResponse mockResp = baseResponse.buildMockResponse();

      return new ResultData(mockResp.jsonToResponse(mockResp.responseData),
          mockResp.responseIsSuccess, mockResp.responseCode);
    }
    //没有网络
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return new ResultData(
          Code.errorHandleFunction(Code.NETWORK_ERROR, "无网络", true),
          false,
          Code.NETWORK_ERROR);
    }

    Map<String, String> headers = new HashMap();
    if (header != null) {
      headers.addAll(header);
    }

    // if (await Utils.isLogin()) {
    //   UserInfo userInfo = await Utils.getUserInfo();
    //   headers["Authorization"] = "Bearer " + userInfo.access_token!;
    // }
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    //APP名称
    //版本名
    String version = packageInfo.version;
    headers['AppVersion'] = version; //app版本号
    // if (Platform.isIOS) {
    //   headers['AppPlatform'] = TDPlatform.IOS; //类型
    // } else if (Platform.isAndroid) {
    //   headers['AppPlatform'] = TDPlatform.ANDROID;
    // }

    if (option != null) {
      option.headers = headers;
    } else {
      option = new Options(method: "get");
      option.headers = headers;
    }

    ///超时
    option.sendTimeout = 15000;
    Response response;

    try {
//      _dio.interceptors.add(CookieManager(CookieJar()));
      response = await _dio!.request(url,
          data: await baseRequest.toJson() ?? {}, options: option);

      try {
//      if (option.contentType != null &&
//          option.contentType.primaryType == "text") {
//        return new ResultData(response.data, true, Code.SUCCESS);
//      } else {
//        var responseJson = response.data;
//        if (response.statusCode == 201 && responseJson["token"] != null) {
//          optionParams["authorizationCode"] = 'token ' + responseJson["token"];
//          await LocalStorage.save(
//              Config.TOKEN_KEY, optionParams["authorizationCode"]);
//        }
//      }

        if (response.data['code'] == Code.SUCCESS) {
          return new ResultData(
              baseResponse.jsonToResponse(response.data), true, Code.SUCCESS,
              headers: response.headers);
        }
      } catch (e) {
        Logger.e(e.toString() + url);
        return new ResultData(baseResponse.jsonToResponse(response.data), false,
            response.data['code'] ?? 0,
            headers: response.headers);
      }
      return new ResultData(
          Code.errorHandleFunction(
              response.data['code'], response.data['msg'], noTip),
          false,
          response.data['code']);
    } on DioError catch (e) {
      Response? errorResponse;
      if (e.response != null && e.response?.statusCode == Code.NO_PERMISSION) {
        // Utils.clearUserInfo();
        showToast("用户登录信息已过期,请重新登录", position: ToastPosition.bottom);
        // ResultData resultData = await NavigatorUtils.go2Login(context,
        //     isShow: false, isNeedGo2Home: true, function: (result) async {
        //   Logger.log("http error login result", result);
        //   if (Utils.isNotEmpty(result)) {
        //     ResultData resultData =
        //         await netFetch(url, baseRequest, baseResponse, header, option);
        //     return resultData;
        //   }
        // });

        // return resultData ?? new ResultData(null, false, 500);
        return new ResultData(null, false, 500);
      } else {
        if (e.type == DioErrorType.connectTimeout && netError) {
          errorResponse?.statusCode = Code.NETWORK_TIMEOUT;
          showToast("连接超时", position: ToastPosition.bottom);
          return;
        }

        Logger.e('请求异常: ' + e.toString());
        Logger.e('请求异常url: ' + url);
        var data;
        if (e.response != null) {
          data = e.response?.data;
          Logger.e('返回参数: ' + data.toString());
        } else {
          data = {"code": 500, "msg": "服务器异常"};
        }

        Logger.e("异常:" + errorResponse.toString());

        return new ResultData(
            Code.errorHandleFunction(data['code'], data['msg'], noTip),
            false,
            errorResponse?.statusCode);
      }
    }
  }

  // //下载图片
  // downloadPic(urlPath, {bool isAsset: false}) async {
  //   if (!await Permission.camera.request().isGranted) {
  //     showToast("没有相册权限", position: ToastPosition.bottom);
  //     return;
  //   }
  //   if (!await Permission.storage.request().isGranted) {
  //     showToast("没有存储权限", position: ToastPosition.bottom);
  //     return;
  //   }
  //   Uint8List imageBytes;
  //
  //   if (isAsset == true) {
  //     /// 保存资源图片
  //     ByteData bytes = await rootBundle.load(urlPath);
  //     imageBytes = bytes.buffer.asUint8List();
  //   } else {
  //     /// 保存网络图片
  //     CachedNetworkImage image = CachedNetworkImage(imageUrl: urlPath);
  //     DefaultCacheManager manager = DefaultCacheManager();
  //     Map<String, String>? headers = image.httpHeaders;
  //     File file = await manager.getSingleFile(
  //       image.imageUrl,
  //       headers: headers,
  //     );
  //     imageBytes = await file.readAsBytes();
  //   }
  //
  //   /// 保存图片
  //   final result = await ImageGallerySaver.saveImage(imageBytes);
  //
  //   return Utils.isNotEmpty(result);
  // }
  //
  // downloadFile(String urlPath, savePath) async {
  //   //去除http 或者https 标识
  //   String temp = urlPath.replaceAll("http://", "");
  //   temp = temp.replaceAll("https://", "");
  //
  //   int index = temp.lastIndexOf(".");
  //
  //   String fileName = temp.substring(0, index);
  //
  //   String saveFilePath = savePath + "/" + temp;
  //   if (loading.containsKey(fileName)) {
  //     //下载中
  //     Logger.i("in downloading ============");
  //     return false;
  //   } else {
  //     //未下载
  //     try {
  //       File file = new File(saveFilePath);
  //       bool isExist = await file.exists();
  //       if (isExist) return true;
  //       await _dio!.download(urlPath, saveFilePath,
  //           onReceiveProgress: (int count, int total) {},
  //           cancelToken: new CancelToken());
  //
  //       loading.remove(fileName);
  //       Logger.i("下载完成");
  //       return true;
  //     } on DioError catch (e) {
  //       loading.remove(fileName);
  //       return false;
  //     } catch (e) {
  //       return false;
  //     }
  //   }
  // }
}
