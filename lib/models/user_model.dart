class UserModel {
// Field
  String id, name, user, password, avatar;

// Method
// ใช้ยัดค่าให้กับ โมเดล
  UserModel(this.id, this.name, this.user, this.password, this.avatar);

  // set data form Json
  // ค่าที่ส่งจาก Json มาให้  เป็น string  id ในฐานข้อมูลเป็น int แต่ถูกส่งมาเป็น  String ต้องเอา String เก็บ
  UserModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    user = map['user'];
    password = map['password'];
    avatar = map['avatar'];
  }
}
