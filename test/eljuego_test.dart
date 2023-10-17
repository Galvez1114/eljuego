import 'package:eljuego/eljuego.dart';
import 'package:eljuego/modelos.dart';
import 'package:test/test.dart';

void main() {
  Mazo mazo = Mazo();
  mazo.barajar();
  var carta;
  for (var i = 0; i < 80; i++) {
    carta = mazo.robar();
  }

//Metodo que regresa el valor del eather
  carta.fold((l) {
    print('El mazo está vacio');
  }, (r) {
    print('La carta es $r');
  });
  print(mazo.cantidadCartasRestantes);
}
