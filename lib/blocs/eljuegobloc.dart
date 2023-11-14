import 'package:bloc/bloc.dart';
import 'package:eljuego/modelos.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import '../utils/cola_circular.dart';
import 'estado.dart';
import 'evento.dart';

const limiteMaximoDeJugadores = 5;

class ElJuegoBloc extends Bloc<Evento, Estado> {
  IList<Jugador> _jugadores = IList();
  Mazo _mazo = Mazo();
  String mensaje = '';
  late final ColaCircular<Jugador> _colaCircular;
  descarteAscendente descarteAscendente1 = descarteAscendente();
  descarteAscendente descarteAscendente2 = descarteAscendente();
  DescarteDescendente descarteDescendente1 = DescarteDescendente();
  DescarteDescendente descarteDescendente2 = DescarteDescendente();

  ElJuegoBloc() : super(EstadorInicial()) {
    on<JugadorAgregado>((event, emit) {
      _mazo.barajar();

      _jugadores = _jugadores.add(event.jugador);
      emit(Lobby(jugadores: _jugadores, mensaje: ''));
      if (_jugadores.length == limiteMaximoDeJugadores) {
        add(PartidaIniciada());
      }
    });
    on<PartidaIniciada>((event, emit) {
      _colaCircular = ColaCircular(_jugadores);
      for (var j in _jugadores) {
        j.robar(
            mazo: _mazo,
            limiteMaximo:
                calcularLimiteMaximoCarta(numeroJugadores: _jugadores.length));
      }
      emit(turno(
          descarteAscendente1: descarteAscendente1,
          descarteAscendente2: descarteAscendente2,
          descarteDescendente1: descarteDescendente1,
          descarteDescendente2: descarteDescendente2,
          jugador: _colaCircular.quienVa));
    });
  on<TurnoJugado>((event, emit) {
    
  });
  }
}

calcularLimiteMaximoCarta({required int numeroJugadores}) {
  Map<int, int> limiteDeCartasEnMano = {1: 8, 2: 7, 3: 6, 4: 6, 5: 6};
  if (limiteDeCartasEnMano.containsKey(numeroJugadores)) {
    return limiteDeCartasEnMano[numeroJugadores]!;
  }
  throw Exception('número de jugadores incorrecto');
}

int calcularNumeroCartasFinales(Mazo mazo, IList<Jugador> jugadores) {
  int contador = 0;
  for (var jugador in jugadores) {
    contador =  contador + jugador.mano.length;
  }
  contador = contador + mazo.cantidadCartasRestantes;
  return contador;
}
