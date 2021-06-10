import 'package:get/state_manager.dart';
import 'package:input_store_app/features/auth/models/user.dart';
import 'package:input_store_app/user_storage.dart';
import 'package:input_store_app/features/auth/api/auth_api.dart';

class AuthController extends GetxController {
  AuthAPI _authAPI;

  RxBool _isLoading;
  bool get isLoading => _isLoading.value;
  set isLoading(bool isLoading) => _isLoading.value = isLoading;

  RxString _username;
  String get username => _username.value;
  set username(String username) => _username.value = username;

  RxString _password;
  String get password => _password.value;
  set password(String password) => _password.value = password;


  RxString _barcode;
  String get barcode => _barcode.value;
  set barcode(String barcode) => _barcode.value = barcode;

  RxBool _visible;
  bool get visible => _visible.value;
  set visible(bool visible) => _visible.value = visible;


  RxBool _isError;
  bool get isError => _isError.value;
  set isError(bool isError) => _isError.value = isError;

  RxString _message;
  String get message => _message.value;
  set message(String message) => _message.value = message;

  RxList<String> _usernameList;
  RxList<String> get usernameList => _usernameList;


  @override
  void onInit() {      
    super.onInit();
    _authAPI = new AuthAPI();

    _username = ''.obs;
    _password = ''.obs;
    _barcode = ''.obs;
    _isLoading = false.obs;
    _visible = false.obs;

    _isError = false.obs;
    _message = ''.obs;

    _usernameList = <String>[].obs;     
  }

  @override
  void onReady() async {
    super.onReady();
    _isLoading.value = true;
    await loadUsernames(0, 1);
    _isLoading.value = false;
  }

  Future loadUsernames(int offset, int state) async {
    final getUsers = await _authAPI.getUsers(offset, state);

    if(getUsers['ok']) {
      if(getUsers['result'].length != 0) {
        _usernameList.clear();
        List<User> userList = getUsers['result'];
        for(var i=0; i<userList.length; i++) {
          _usernameList.add(userList[i].username);          
        }
        _username.value = userList[0].username;
      }
    }   
  }


  Future<Map<String, dynamic>> logIn(String username, String password) async {
    var login = await _authAPI.logIn(username, password);
    _message.value = login['message'];
    UserStorage.user = login['user'];
    return login;
  }

}