class ApiPath {
  static String order(String orderId) => 'orders/$orderId';
  static String user(String uid) => 'users/$uid';
  static String userType(String uid) => 'users/$uid/type';
}
