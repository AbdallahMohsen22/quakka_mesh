class ApiConstants {
  //api constants >> http://quokkamesh-001-site1.etempurl.com/api/
  static const String baseUrl = "http://backend.quokka-mesh.com/api/";
  static const String baseImageUrl = "http://backend.quokka-mesh.com/";
  //Auth
  static const String register = "Auth/Register/User";
  static const String login = "Auth/Login";
  static const String updateSubProfile = "Auth/UpdateSubProfile";
  static const String refreshToken = "Auth/RefreshToken";
  static const String revokeToken = "Auth/RevokeToken";
  static const String changePassword = "Auth/change-password";

  //Email
  static const String confirmEmail = "Email/Send Email";
  static const String confirmOtp = 'Email/Send Confirmation Email';
  static const String resetPassword = 'Email/ResetPassword';

  //Cart
  static const String addCart = 'Cart/Admin/AddCart';
  static const String adminGetAllCart = 'Cart/Admin/GetAllCart';
  static const String categoryGetAllCart = 'Cart/Category/GetAllCart';
  static const String updateCart = 'Cart/Admin/UpdateCart';
  static const String deleteCart = 'Cart/Admin/DeleteCart';

  //Category
  static const String addCategory = 'Category/Admin/AddCategory';
  static const String getAllCategory = 'Category/Admin/GetAllCategory';
  static const String updateCategory = 'Category/Admin/UpdateCategory';
  static const String deleteCategory = 'Category/Admin/DeleteCategory';

  //SendCart
  static const String sendCart = 'SendCart/User/SendCart';
  static const String viewMyCartSend = 'SendCart/User/ViewMyCartsended';
  static const String viewMyCartRecevied = 'SendCart/User/ViewMyCartrecevied';
  static const String searchInAllUser = 'SendCart/SearchInAllUser'; //{userName}
  static const String searchInAllUserWithPhone = 'SendCart/SearchInAllUserWithPhone'; //{PhoneNumber}

  //Statistics
  static const String getAllUser='Statistics/Admin/GetAllUser';
  static const String getOneUser='Statistics/Admin/GetOneUser';
  static const String countAllUser='Statistics/Admin/CountAllUser';
  static const String countAllCategory='Statistics/Admin/CountAllCategory';
  static const String countAllCart='Statistics/Admin/CountAllCart';
  static const String userPoint='Statistics/User/UserPoint';
  static const String countAllCartSend='Statistics/User/CountAllCartSend';
  static const String countAllCartReceiver='Statistics/User/CountAllCartReceiver';




  //header constants
  static const String tokenTitle = "Authorization";
  static const String tokenBody = 'Basic MTExNjU4NjU6NjAtZGF5ZnJlZXRyaWFs';
  static const String contentTypeTitle = 'content-type';
  static const String contentTypeBody = 'application/json';

}

class ApiErrors {
  static const String badRequestError = "badRequestError";
  static const String noContent = "noContent";
  static const String forbiddenError = "forbiddenError";
  static const String unauthorizedError = "unauthorizedError";
  static const String notFoundError = "notFoundError";
  static const String conflictError = "conflictError";
  static const String internalServerError = "internalServerError";
  static const String unknownError = "unknownError";
  static const String timeoutError = "timeoutError";
  static const String defaultError = "defaultError";
  static const String cacheError = "cacheError";
  static const String noInternetError = "noInternetError";
  static const String loadingMessage = "loading_message";
  static const String retryAgainMessage = "retry_again_message";
  static const String ok = "Ok";
}


