import 'package:eljuego/modelos.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

sealed class Estado {}

class EstadoInicial extends Estado {}

class turno extends Estado with EquatableMixin{
  final Jugador jugador;
  final descarteAscendente descarteAscendente1;
  final descarteAscendente descarteAscendente2;
  final DescarteDescendente descarteDescendente1;
  final DescarteDescendente descarteDescendente2;

  turno({required this.jugador, required this.descarteAscendente1, required this.descarteAscendente2, required this.descarteDescendente1, required this.descarteDescendente2});
  
  @override
  // TODO: implement props
  List<Object?> get props => [jugador,descarteAscendente1,descarteAscendente2,descarteDescendente1,descarteDescendente2];
}

class partidaPerdida extends Estado with EquatableMixin{
  final int numeroDeCartas;

  partidaPerdida({required this.numeroDeCartas});
  @override
  // TODO: implement props
  List<Object?> get props => [numeroDeCartas];
}

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
