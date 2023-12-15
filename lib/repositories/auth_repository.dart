import 'package:rova_23/models/auth_model.dart';
import 'package:rova_23/utlis/services/rest_api_services.dart';

class AuthUserRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<dynamic> generateOtp(Authmodel authmodel) async {
    final response = await _helper.generateOtp(authmodel);
    return response;
  }
}
