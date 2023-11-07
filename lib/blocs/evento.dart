import 'package:eljuego/modelos.dart';
import 'package:equatable/equatable.dart';

sealed class Evento {}

class PartidaIniciada extends Evento{
}

class JugadorAgregado extends Evento with EquatableMixin{
  final Jugador jugador;
  JugadorAgregado({required this.jugador});
  
  @override
  List<Object?> get props => [jugador];

}
