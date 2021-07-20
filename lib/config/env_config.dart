//
//  env_config
//  app_flutter
//
//  Created by dingyang on2021/7/14 .
//  Copyright ©2021/7/14 app_flutter. All rights reserved.
///环境配置
class EnvConfig {
  ///服务器url
  final String? host;

  EnvConfig({this.host});
}

// 获取的配置信息
class Env {
  // 获取到当前环境
  static const appEnv = String.fromEnvironment(EnvName.envKey);

  // 开发环境
  static final EnvConfig _debugConfig = EnvConfig(
    host: "http://129.211.191.80:10003/app",
  );

  // 后端本地服务器
  static final EnvConfig _debugServerConfig = EnvConfig(
    host: "http://192.168.1.162:10003/app",
  );

  // 发布环境
  static final EnvConfig _releaseConfig = EnvConfig(
    host: "https://api.dzds.dianzedushu.com/app",
  );

  static EnvConfig get envConfig => _getEnvConfig();

// 根据不同环境返回对应的环境配置
  static EnvConfig _getEnvConfig() {
    switch (appEnv) {
      case EnvName.debug:
        return _debugConfig;
      case EnvName.debugServer:
        return _debugServerConfig;
      case EnvName.release:
        return _releaseConfig;

      default:
        return _releaseConfig;
    }
  }
}

// 声明的环境
abstract class EnvName {
  // 环境key
  static const String envKey = "DART_DEFINE_APP_ENV";

  // 环境value
  static const String debug = "debug";
  static const String release = "release";

  static const String debugServer = "debugServer";
}
