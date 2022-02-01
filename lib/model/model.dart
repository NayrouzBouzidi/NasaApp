class Nasa {
    String copyright;
    String date;
    String explanation;
    String hdurl;
    String media_type;
    String service_version;
    String title;
    String url;

    Nasa({required this.copyright, required this.date, required this.explanation, required this.hdurl, required this.media_type, required this.service_version,required this.title,required this.url});

    factory Nasa.fromJson(Map<String, dynamic> json) {
        return Nasa(
            copyright: json['copyright'],
            date: json['date'],
            explanation: json['explanation'],
            hdurl: json['hdurl'],
            media_type: json['media_type'],
            service_version: json['service_version'],
            title: json['title'],
            url: json['url'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['copyright'] = this.copyright;
        data['date'] = this.date;
        data['explanation'] = this.explanation;
        data['hdurl'] = this.hdurl;
        data['media_type'] = this.media_type;
        data['service_version'] = this.service_version;
        data['title'] = this.title;
        data['url'] = this.url;
        return data;
    }
}