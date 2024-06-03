/// id : "text-6438e987a9b9c32ae50d93ec"
/// order : 0
/// type : "text"
/// editMode : true
/// label : "姓名"
/// placeholder : "请输入姓名"
/// key : "name"
/// defaultValue : ""
/// required : false
/// requiredMessage : "请输入姓名"
/// disabled : false
/// hidden : false
/// group : ""
/// state : "default"
/// clearable : false
/// style : {"width":"100%","height":"35px","color":"","styleMode":"floating"}
/// events : []
/// reg : false
/// regPattern : ""
/// regMessage : ""
/// mode : "text"
/// valueChangeEvent : "blur"
/// count : 0
/// min : 0
/// max : 0
/// isShowComponent : true
/// alisa : "name"
/// value : "张三"
// Form component allocation 配置
class Compose {
  String ?id;
  int ?order;
  String ?type;
  bool ?editMode;
  String ?label;
  String ?placeholder;
  String ?key;
  String? defaultValue;
  bool? required;
  String? requiredMessage;
  bool ?disabled;
  bool? hidden;
  String? group;
  String ?state;
  bool? clearable;
  StyleBean ?style;
  List<dynamic>? events;
  bool? reg;
  String ?regPattern;
  String? regMessage;
  String ?mode;
  String?valueChangeEvent;
  int? count;
  int ?min;
  int? max;
  bool ?isShowComponent;
  String? alisa;
  String ?value;

  static Compose fromMap(dynamic map) {
    Compose composeBean = Compose();
    composeBean.id = map['id'];
    composeBean.order = map['order'];
    composeBean.type = map['type'];
    composeBean.editMode = map['editMode'];
    composeBean.label = map['label'];
    composeBean.placeholder = map['placeholder'];
    composeBean.key = map['key'];
    composeBean.defaultValue = map['defaultValue'];
    composeBean.required = map['required'];
    composeBean.requiredMessage = map['requiredMessage'];
    composeBean.disabled = map['disabled'];
    composeBean.hidden = map['hidden'];
    composeBean.group = map['group'];
    composeBean.state = map['state'];
    composeBean.clearable = map['clearable'];
    composeBean.style = StyleBean.fromMap(map['style']);
    composeBean.events = map['events'];
    composeBean.reg = map['reg'];
    composeBean.regPattern = map['regPattern'];
    composeBean.regMessage = map['regMessage'];
    composeBean.mode = map['mode'];
    composeBean.valueChangeEvent = map['valueChangeEvent'];
    composeBean.count = map['count'];
    composeBean.min = map['min'];
    composeBean.max = map['max'];
    composeBean.isShowComponent = map['isShowComponent'];
    composeBean.alisa = map['alisa'];
    composeBean.value = map['value'];
    return composeBean;
  }

  Map toJson() => {
    "id": id,
    "order": order,
    "type": type,
    "editMode": editMode,
    "label": label,
    "placeholder": placeholder,
    "key": key,
    "defaultValue": defaultValue,
    "required": required,
    "requiredMessage": requiredMessage,
    "disabled": disabled,
    "hidden": hidden,
    "group": group,
    "state": state,
    "clearable": clearable,
    "style": style,
    "events": events,
    "reg": reg,
    "regPattern": regPattern,
    "regMessage": regMessage,
    "mode": mode,
    "valueChangeEvent": valueChangeEvent,
    "count": count,
    "min": min,
    "max": max,
    "isShowComponent": isShowComponent,
    "alisa": alisa,
    "value": value,
  };
}

/// width : "100%"
/// height : "35px"
/// color : ""
/// styleMode : "floating"

class StyleBean {
  String? width;
  String? height;
  String ?color;
  String ?styleMode;

  static StyleBean fromMap(Map<String, dynamic> map) {
    StyleBean styleBean = StyleBean();
    styleBean.width = map['width'];
    styleBean.height = map['height'];
    styleBean.color = map['color'];
    styleBean.styleMode = map['styleMode'];
    return styleBean;
  }

  Map toJson() => {
    "width": width,
    "height": height,
    "color": color,
    "styleMode": styleMode,
  };
}