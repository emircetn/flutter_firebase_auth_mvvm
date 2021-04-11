class ErrorConstants {
  static showError(String code) {
    switch (code) {
      case "success":
        return "Giriş İşlemi Başarılı";
      case "emaıl-already-ın-use":
        return "Email Adresi Zaten Kullanılıyor";
      case "email-already-in-use":
        return "Email Adresi Zaten Kullanılıyor";
      case "user-not-found":
        return "Kullanıcı Bulunamadı";
      case "wrong-password":
        return "Girdiğiniz Parola Doğru Değil";
      case "network-request-failed":
        return "İntermet Bağlantınızı Kontrol Edin";
      case "sign_in_canceled":
        return "Giriş İptal Edildi";
      case "ınvalıd-emaıl":
        return "Email Adresi geçersiz";
      case "firebase_auth":
        return "Lütfen Email Adresinizi girin";
      default:
        return "Beklenmedik Bir Hata oluştu";
    }
  }
}
