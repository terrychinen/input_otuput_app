import 'package:get/state_manager.dart';
import 'package:input_store_app/features/auth/models/user.dart';
import 'package:input_store_app/features/auth/api/auth_api.dart';
import 'package:input_store_app/features/environment/api/environment_api.dart';
import 'package:input_store_app/features/environment/models/models/environment.dart';

class GetUserController extends GetxController {
  AuthAPI _authAPI;
  EnvironmentAPI _environmentAPI;

  RxBool _loading;
  bool get loading => _loading.value;

  RxList<User> _userList;
  RxList<User> get userList => _userList;

  RxList<Environment> _environmentList;
  RxList<Environment> get environmentList => _environmentList;

  Rx<User> _userSelected;
  User get userSelected => _userSelected.value;
  set userSelected(User username) => _userSelected.value = username;

  Rx<Environment> _environmentSelected;
  Environment get environmentSelected => _environmentSelected.value;
  set environmentSelected(Environment environment) => 
    _environmentSelected.value = environment;

  @override
  void onInit() async {
    super.onInit();
    _authAPI = new AuthAPI();
    _environmentAPI = new EnvironmentAPI();

    _userList = <User>[].obs;
    _userSelected = new User().obs;

    _environmentList = <Environment>[].obs;
    _environmentSelected = new Environment().obs;

    _loading = true.obs;

    await loadUsers(0, 1);
    await loadEnvironments(0, 1);

    _loading.value = false;

    if(_userList.length > 0) {
      _userSelected.value = _userList[0];
    }

    if(_environmentList.length > 0) {
      _environmentSelected.value = _environmentList[0];
    }else if(_environmentList.length > 1) {
      _environmentSelected.value = _environmentList[1];
    }
  }

  Future loadUsers(int offset, int state) async {
    final getUsers = await _authAPI.getUsers(offset, state);

    if(getUsers['ok']) {
      if(getUsers['result'].length != 0) {
        _userList.clear();
        _userList.addAll(getUsers['result']);        
      }
    }   
  }

  Future loadEnvironments(int offset, int state) async {
    final getEnvironments = await 
      _environmentAPI.getEnvironments(offset, state);

    if(getEnvironments['ok']) {
      if(getEnvironments['result'].length != 0) {
        _environmentList.clear();
        _environmentList.addAll(getEnvironments['result']);
      }
    }
  }


}