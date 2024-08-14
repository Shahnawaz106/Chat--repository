import 'package:chats/common/routes/names.dart';
import 'package:chats/common/store/user.dart';
import 'package:chats/pages/profile/state.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileController extends GetxController {
  ProfileController();
  final title = 'Chats';
  final state = ProfileState();



  Future<void> goLogout() async {
    await GoogleSignIn().signOut();
    await UserStore.to.onLogout();
  }
}
