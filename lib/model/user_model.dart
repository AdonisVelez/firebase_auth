class UserModel {
  final String uid; // ID único del usuario en Firebase
  final String email; // Correo electrónico del usuario
  final String? displayName; // Nombre visible del usuario (opcional)
  final String? photoUrl; // URL de la foto de perfil del usuario (opcional)

  UserModel({
    required this.uid,
    required this.email,
    this.displayName,
    this.photoUrl,
  });

  // Constructor para crear el modelo desde un objeto Firebase User
  factory UserModel.fromFirebaseUser(dynamic firebaseUser) {
    return UserModel(
      uid: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      displayName: firebaseUser.displayName,
      photoUrl: firebaseUser.photoURL,
    );
  }

  // Método para convertir el modelo a un mapa (por ejemplo, para Firestore)
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
    };
  }

  // Método para crear un modelo a partir de un mapa (por ejemplo, desde Firestore)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      displayName: map['displayName'] as String?,
      photoUrl: map['photoUrl'] as String?,
    );
  }
}
