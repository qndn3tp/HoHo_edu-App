import 'package:get/get.dart';  

/////////////////////
// 수업정보 데이터 //
/////////////////////

// 데이터 클래스
class ClassInfoData {
  final String stuId;
  final String sName;
  final String gubunName;
  final String gubun;
  final String codeName;
  final String codeName2;
  final String stime;
  final String etime;
  final String dateName;
  final String startYM;

  
  ClassInfoData ({
    required this.stuId,
    required this.sName,
    required this.gubunName,
    required this.gubun,
    required this.codeName,
    required this.codeName2,
    required this.stime,
    required this.etime,
    required this.dateName,
    required this.startYM,
  });

  factory ClassInfoData.fromJson(Map<String, dynamic> json) {
    return ClassInfoData (
      stuId: json['Stuid'] ?? "",
      sName: json['Sname'] ?? "",
      gubunName: json['gubunName'] ?? "",
      gubun: json['gubun'] ?? "",
      codeName: json['codeName'] ?? "",
      codeName2: json['codeName2'] ?? "",
      stime: json['stime'] ?? "",
      etime: json['etime'] ?? "",
      dateName: json['DATENAME'] ?? "",
      startYM: json['sym'] ?? "",
    );
  }
}

// 데이터 컨트롤러
class ClassInfoDataController extends GetxController {
  List<ClassInfoData>? _classInfoDataList;

  void setClassInfoDataList(List<ClassInfoData> classInfoDataList) {
    _classInfoDataList = classInfoDataList;
    update();
  }
  List<ClassInfoData>? get classInfoDataList => _classInfoDataList;

  // 학생 이름 리스트
  List<String> getSnamesList(List<ClassInfoData>? classInfoDataList) {
    if (classInfoDataList == null) {
      return []; // 예외 처리: null 체크
    } else {
      return classInfoDataList.map((classInfoData) => classInfoData.sName).toSet().toList();
    }
  }

  // 학생이름: 아이디를 가지는 Map
  Map<String, String> getNameId(List<ClassInfoData>? classInfoDataList) {
    Map<String, String> stuNameIdMap = {};
    if (classInfoDataList == null) {
      return stuNameIdMap;
    }

    for (var data in classInfoDataList) {
      String studentName = data.sName;
      String studentId = data.stuId; 
      
      // 이미 해당 학생 이름의 학생 아이디가 Map에 존재하는지 확인, 없으면 추가
      if (!stuNameIdMap.containsKey(studentName)) {
        stuNameIdMap[studentName] = studentId;
      }
    }
    return stuNameIdMap;
  }

  // 학생 이름:[수업정보]를 가지는 Map
  Map<String, List<List<String>>> getSubjectMap(List<ClassInfoData>? classInfoDataList) {
    Map<String, List<List<String>>> subjectMap = {};

    if (classInfoDataList == null) {
      return subjectMap;
    }
    
    for (var data in classInfoDataList) {
      String studentName = data.sName;
      String subjectName = data.codeName;
      String subjectNumber = data.codeName2;
      String subjectSTime = data.stime;
      String subjectETime = data.etime;
      String subjectDateName = data.dateName;
      
      if (!subjectMap.containsKey(studentName)) {
        subjectMap[studentName] = [[subjectName, subjectNumber, subjectSTime, subjectETime, subjectDateName]];
      } else {
        subjectMap[studentName]!.add([subjectName, subjectNumber, subjectSTime, subjectETime, subjectDateName]);
      }
    }
    return subjectMap;
  }
  
  // 학생 이름:[수업 시작 연월]을 가지는 Map
  Map<String, String> getStartYMMap(List<ClassInfoData>? classInfoDataList) {
    Map<String, String> startYMMap = {};
    
    if (classInfoDataList == null) {
      return startYMMap;
    }
    
    for (var data in classInfoDataList) {
      String studentName = data.sName;
      String startYM = data.startYM;
      
      if (!startYMMap.containsKey(studentName)) {
        startYMMap[studentName] = startYM;
      } else {
      }
    }
    return startYMMap;
  }

  // 학생 이름:[수업별 시작 연월]을 가지는 Map
  Map<String, List<List<String>>> getSubjectDate(List<ClassInfoData>? classInfoDataList) {
    Map<String, List<List<String>>> subjectDateMap = {};

    if (classInfoDataList == null) {
      return subjectDateMap;
    }
    
    for (var data in classInfoDataList) {
      String studentName = data.sName;
      String gubunName = data.gubunName;
      String startYM = data.startYM;
      
      if (!subjectDateMap.containsKey(studentName)) {
        subjectDateMap[studentName] = [[gubunName, startYM]];
      } else {
        subjectDateMap[studentName]!.add([gubunName, startYM]);
      }
    }
    return subjectDateMap;
  }
}