import 'dart:io';
import 'dart:convert';
import 'dart:collection';

void main() {

  UTF8.decodeStream(stdin).then((String story) {
    var storyWords = story.toLowerCase().split(new RegExp(r"[^a-z']+"));
    var storyMap = new SplayTreeMap();
    for (var word in storyWords.where((String e) => e.trim().length > 0)) {
      if (storyMap.containsKey(word)) {
        storyMap[word]++;
      } else {
        storyMap[word] = 1;
      }
    }

    storyMap.forEach((key, val) {
      print('$key $val');
    });
  });


}