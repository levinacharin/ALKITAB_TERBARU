// ignore: camel_case_types
class cData{
  String aID;
  String abookID;
  String aabbreviation;
  String abook;
  String achapter;
  String averse;
  String acontent;
  String atype;

  cData({
    required this.aID,
    required this.abookID,
    required this.aabbreviation,
    required this.abook,
    required this.achapter,
    required this.averse,
    required this.acontent,
    required this.atype
  });

  factory cData.fromJson(Map<String, dynamic>json)=> cData(
        aID: json['ID'].toString(), 
        abookID: json['bookID'].toString(), 
        aabbreviation: json['abbreviation'].toString(), 
        abook: json['book'].toString(), 
        achapter: json['chapter'].toString(), 
        averse: json['verse'].toString(), 
        acontent: json['content'].toString(), 
        atype: json['type'].toString());
}