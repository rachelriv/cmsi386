import 'dart:io';
import 'dart:convert';

void main(List<String> args) {
  if (args.length != 1
    || !(new RegExp(r'^[A-H]$')).hasMatch(args[0])) {
    print("Please provide exactly one capital letter between A and H");
    return;
  }
  print('Name'.padRight(19) + 'W  D  L');
  var baseUrl = "http://worldcup.kimonolabs.com/api/teams";
  var key = "KERbxAUfDYovbQnn9pR3pbLWEMRp47AQ";
  var group = args[0];
  var sort = "groupRank";

  var fullUrl = "$baseUrl?apikey=$key&group=$group&sort=$sort";

  HttpClient client = new HttpClient();

  client.getUrl(Uri.parse(fullUrl))
  .then((HttpClientRequest request) {
    return request.close();
  }).then((HttpClientResponse response) {
    response.transform(UTF8.decoder).transform(JSON.decoder)
    .listen((json) {
      for (var team in json) {
        String name = "${team['name']}".padRight(19);
        String wld = "${team['wins']}  ${team['draws']}  ${team['losses']}";
        print(name + wld);
      }
    });
  }).catchError(() {
    
  });
}