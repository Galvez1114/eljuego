import 'package:eljuego/modelos.dart';


void main(List<String> arguments) {
  Mazo mazo = Mazo();
  mazo.barajar();
  
  var carta = mazo.robar();

//Metodo que regresa el valor del eather
  carta.fold((l) {
    print('El mazo está vacio');
  }, (r) {
    print('La carta es $r');
  });
  
  print(mazo.cantidadCartasRestantes);
}
