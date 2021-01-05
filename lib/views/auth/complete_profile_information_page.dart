import 'package:auth_firebase/config/constants/asset_constants.dart';
import 'package:auth_firebase/models/app_user.dart';
import 'package:auth_firebase/modelviews/user_model_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CompleteProfileInformationPage extends StatefulWidget {
  @override
  _CompleteProfileInformationPageState createState() =>
      _CompleteProfileInformationPageState();
}

class _CompleteProfileInformationPageState
    extends State<CompleteProfileInformationPage> {
  GlobalKey<FormState> _formKey;
  String _userName, _name, _surName, _profilUrl;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();

    super.initState();
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
          Material(
            elevation: 4,
            child: Image.asset(
              AssetContants.IMAGE_PATH + "profile.png",
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: () {},
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
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "Adınızı Girin",
                        suffixIcon: Icon(
                          Icons.person,
                          color: Theme.of(context).accentColor,
                        ),
                        border: OutlineInputBorder()),
                    onSaved: (name) {
                      _name = name;
                    },
                    validator: (name) => userModelView.nameOrSurnameCheck(name),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "Soyadınızı Girin",
                        suffixIcon: Icon(
                          Icons.person,
                          color: Theme.of(context).accentColor,
                        ),
                        border: OutlineInputBorder()),
                    onSaved: (surName) {
                      _surName = surName;
                    },
                    validator: (surName) =>
                        userModelView.nameOrSurnameCheck(surName),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    autofocus: true,
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
      AppUser user = userModelView.appUser;
      user.userName = _userName;
      user.nameAndSurName = _name + " " + _surName;
      user.profileUrl = _profilUrl;
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
}
