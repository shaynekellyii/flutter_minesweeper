class Point {
  const Point(this.x, this.y);

  final int x;
  final int y;

  @override
  String toString() {
    return 'Point {x: $x, y: $y}';
  }
}