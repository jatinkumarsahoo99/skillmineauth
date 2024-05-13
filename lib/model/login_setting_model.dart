class LoginSettingModel {
  bool? success;
  int? code;
  Data? data;

  LoginSettingModel({this.success, this.code, this.data});

  LoginSettingModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? clientId;
  bool? enableClassical;
  List<String>? allowedUsernameTypes;
  // List<Null>? singleLeggedSettings;
  DisplaySettings? displaySettings;
  Settings? settings;
  List<LoginProviders>? loginProviders;

  Data(
      {this.clientId,
        this.enableClassical,
        this.allowedUsernameTypes,
        // this.singleLeggedSettings,
        this.displaySettings,
        this.settings,
        this.loginProviders});

  Data.fromJson(Map<String, dynamic> json) {
    clientId = json['client_id'];
    enableClassical = json['enable_classical'];
    allowedUsernameTypes = json['allowed_username_types'].cast<String>();
    // if (json['single_legged_settings'] != null) {
    //   singleLeggedSettings = <Null>[];
    //   json['single_legged_settings'].forEach((v) {
    //     singleLeggedSettings!.add(new Null.fromJson(v));
    //   });
    // }
    displaySettings = json['display_settings'] != null
        ? DisplaySettings.fromJson(json['display_settings'])
        : null;
    settings = json['settings'] != null
        ? Settings.fromJson(json['settings'])
        : null;
    if (json['login_providers'] != null) {
      loginProviders = <LoginProviders>[];
      json['login_providers'].forEach((v) {
        loginProviders!.add(LoginProviders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['client_id'] = clientId;
    data['enable_classical'] = enableClassical;
    data['allowed_username_types'] = allowedUsernameTypes;
    // if (this.singleLeggedSettings != null) {
    //   data['single_legged_settings'] =
    //       this.singleLeggedSettings!.map((v) => v.toJson()).toList();
    // }
    if (displaySettings != null) {
      data['display_settings'] = displaySettings!.toJson();
    }
    if (settings != null) {
      data['settings'] = settings!.toJson();
    }
    if (loginProviders != null) {
      data['login_providers'] =
          loginProviders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DisplaySettings {
  String? displayName;
  String? logoUri;
  String? cover;
  String? description;
  String? helpDeskLink;

  DisplaySettings(
      {this.displayName,
        this.logoUri,
        this.cover,
        this.description,
        this.helpDeskLink});

  DisplaySettings.fromJson(Map<String, dynamic> json) {
    displayName = json['display_name'];
    logoUri = json['logo_uri'];
    cover = json['cover'];
    description = json['description'];
    helpDeskLink = json['help_desk_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['display_name'] = displayName;
    data['logo_uri'] = logoUri;
    data['cover'] = cover;
    data['description'] = description;
    data['help_desk_link'] = helpDeskLink;
    return data;
  }
}

class Settings {
  bool? showRegisterOption;
  bool? showForgotPassword;
  bool? showPasswordLessLogin;
  bool? showRememberMe;
  bool? showFederationLogin;

  Settings(
      {this.showRegisterOption,
        this.showForgotPassword,
        this.showPasswordLessLogin,
        this.showRememberMe,
        this.showFederationLogin});

  Settings.fromJson(Map<String, dynamic> json) {
    showRegisterOption = json['show_register_option'];
    showForgotPassword = json['show_forgot_password'];
    showPasswordLessLogin = json['show_password_less_login'];
    showRememberMe = json['show_remember_me'];
    showFederationLogin = json['show_federation_login'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['show_register_option'] = showRegisterOption;
    data['show_forgot_password'] = showForgotPassword;
    data['show_password_less_login'] = showPasswordLessLogin;
    data['show_remember_me'] = showRememberMe;
    data['show_federation_login'] = showFederationLogin;
    return data;
  }
}

class LoginProviders {
  String? loginProviderId;
  String? providerType;
  String? providerName;
  String? providerDisplayName;
  String? logoUri;
  bool? enableForgetPassword;
  bool? enableRegister;
  ClassicalConfig? classicalConfig;

  LoginProviders(
      {this.loginProviderId,
        this.providerType,
        this.providerName,
        this.providerDisplayName,
        this.logoUri,
        this.enableForgetPassword,
        this.enableRegister,
        this.classicalConfig});

  LoginProviders.fromJson(Map<String, dynamic> json) {
    loginProviderId = json['login_provider_id'];
    providerType = json['provider_type'];
    providerName = json['provider_name'];
    providerDisplayName = json['provider_display_name'];
    logoUri = json['logo_uri'];
    enableForgetPassword = json['enable_forget_password'];
    enableRegister = json['enable_register'];
    classicalConfig = json['classical_config'] != null
        ? ClassicalConfig.fromJson(json['classical_config'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['login_provider_id'] = loginProviderId;
    data['provider_type'] = providerType;
    data['provider_name'] = providerName;
    data['provider_display_name'] = providerDisplayName;
    data['logo_uri'] = logoUri;
    data['enable_forget_password'] = enableForgetPassword;
    data['enable_register'] = enableRegister;
    if (classicalConfig != null) {
      data['classical_config'] = classicalConfig!.toJson();
    }
    return data;
  }
}

class ClassicalConfig {
  String? usernameVariable;
  String? passwordVariable;
  String? sId;
  String? createdTime;
  String? updatedTime;
  UsernameVariableMetadata? usernameVariableMetadata;
  PasswordVariableMetadata? passwordVariableMetadata;
  String? id;

  ClassicalConfig(
      {this.usernameVariable,
        this.passwordVariable,
        this.sId,
        this.createdTime,
        this.updatedTime,
        this.usernameVariableMetadata,
        this.passwordVariableMetadata,
        this.id});

  ClassicalConfig.fromJson(Map<String, dynamic> json) {
    usernameVariable = json['username_variable'];
    passwordVariable = json['password_variable'];
    sId = json['_id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    usernameVariableMetadata = json['username_variable_metadata'] != null
        ? UsernameVariableMetadata.fromJson(
        json['username_variable_metadata'])
        : null;
    passwordVariableMetadata = json['password_variable_metadata'] != null
        ? PasswordVariableMetadata.fromJson(
        json['password_variable_metadata'])
        : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username_variable'] = usernameVariable;
    data['password_variable'] = passwordVariable;
    data['_id'] = sId;
    data['createdTime'] = createdTime;
    data['updatedTime'] = updatedTime;
    if (usernameVariableMetadata != null) {
      data['username_variable_metadata'] =
          usernameVariableMetadata!.toJson();
    }
    if (passwordVariableMetadata != null) {
      data['password_variable_metadata'] =
          passwordVariableMetadata!.toJson();
    }
    data['id'] = id;
    return data;
  }
}

class UsernameVariableMetadata {
  String? id;
  String? fieldKey;
  String? fieldType;
  String? parentFieldKey;
  String? fieldGroupType;
  bool? isUnique;
  bool? isUsername;
  bool? isPassword;
  bool? isMatchEnabled;
  LocaleText? localeText;
  Attribute? attribute;
  List<Validation>? validation;
  // List<Null>? innerFields;

  UsernameVariableMetadata(
      {this.id,
        this.fieldKey,
        this.fieldType,
        this.parentFieldKey,
        this.fieldGroupType,
        this.isUnique,
        this.isUsername,
        this.isPassword,
        this.isMatchEnabled,
        this.localeText,
        this.attribute,
        this.validation,
        // this.innerFields
      });

  UsernameVariableMetadata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fieldKey = json['field_key'];
    fieldType = json['field_type'];
    parentFieldKey = json['parent_field_key'];
    fieldGroupType = json['field_group_type'];
    isUnique = json['is_unique'];
    isUsername = json['is_username'];
    isPassword = json['is_password'];
    isMatchEnabled = json['is_match_enabled'];
    localeText = json['locale_text'] != null
        ? LocaleText.fromJson(json['locale_text'])
        : null;
    attribute = json['attribute'] != null
        ? Attribute.fromJson(json['attribute'])
        : null;
    if (json['validation'] != null) {
      validation = <Validation>[];
      json['validation'].forEach((v) {
        validation!.add(Validation.fromJson(v));
      });
    }
    // if (json['inner_fields'] != null) {
    //   innerFields = <Null>[];
    //   json['inner_fields'].forEach((v) {
    //     innerFields!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['field_key'] = fieldKey;
    data['field_type'] = fieldType;
    data['parent_field_key'] = parentFieldKey;
    data['field_group_type'] = fieldGroupType;
    data['is_unique'] = isUnique;
    data['is_username'] = isUsername;
    data['is_password'] = isPassword;
    data['is_match_enabled'] = isMatchEnabled;
    if (localeText != null) {
      data['locale_text'] = localeText!.toJson();
    }
    if (attribute != null) {
      data['attribute'] = attribute!.toJson();
    }
    if (validation != null) {
      data['validation'] = validation!.map((v) => v.toJson()).toList();
    }
    // if (this.innerFields != null) {
    //   data['inner_fields'] = this.innerFields!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class LocaleText {
  String? locale;
  String? displayName;
  List<Messages>? messages;

  LocaleText({this.locale, this.displayName, this.messages});

  LocaleText.fromJson(Map<String, dynamic> json) {
    locale = json['locale'];
    displayName = json['display_name'];
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['locale'] = locale;
    data['display_name'] = displayName;
    if (messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Messages {
  String? messageType;
  String? message;

  Messages({this.messageType, this.message});

  Messages.fromJson(Map<String, dynamic> json) {
    messageType = json['message_type'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message_type'] = messageType;
    data['message'] = message;
    return data;
  }
}

class Attribute {
  dynamic internal;
  dynamic readonly;
  Required? required;
  dynamic hidden;
  String? sId;
  String? id;

  Attribute(
      {this.internal,
        this.readonly,
        this.required,
        this.hidden,
        this.sId,
        this.id});

  Attribute.fromJson(Map<String, dynamic> json) {
    internal = json['internal'];
    readonly = json['readonly'];
    required = json['required'] != null
        ? Required.fromJson(json['required'])
        : null;
    hidden = json['hidden'];
    sId = json['_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['internal'] = internal;
    data['readonly'] = readonly;
    if (required != null) {
      data['required'] = required!.toJson();
    }
    data['hidden'] = hidden;
    data['_id'] = sId;
    data['id'] = id;
    return data;
  }
}

class Required {
  String? attributeType;
  String? sId;
  String? id;

  Required({this.attributeType, this.sId, this.id});

  Required.fromJson(Map<String, dynamic> json) {
    attributeType = json['attribute_type'];
    sId = json['_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attribute_type'] = attributeType;
    data['_id'] = sId;
    data['id'] = id;
    return data;
  }
}

class Validation {
  String? validationKey;
  List<ValidationRule>? validationRule;
  String? sId;
  String? id;

  Validation({this.validationKey, this.validationRule, this.sId, this.id});

  Validation.fromJson(Map<String, dynamic> json) {
    validationKey = json['validation_key'];
    if (json['validation_rule'] != null) {
      validationRule = <ValidationRule>[];
      json['validation_rule'].forEach((v) {
        validationRule!.add( ValidationRule.fromJson(v));
      });
    }
    sId = json['_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['validation_key'] = validationKey;
    if (validationRule != null) {
      data['validation_rule'] =
          validationRule!.map((v) => v.toJson()).toList();
    }
    data['_id'] = sId;
    data['id'] = id;
    return data;
  }
}

class ValidationRule {
  String? locale;
  String? sId;
  String? id;

  ValidationRule({this.locale, this.sId, this.id});

  ValidationRule.fromJson(Map<String, dynamic> json) {
    locale = json['locale'];
    sId = json['_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['locale'] = locale;
    data['_id'] = sId;
    data['id'] = id;
    return data;
  }
}

class PasswordVariableMetadata {
  String? id;
  String? fieldKey;
  String? fieldType;
  String? parentFieldKey;
  String? fieldGroupType;
  String? matchFieldKey;
  bool? isUnique;
  bool? isUsername;
  bool? isPassword;
  bool? isMatchEnabled;
  LocaleText? localeText;
  Attribute? attribute;
  // List<Null>? innerFields;

  PasswordVariableMetadata(
      {this.id,
        this.fieldKey,
        this.fieldType,
        this.parentFieldKey,
        this.fieldGroupType,
        this.matchFieldKey,
        this.isUnique,
        this.isUsername,
        this.isPassword,
        this.isMatchEnabled,
        this.localeText,
        this.attribute,
        // this.innerFields
      });

  PasswordVariableMetadata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fieldKey = json['field_key'];
    fieldType = json['field_type'];
    parentFieldKey = json['parent_field_key'];
    fieldGroupType = json['field_group_type'];
    matchFieldKey = json['match_field_key'];
    isUnique = json['is_unique'];
    isUsername = json['is_username'];
    isPassword = json['is_password'];
    isMatchEnabled = json['is_match_enabled'];
    localeText = json['locale_text'] != null
        ? LocaleText.fromJson(json['locale_text'])
        : null;
    attribute = json['attribute'] != null
        ? Attribute.fromJson(json['attribute'])
        : null;
    // if (json['inner_fields'] != null) {
    //   innerFields = <Null>[];
    //   json['inner_fields'].forEach((v) {
    //     innerFields!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['field_key'] = fieldKey;
    data['field_type'] = fieldType;
    data['parent_field_key'] = parentFieldKey;
    data['field_group_type'] = fieldGroupType;
    data['match_field_key'] = matchFieldKey;
    data['is_unique'] = isUnique;
    data['is_username'] = isUsername;
    data['is_password'] = isPassword;
    data['is_match_enabled'] = isMatchEnabled;
    if (localeText != null) {
      data['locale_text'] = localeText!.toJson();
    }
    if (attribute != null) {
      data['attribute'] = attribute!.toJson();
    }
    // if (this.innerFields != null) {
    //   data['inner_fields'] = this.innerFields!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
