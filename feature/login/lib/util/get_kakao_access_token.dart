import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

Future<String> getKakaoAccessToken() async {
  try {
    return await UserApi.instance.loginWithKakaoTalk().then(
      (value) => value.accessToken,
    );
  } catch (e) {
    return await UserApi.instance.loginWithKakaoAccount().then(
      (value) => value.accessToken,
    );
  }
}
