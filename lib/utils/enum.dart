enum ComposeType {
  ///表单
  form(label: "表单"),

  ///布局容器
  layout(label: "布局容器"),

  /// 分组
  group(label: "分组"),

  ///单行文本
  text(label: "单行文本"),

  ///多行文本
  textArea(label: "多行文本"),

  ///未适配组件
  unadapted(label: "未适配"),

  ///  条件
  condition(label: "条件"),

  /// 说明
  instruction(label: "说明"),

  /// 数值
  number(label: "数值"),

  /// 金额
  price(label: "金额"),

  /// 计算公式
  formula(label: "计算公式"),

  ///  单选
  select(label: "单选"),

  ///  多选
  multipleSelect(label: "多选"),

  /// 下拉
  dropdown(label: "下拉"),

  ///  日期
  date(label: "日期"),

  ///  日期范围
  dateRange(label: "日期范围"),

  ///  明细/表格
  excel(label: "明细/表格"),

  ///  图片
  picture(label: "附件"),

  ///  附件
  file(label: "附件"),

  ///  关联审批
  relatedApproval(label: "关联审批"),

  ///  省市区
  location(label: "省市区"),

  /// 流水号
  serialNumber(label: "流水号"),

  /// 评分
  mark(label: "评分"),

  /// 进度
  identity(label: "进度"),

  ///  进度
  progress(label: "进度"),

  /// 手写签名
  signature(label: "手写签名"),

  /// 电话
  phoneNumber(label: "电话");

  final String label;

  const ComposeType({required this.label});
}


enum AlignType { left }

//数据源的类型
enum DataSourceType {
  ///加载远程数据源 请求加载即可
  load,
  /// 关联数据源,指a数据源的选项更改 会影响b的数据源更改 或者说 数据源是由另一个选项控制的
  lookup,
  /// 常量 不变的值
  normal,
  ///是指不在数据源内 但是在各种上下文的一些变量
  reference,
}