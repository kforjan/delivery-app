class ApiPath {
  // static String friend(String uid, String friendId) =>
  //     'users/$uid/friend/$friendId';
  // static String friends(String uid) => 'users/$uid/friends';
  static String user(String uid) => 'users/$uid';
  static String userType(String uid) => 'users/$uid/type';
}
