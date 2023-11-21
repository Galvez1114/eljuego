import 'package:eljuego/modelos.dart';
import 'package:fpdart/src/either.dart';

class Mazito implements Mazo{
  @override
  void barajar() {
    // TODO: implement barajar
  }

  @override
  // TODO: implement cantidadCartasRestantes
  int get cantidadCartasRestantes => throw UnimplementedError();

  @override
  bool estaVacio() {
    // TODO: implement estaVacio
    throw UnimplementedError();
  }

  @override
  Either<Problema, Carta> robar() {
    // TODO: implement robar
    throw UnimplementedError();
  }
  
  @override
  late List<Carta> cartas;

}

class MazoMovimientoBloqueado extends Mazo {
  MazoMovimientoBloqueado(){
    cartas = [
    Carta(valor: 99),
    Carta(valor: 98),
    Carta(valor: 2),
    Carta(valor: 3),
    Carta(valor: 4),
    Carta(valor: 5),
    Carta(valor: 6),
    Carta(valor: 7),
  ];
  }

  @override
  void barajar(){
    //No se pretende cambiar el orden
  }
  
}
