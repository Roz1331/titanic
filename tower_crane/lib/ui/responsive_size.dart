class ResponsiveSize {
  static double _width = 1536;
  static double _height = 754;
  static void init({double height, double width}) {
    _width = width;
    _height = height;
  }

  static double width(num value) {
    return value * (_width / 1536);
  }

  static double antiwidth(num value) {
    return 1536 * value /_width;
  }

  static double antiheight(num value) {
    return 754 * value /_height;
  }

  static double height(num value) {
    return value * (_height / 754);
  }
}

extension ResponsiveOnNum on num {
  double get w => ResponsiveSize.width(this);
  double get h => ResponsiveSize.height(this);
  double get antiw => ResponsiveSize.antiwidth(this);
  double get antih => ResponsiveSize.antiheight(this);
}
