import 'package:bloc/bloc.dart';
import 'package:eljuego/modelos.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'estado.dart';
import 'evento.dart';
const limiteMaximoDeJugadores = 5;

class ElJuegoBloc extends Bloc<Evento, Estado> {
 IList<Jugador> _jugadores = IList();
 String mensaje = '';
  
  ElJuegoBloc() : super(EstadorInicial()) {
    on<JugadorAgregado>((event, emit) {
     _jugadores = _jugadores.add(event.jugador);
      emit(Lobby(jugadores: _jugadores, mensaje: ''));
      if(_jugadores.length == limiteMaximoDeJugadores){
        add(PartidaIniciada());
      }
    });
    on<PartidaIniciada>((event,emit){
      int limiteDeCartasEnMano = calcularLimiteMaximoCarta(numeroJugadores: _jugadores.length);
      return null;
    });
  }
  
  calcularLimiteMaximoCarta({required int numeroJugadores}) {
    Map<int,int> limiteDeCartasEnMano = {
      1:8,
      2:7,
      3:6,
      4:6,
      5:6
    }; 
    if(limiteDeCartasEnMano.containsKey(numeroJugadores)){
      return limiteDeCartasEnMano[numeroJugadores]!;
    }
    throw Exception('número de jugadores incorrecto');   
  }
}