String getIp() => "192.168.254.104:5000";
String image(String? imagePath) => "http://${getIp()}/register/$imagePath";
