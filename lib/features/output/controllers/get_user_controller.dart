import 'package:get/state_manager.dart';
import 'package:input_store_app/features/auth/models/user.dart';
import 'package:input_store_app/features/auth/api/auth_api.dart';
import 'package:input_store_app/features/environment/api/environment_api.dart';
import 'package:input_store_app/features/environment/models/models/environment.dart';
import 'package:input_store_app/user_storage.dart';

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
  void onInit() {
    super.onInit();
    _authAPI = new AuthAPI();
    _environmentAPI = new EnvironmentAPI();

    _userList = <User>[].obs;
    _userSelected = new User().obs;

    _environmentList = <Environment>[].obs;
    _environmentSelected = new Environment().obs;

    _loading = false.obs;    
  }


  @override
  void onReady() async {      
    super.onReady();
    _loading.value = true;

    await loadUsers(0, 1);
    await loadEnvironments(0, 1);

    _loading.value = false;
  }


  Future loadUsers(int offset, int state) async {
    final getUsers = await _authAPI.getUsers(offset, state);

    if(getUsers['ok']) {
      if(getUsers['result'].length != 0) {
        _userList.clear();
        _userList.addAll(getUsers['result']);

        _userSelected.value = _userList[0];

        for(int i=0; i<_userList.length; i++) {
          User user = _userList[i];
          if(user.userId == UserStorage.user.userId) {
            _userSelected.value = user;
          }
        }      
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

        if(_environmentList.length != 0) {
          _environmentSelected.value = _environmentList[0];      
        }

        if(_userSelected.value.environmentId != null) {
          for(int i=0; i<_environmentList.length; i++) {
            Environment environment = _environmentList[i];
            if(_userSelected.value.environmentId == environment.environmentID) {
              _environmentSelected.value = environment;
            }
          }
        }

      }
    }
  }


  void userChanged(User user) {
    if(user.environmentId != null) {
      Environment environment = new Environment();
      environment.environmentID = user.environmentId;
      environment.name = user.environmentName;

      for(int i=0; i<_environmentList.length; i++) {
        if(environment.environmentID == _environmentList[i].environmentID) {
           _environmentSelected.value = _environmentList[i];
        }
      }     
    }
  }

}