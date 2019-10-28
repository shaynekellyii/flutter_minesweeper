/// Directions to traverse in when performing a Breadth First Search
const List<List<int>> kBfsDirections = [
  [-1, -1],
  [-1, 0],
  [-1, 1],
  [0, -1],
  [0, 1],
  [1, -1],
  [1, 0],
  [1, 1],
];

const kMaxTime = 999;

const kMinRowsCols = 9;
const kMaxRowsCols = 99;
const kTileBuffer = 8;

const kHighScoreTableWidth = 300.0;
const kDesktopTilePixels = 24.0;
const kMobileTilePixels = 32.0;
const kMobileLayoutThresholdPixels = 948.0;
