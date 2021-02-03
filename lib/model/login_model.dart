class LoginPageModel {
  String xAuthToken;
  int organizationId;
  bool haveCompany;
  String access;

  LoginPageModel(
      {this.xAuthToken, this.organizationId, this.haveCompany, this.access});

  LoginPageModel.fromJson(Map<String, dynamic> json) {
    xAuthToken = json['x-auth-token'];
    organizationId = json['organization_id'];
    haveCompany = json['haveCompany'];
    access = json['access'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['x-auth-token'] = this.xAuthToken;
    data['organization_id'] = this.organizationId;
    data['haveCompany'] = this.haveCompany;
    data['access'] = this.access;
    return data;
  }
}
