import 'package:bloc_test/bloc_test.dart';
import 'package:eljuego/blocs/eljuegobloc.dart';
import 'package:eljuego/modelos.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'package:eljuego/blocs/estado.dart';
import 'package:eljuego/blocs/evento.dart';


void main() {
  blocTest<ElJuegoBloc, Estado>(
    'Si no llega al limite, acepta jugadores',
    build: () => ElJuegoBloc(),
    act: (bloc) => bloc.add(JugadorAgregado(jugador: Jugador(nombre: 'Pepe', mano: IList()))),
    expect: () => [
      Lobby(jugadores: IList([Jugador(nombre: 'Pepe', mano: IList())]), mensaje: ''),
    ]
  );
}