class UserModel {
  final String uid;
  final String name;
  final String email;
  final String photoUrl;
  final String description;
  final String providerId;
  final String providerUid;
  final String token;

  UserModel(
    this.uid,
    this.name,
    this.email,
    this.photoUrl,
    this.description,
    this.providerId,
    this.providerUid,
    this.token,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      json['uid'] as String ?? 'Unknown',
      json['name'] as String ?? 'Unknown',
      json['email'] as String ?? 'Unknown',
      json['photoUrl'] as String ?? 'Unknown',
      json['description'] as String ?? 'Unknown',
      json['providerId'] as String ?? 'Unknown',
      json['providerUid'] as String ?? 'Unknown',
      json['token'] as String ?? 'Unknown',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'displayName': name,
      'email': email,
      'photoUrl': photoUrl,
      'description': description,
      'providerId': providerId,
      'providerUid': providerUid,
      'token': token,
    };
  }
}
