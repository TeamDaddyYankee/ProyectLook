class Agraviado{
  String genero;
  int edad;
  Agraviado();
  Map<String, dynamic> toMap() => {
    "edad": edad,
    "genero": genero,
  };
}