import 'package:eljuego/blocs/eljuegobloc.dart';
import 'package:eljuego/modelos.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:test/test.dart';

void main() {

  group('descarte ascendente', () {
    test('si el descarte ascendente acepta cuando esta vacio', () async {
    descarteAscendente descarte = descarteAscendente();
    bool acepto = descarte.recibeCarta(Carta(valor: 10));
    expect(acepto, true);
  });

test('Si el descarte ascendente acepta uno mayor', () {
  descarteAscendente descarte = descarteAscendente();
  descarte.recibeCarta(Carta(valor: 10));
  bool acepto = descarte.recibeCarta(Carta(valor: 20));
  expect(acepto, true);
});

test('si el descarte ascendente no acepta una menor', () {
  descarteAscendente descarte = descarteAscendente();
  descarte.recibeCarta(Carta(valor: 10));
  bool acepto = descarte.recibeCarta(Carta(valor: 5));
  expect(acepto, false);
});

test('si el descarte ascendente acepta una de exactamente menor en 10', () {
  descarteAscendente descarte = descarteAscendente();
  descarte.recibeCarta(Carta(valor: 20));
  bool acepto = descarte.recibeCarta(Carta(valor: 10));
  expect(acepto, true);
});
  });

  group('descarte descendente', () {
    test('si el descarte descendente acepta cuando esta vacio', () async {
    DescarteDescendente descarte = DescarteDescendente();
    bool acepto = descarte.recibeCarta(Carta(valor: 10));
    expect(acepto, true);
  });

test('Si el descarte descendente acepta uno menor', () {
  DescarteDescendente descarte = DescarteDescendente();
  descarte.recibeCarta(Carta(valor: 20));
  bool acepto = descarte.recibeCarta(Carta(valor: 10));
  expect(acepto, true);
});

test('si el descarte descendente no acepta una mayor', () {
  DescarteDescendente descarte = DescarteDescendente();
  descarte.recibeCarta(Carta(valor: 5));
  bool acepto = descarte.recibeCarta(Carta(valor: 10));
  expect(acepto, false);
});

test('si el descarte descendente acepta una de exactamente mayor en 10', () {
  DescarteDescendente descarte = DescarteDescendente();
  descarte.recibeCarta(Carta(valor: 10));
  bool acepto = descarte.recibeCarta(Carta(valor: 20));
  expect(acepto, true);
});
  });

  group('Jugador', () {
    test('Probar que la mano inicial es de la cantidad limite mximo', () {
      Jugador j = Jugador(nombre: 'Juan', mano: IList([]));
      Mazo mazo = Mazo();
      j.robar(mazo: mazo, limiteMaximo: calcularLimiteMaximoCarta(numeroJugadores: 1));
      expect(j.mano.length, equals(8));
    });
  });

}