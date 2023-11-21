import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fpdart/fpdart.dart';

class Carta {
  final int valor;

  Carta({required this.valor});
  @override
  String toString() => 'C-$valor';
}

class Mazo {
  List<Carta> cartas =
      List<Carta>.generate(98, (index) => Carta(valor: index + 2));
  int get cantidadCartasRestantes => cartas.length;

  void barajar() {
    cartas.shuffle();
  }

  bool estaVacio() {
    return cartas.isEmpty;
  }

  Either<Problema, Carta> robar() {
    if (estaVacio()) return left(MasoVacio());
    Carta carta = cartas.first;
    cartas.removeAt(0);
    return right(carta);
  }

  @override
  String toString() => '$cartas';
}

sealed class Problema {}

class MasoVacio extends Problema {}

sealed class Descarte {
  final List<Carta> _descartadas = [];
  bool recibeCarta(Carta carta);
}

class descarteAscendente extends Descarte {
  @override
  bool recibeCarta(Carta carta) {
    if (_descartadas.isEmpty) {
      _descartadas.add(carta);
      return true;
    }
    Carta c = _descartadas.last;
    if (c.valor < carta.valor) {
      _descartadas.add(carta);
      return true;
    }

    if (carta.valor == (c.valor - 10)) {
      _descartadas.add(carta);
      return true;
    }
    return false;
  }
}

class DescarteDescendente extends Descarte {
  @override
  bool recibeCarta(Carta carta) {
    if (_descartadas.isEmpty) {
      _descartadas.add(carta);
      return true;
    }
    Carta c = _descartadas.last;
    if (c.valor > carta.valor) {
      _descartadas.add(carta);
      return true;
    }

    if (carta.valor == (c.valor + 10)) {
      _descartadas.add(carta);
      return true;
    }
    return false;
  }
}

class Jugador with EquatableMixin {
  final String nombre;
  IList<Carta> mano;

  Jugador({required this.nombre, required this.mano});
  @override
  String toString() {
    return 'Soy jugador $nombre con mano $mano';
  }

  @override
  List<Object?> get props => [nombre, mano];

  void robar({required Mazo mazo, required int limiteMaximo}) {
    if (mazo.estaVacio()) {
      return;
    }
    int cuantas = limiteMaximo - mano.length;
    for (int i = 0; i < cuantas; i++) {
      var posibleCarta = mazo.robar();
      posibleCarta.match((l) => null, (r) {
        mano = mano.add(r);
      });
    }
  }
}
