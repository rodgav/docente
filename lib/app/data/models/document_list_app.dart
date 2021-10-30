import 'package:appwrite/models.dart';

class DocumentListApp {
  int sum;

  List<Document> documents;

  DocumentListApp({
    required this.sum,
    required this.documents,
  });

  factory DocumentListApp.fromMap(Map<String, dynamic> map) {
    return DocumentListApp(
      sum: map['sum'] ?? 0,
      documents: map['documents'] != null
          ? List<Document>.from(
              map['documents'].map((p) => Document.fromMap(p)))
          : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "sum": sum,
      "documents": documents.map((p) => p.toMap()),
    };
  }

  List<T> convertTo<T>(T Function(Map) fromJson) =>
      documents.map((d) => d.convertTo<T>(fromJson)).toList();
}
