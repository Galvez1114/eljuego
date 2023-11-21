import 'dart:async';
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
  int _cartasJugadasPorActual = 0;
  final Mazo _mazo;
  String mensaje = '';
  late final ColaCircular<Jugador> _colaCircular;
  descarteAscendente descarteAscendente1 = descarteAscendente();
  descarteAscendente descarteAscendente2 = descarteAscendente();
  DescarteDescendente descarteDescendente1 = DescarteDescendente();
  DescarteDescendente descarteDescendente2 = DescarteDescendente();
  late int _limiteMaximoDeCartas;

  ElJuegoBloc(this._mazo) : super(EstadoInicial()) {
    on<JugadorAgregado>(onJugadorAgregado);
    on<turnoPasado>(onTurnoPasado);
    on<PartidaIniciada>(onPrtidaIniciada);
    on<cartaJugada>(onCartaJugada);
    on<TurnoJugado>(onTurnoJugado);
    on<movimientosBloqueados>(onMovimientosBlqueados);
    on<SinTurnos>((event, emit) {
      if (_colaCircular.colaVacia) {
        emit(PartidaGanada());
      }
    });
  }

  void onMovimientosBlqueados(event, emit) {
    emit(partidaPerdida(
        numeroDeCartas: calcularNumeroCartasFinales(_mazo, _jugadores)));
  }

  void onTurnoJugado(event, emit) {}

  void onCartaJugada(event, emit) {
    bool jugoBien(cartaJugada event) {
      return (event.descarte.recibeCarta(event.carta));
    }

    if (jugoBien(event)) {
      var jugadorActual = _colaCircular.quienVa;
      _colaCircular.quienVa.mano =
          _colaCircular.quienVa.mano.remove(event.carta);
      _cartasJugadasPorActual++;
      if (jugadorActual.mano.isEmpty) {
        if (_mazo.estaVacio()) {
          _colaCircular.sacar(jugadorActual);
          if (_colaCircular.colaVacia) {
            emit(PartidaGanada());
            return;
          }
          jugadorActual = _colaCircular.siguiente();
        } else {
          int aRobar =
              cuantasRobar(_mazo, jugadorActual.mano, _limiteMaximoDeCartas);
          jugadorActual.robar(mazo: _mazo, limiteMaximo: aRobar);
        }
      }

      emit(turno(
        jugador: jugadorActual,
        descarteAscendente1: descarteAscendente1,
        descarteAscendente2: descarteAscendente2,
        descarteDescendente1: descarteDescendente1,
        descarteDescendente2: descarteDescendente2,
      ));
      return;
    }
    emit(turno(
      jugador: _colaCircular.quienVa,
      descarteAscendente1: descarteAscendente1,
      descarteAscendente2: descarteAscendente2,
      descarteDescendente1: descarteDescendente1,
      descarteDescendente2: descarteDescendente2,
    ));
  }

  void onPrtidaIniciada(event, emit) {
    _colaCircular = ColaCircular(_jugadores);
    _limiteMaximoDeCartas =
        calcularLimiteMaximoCarta(numeroJugadores: _jugadores.length);
    for (var j in _jugadores) {
      j.robar(mazo: _mazo, limiteMaximo: _limiteMaximoDeCartas);
    }
    emit(turno(
        descarteAscendente1: descarteAscendente1,
        descarteAscendente2: descarteAscendente2,
        descarteDescendente1: descarteDescendente1,
        descarteDescendente2: descarteDescendente2,
        jugador: _colaCircular.quienVa));
  }

  void onTurnoPasado(event, emit) {
    if (_cartasJugadasPorActual >= minimoAJugar(_mazo)) {
      _cartasJugadasPorActual = 0;
      emit(turno(
        jugador: _colaCircular.siguiente(),
        descarteAscendente1: descarteAscendente1,
        descarteAscendente2: descarteAscendente2,
        descarteDescendente1: descarteDescendente1,
        descarteDescendente2: descarteDescendente2,
      ));
      return;
    }
    emit(turno(
      jugador: _colaCircular.quienVa,
      descarteAscendente1: descarteAscendente1,
      descarteAscendente2: descarteAscendente2,
      descarteDescendente1: descarteDescendente1,
      descarteDescendente2: descarteDescendente2,
    ));
  }

  void onJugadorAgregado(event, emit) {
    _mazo.barajar();

    _jugadores = _jugadores.add(event.jugador);
    emit(Lobby(jugadores: _jugadores, mensaje: ''));
    if (_jugadores.length == limiteMaximoDeJugadores) {
      add(PartidaIniciada());
    }
  }
}

int cuantasRobar(Mazo mazo, IList<Carta> mano, int limiteMaximo) {
  int cantidadARobar = limiteMaximo - mano.length;
  if (mazo.cantidadCartasRestantes < cantidadARobar) {
    cantidadARobar = mazo.cantidadCartasRestantes;
  }
  return cantidadARobar;
}

calcularLimiteMaximoCarta({required int numeroJugadores}) {
  Map<int, int> limiteDeCartasEnMano = {1: 8, 2: 7, 3: 6, 4: 6, 5: 6};
  if (limiteDeCartasEnMano.containsKey(numeroJugadores)) {
    return limiteDeCartasEnMano[numeroJugadores]!;
  }
  throw Exception('número de jugadores incorrecto');
}

int minimoAJugar(Mazo m) => m.estaVacio() ? 1 : 2;
int calcularNumeroCartasFinales(Mazo mazo, IList<Jugador> jugadores) {
  int contador = 0;
  for (var jugador in jugadores) {
    contador = contador + jugador.mano.length;
  }
  contador = contador + mazo.cantidadCartasRestantes;
  return contador;
}
