class AssetContants {
  static AssetContants? _instace;
  static AssetContants get instance {
    _instace ??= AssetContants._init();
    return _instace!;
  }

  AssetContants._init();

  final imagePath = 'assets/images/';
  final iconPath = 'assets/icons/';
  final defaultProfileImage =
      'https://firebasestorage.googleapis.com/v0/b/authfirebase-85a60.Wappspot.com/o/profilePhotos%2Fprofile.png?alt=media&token=58e96c10-7852-437e-ab94-341e29613a9d';
}

extension ImageExtension on String {
  String get toPNG => '$this.png';
}
