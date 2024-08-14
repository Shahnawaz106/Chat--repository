import 'package:chats/common/entities/entities.dart';
import 'package:chats/common/routes/routes.dart';
import 'package:chats/common/store/user.dart';
import 'package:chats/common/utils/utils.dart';
import 'package:chats/pages/frame/sign_in/index.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInController extends GetxController {
  SignInController();
  final state = SignInState();

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['openid']);

  void handleSignIn(String type) async {
    //1:email 2:google 3:facebook 4:apple 5:phone
    try {
      if (type == 'phone number') {
        if (kDebugMode) {
          print('...you are loggin in with phone number...');
        }
      } else if (type == 'google') {
        var user = await _googleSignIn.signIn();
        if (user != null) {
          String? displayName = user.displayName;
          String email = user.email;
          String id = user.id;
          String photoUrl = user.photoUrl ?? 'assets/icons/google.png';
          LoginRequestEntity loginPanelListRequestEntity = LoginRequestEntity();
          loginPanelListRequestEntity.avatar = photoUrl;
          loginPanelListRequestEntity.name = displayName;
          loginPanelListRequestEntity.email = email;
          loginPanelListRequestEntity.open_id = id;
          loginPanelListRequestEntity.type = 2;
          asyncPostAllData();
        }
      } else {
        if (kDebugMode) {
          print('...login type not sure...');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('...error with login $e');
      }
    }
  }
  asyncPostAllData() async {
    /*
     first save in the database
     second save in the local storage
     */
    print('...lets\'s go to message page...');
    var response = await HttpUtil().get('/api/index');
    print(response);
    UserStore.to.setIsLogin = true;
    Get.offAllNamed(AppRoutes.Message);
  }
}
