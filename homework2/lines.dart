import 'dart:io';

void main(List<String> args) {
  List<String> lines = new File(args[0]).readAsLinesSync();
  var rLines = lines.fold(0, (int value, element) {
    var line = element.trim();
    return line.length > 0 && !line.startsWith(r'//') ? value + 1 : value;
  });

  print(rLines);
}