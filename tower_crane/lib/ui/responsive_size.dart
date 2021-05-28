class ResponsiveSize {
  static double _width = 360;
  static double _height = 740;
  static void init({double height, double width}) {
    _width = width;
    _height = height;
  }

  static double width(num value) {
    return value * (_width / 1536);
  }

  static double height(num value) {
    return value * (_height / 754);
  }
}

extension ResponsiveOnNum on num {
  double get w => ResponsiveSize.width(this);
  double get h => ResponsiveSize.height(this);
}
