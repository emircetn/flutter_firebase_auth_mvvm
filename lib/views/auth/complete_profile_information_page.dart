import 'dart:io';

import 'package:auth_firebase/config/constants/asset_constants.dart';
import 'package:auth_firebase/models/app_user.dart';
import 'package:auth_firebase/modelviews/user_model_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class CompleteProfileInformationPage extends StatefulWidget {
  @override
  _CompleteProfileInformationPageState createState() =>
      _CompleteProfileInformationPageState();
}

class _CompleteProfileInformationPageState
    extends State<CompleteProfileInformationPage> {
  GlobalKey<FormState> _formKey;

  String _userName, _nameAndSurname;
  File _profilePicture;
  String _profilPictureUrl;
  final picker = ImagePicker();
  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    setUserInformaiton();
    super.initState();
  }

  void setUserInformaiton() {
    final userModelView = Provider.of<UserModelView>(context, listen: false);
    _nameAndSurname = userModelView.appUser.nameAndSurName;
    _profilPictureUrl = userModelView.appUser.profileUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profilinizi Oluşturun"),
        centerTitle: true,
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            profilePhotoField(),
            textFields(),
          ],
        ),
      ),
    );
  }

  profilePhotoField() => Container(
      height: 150.h,
      width: 150.h,
      child: Stack(
        children: [
          Container(
            height: 150.h,
            width: 150.h,
            child: Material(
              elevation: 4,
              child: _profilPictureUrl != null
                  ? Image.network(
                      _profilPictureUrl,
                      fit: BoxFit.cover,
                    )
                  : _profilePicture == null
                      ? Image.asset(
                          AssetContants.IMAGE_PATH + "profile.png",
                          fit: BoxFit.cover,
                        )
                      : Image.file(_profilePicture, fit: BoxFit.cover),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: () => choosePhoto(),
              child: CircleAvatar(child: Icon(Icons.edit)),
            ),
          ),
        ],
      ));

  textFields() =>
      Consumer<UserModelView>(builder: (context, userModelView, widget) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    autofocus: true,
                    initialValue:
                        _nameAndSurname != null ? _nameAndSurname : "",
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "Adınızı ve Soyadınızı Girin",
                        suffixIcon: Icon(
                          Icons.person,
                          color: Theme.of(context).accentColor,
                        ),
                        border: OutlineInputBorder()),
                    onSaved: (nameAndSurname) {
                      _nameAndSurname = nameAndSurname;
                    },
                    validator: (nameAndSurname) =>
                        userModelView.nameAndSurnameCheck(nameAndSurname),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "Kullanıcı Adınızı Girin",
                        suffixIcon: Icon(
                          Icons.person,
                          color: Theme.of(context).accentColor,
                        ),
                        border: OutlineInputBorder()),
                    onSaved: (userName) {
                      _userName = userName;
                    },
                    validator: (userName) => userModelView.userNameValidator,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    FlatButton(
                      onPressed: () async => await submitInformation(),
                      child: Text("Tamamla"),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      });

  Future submitInformation() async {
    final userModelView = Provider.of<UserModelView>(context, listen: false);
    _formKey.currentState.save();
    await userModelView.userNameCheck(_userName);
    if (_formKey.currentState.validate()) {
      AppUser user = await setInputs(userModelView.appUser);
      bool result = await userModelView.saveUserToDatabase(user);
      if (result == false) showToast("Bir hata oluştu");
    }
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_LONG,
      msg: msg,
    );
  }

  Future setInputs(AppUser appUser) async {
    AppUser user = appUser;
    user.userName = _userName;
    user.nameAndSurName = _nameAndSurname;
    user.profileUrl = await uploadProfilePhoto();
    return user;
  }

  Future<String> uploadProfilePhoto() async {
    if (_profilePicture != null) {
      final userModelView = Provider.of<UserModelView>(context, listen: false);
      String result =
          await userModelView.uploadProfilePhotoToDatabase(_profilePicture);
      if (result == null) {
        showToast(
            "Profil fotoğrafınız yüklenemedi. Lütfen daha sonra tekrar deneyin");
      }
      return result;
    } else if (_profilPictureUrl != null) {
      return _profilPictureUrl;
    } else
      return AssetContants.DEFAULT_PROFILE_IMAGE;
  }

  void choosePhoto() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(
                    Icons.camera,
                  ),
                  title: Text("Kameradan Çek"),
                  onTap: getCamera,
                ),
                ListTile(
                  leading: Icon(
                    Icons.image,
                  ),
                  title: Text("Galeriden Seç"),
                  onTap: getGallery,
                ),
                if (_profilePicture != null || _profilPictureUrl != null) ...[
                  ListTile(
                    leading: Icon(
                      Icons.delete,
                    ),
                    title: Text("Profil Fotoğrafını Kaldır"),
                    onTap: removeImage,
                  ),
                ]
              ],
            ),
          );
        });
  }

  void getCamera() async {
    final _picture = await picker.getImage(
        source: ImageSource.camera, maxWidth: 500.0, maxHeight: 500.0);
    if (_picture != null) {
      _profilePicture = await cropImage(_picture);
      _profilPictureUrl = null;
      Navigator.pop(context);
      setState(() {});
    }
  }

  void getGallery() async {
    final _picture = await picker.getImage(
        source: ImageSource.gallery, maxWidth: 500.0, maxHeight: 500.0);
    if (_picture != null) {
      _profilePicture = await cropImage(_picture);
      _profilPictureUrl = null;
      Navigator.pop(context);
      setState(() {});
    }
  }

  void removeImage() {
    _profilePicture = null;
    Navigator.pop(context);
    setState(() {});
  }

  Future<File> cropImage(PickedFile pickedFile) async {
    File _picture;
    _picture = await ImageCropper.cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: "Kırp",
            toolbarColor: Theme.of(context).primaryColor,
            toolbarWidgetColor: Theme.of(context).textSelectionColor,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    return _picture;
  }
}
