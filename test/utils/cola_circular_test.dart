import 'package:eljuego/utils/cola_circular.dart';
import 'package:test/test.dart';

void main() {
  test('si lo construyo con [1,2,3] el quienVa vale 1', () {
    ColaCircular c = ColaCircular([1,2,3]);
    expect(c.quienVa, equals(1));
  });

  test('Si con [1,2,3] el siguiente seria 2', () {
    ColaCircular c = ColaCircular([1,2,3]);
    var x = c.siguiente();
    expect(x, equals(2));
  });

  test('Si con [1,2,3] y quito al 2 el siguiente es 3', () {
    var c = ColaCircular<int>([1,2,3]);
    c.sacar(2);
    var x = c.siguiente();
    expect(x, equals(3));
  });

  test('que sea circular', () {
    var c = ColaCircular([1,2]);
    var x = c.siguiente();
    x = c.siguiente();
    expect(x, equals(1));
  });

  test('Paso una cola vacía', () {
    ColaCircular c = ColaCircular([]);
    c.quienVa;
  });

  test('Intento sacar elementos de una cola vaía', () {
    ColaCircular c = ColaCircular<int>([1]);
    c.sacar(1);
  });
}