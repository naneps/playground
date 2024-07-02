enum Gender { female, male }

class UserModel {
  String? uid;
  String? name;
  String? username;
  String? email;
  String? avatar;
  String? password;
  DateTime? birthday;
  String? role;

  String? about;
  bool? online;
  DateTime? emailVerifiedAt;
  DateTime? lastOnline;
  Map<String, bool>?
      typingStatus; // Map untuk menyimpan status typing per chat room

  UserModel({
    this.uid,
    this.name,
    this.username,
    this.email,
    this.avatar,
    this.password,
    this.birthday,
    this.role,
    this.about,
    this.online,
    this.typingStatus,
    this.emailVerifiedAt,
    this.lastOnline,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    username = json['username'];
    avatar = json['avatar'];
    email = json['email'];
    password = json['password'];
    birthday = json['birthday']?.toDate();
    role = json['role'];
    about = json['about'];
    online = json['online'];
    emailVerifiedAt = json['emailVerifiedAt']?.toDate();
    lastOnline = json['lastOnline']?.toDate();
    typingStatus = json['typingStatus'] != null
        ? Map<String, bool>.from(json['typingStatus'])
        : {}; // Konversi ke Map jika ada data
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['uid'] = uid;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['birthday'] = birthday;
    data['role'] = role;
    data['about'] = about;
    data['online'] = online;
    data['typingStatus'] = typingStatus;
    data['emailVerifiedAt'] = emailVerifiedAt;
    data['lastOnline'] = lastOnline;

    return data;
  }

//   to post

  toPostJson() {
    final Map<String, dynamic> data = {};
    data['uid'] = uid;
    data['name'] = name;
    data['avatar'] = avatar;
    return data;
  }

  toSignInJson() {
    final Map<String, dynamic> data = {};
    data['email'] = email;
    data['password'] = password;
    return data;
  }

  toSignUpJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}

extension GenderExtension on Gender {
//  make name
}
