import 'package:eljuego/modelos.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

sealed class Estado {}

class EstadorInicial extends Estado {}


class Lobby extends Estado with EquatableMixin {
  final IList<Jugador> jugadores;
  final String mensaje;

  Lobby({
    required this.jugadores
    ,required this.mensaje,
    });
  
  @override
  List<Object?> get props => [jugadores , mensaje];

  @override
  String toString() {
    return 'Soy lobby con $jugadores con $mensaje';
  }
}
