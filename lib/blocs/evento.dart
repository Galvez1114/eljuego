import 'package:eljuego/modelos.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

sealed class Evento {}

class PartidaIniciada extends Evento{}

class movimientosBloqueados extends Evento{}


class turnoPasado extends Evento{}

class TurnoJugado extends Evento {
  final Jugador jugador;
  final IList<Carta> cartasJugadas;

  TurnoJugado({required this.jugador, required this.cartasJugadas});
}

class JugadorAgregado extends Evento with EquatableMixin{
  final Jugador jugador;
  JugadorAgregado({required this.jugador});
  
  @override
  List<Object?> get props => [jugador];

}
