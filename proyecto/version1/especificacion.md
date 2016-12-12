---
title: "Práctica 3: primera versión de un videojuego en JavaScript (arcade
plataformas)"
vim: spelllang=es
...

Esta práctica consiste en hacer un arcade 2D de plataformas en Phaser, que se
pueda ejecutar, por tanto, en un navegador. El objetivo es aplicar los
conocimientos adquiridos durante el curso hasta la fecha y empezar a
relacionarlos como un juego.

A diferencia de las prácticas anteriores, para esta no hay un guión específico,
ya que cada grupo tendrá que diseñar y crear su propio juego.

# Continuación de la práctica

Las prácticas 4 y 5 (a priori) serán continuaciones de la 3 en las que se
añadirán características y empaquetado. Por lo tanto, es importante (y
recomendable) que se procure hacer una base de código robusta, mantenible y de
calidad con el fin de que las ampliaciones tengan un coste razonable.

# El juego

La temática y la mecánica del juego son libres, siempre y cuando se adhieran a
los siguientes requisitos:

## Características obligatorias

- Será un [juego de plataformas](https://en.wikipedia.org/wiki/Platform_game)
  en 2D.
- Puede ser vertical, horizontal o de recorrido libre.
- Se usará Phaser como motor de juego. Es posible usar otras librerías, siempre
  que su funcionalidad no solape con la que se espera que se implemente. El
  equipo docente tendrá que aceptar el uso de las librerías propuestas a
  priori. Si un grupo usa librerías que no sean aceptadas de antemano por el
  equipo docente, *la práctica estará suspensa*.
- La entrada se hará por teclado.
- Se incluirán:
    - una pantalla de carga, 
    - una pantalla de menú 
    - un modo de juego al menos con un nivel
    - una pantalla de pausa durante el juego con al menos dos opciones: Continuar el juego y Salir. Salir te llevará al menú principal.
    - un modo de "fin de partida", bien al superar el o los niveles, bien cuando muere el jugador.
- Se tratará de llevar un personaje desde un punto a otro. El personaje podrá
  moverse hacia la izquierda y la derecha y podrá saltar. 
    - Al llegar al punto exitosamente, se informará de la victoria y se irá al
      menú tras la pantalla de fin de partida.
    - Si "muere", se informará también y se irá al menú tras la pantalla de fin
      de partida.
- Al menos debe haber un tipo de enemigo.
- "Morirá" por contacto con enemigos, que obligatoriamente han de moverse
  (aunque sea simplemente en la dirección contraria).
- También podrá morir "cayendo" por zonas
- Los niveles se crearán con tiles, y se usará el formato de `Tiled` (se
  recomienda usar esta herramienta).
- No se tendrán en cuenta las animaciones, parallax o el audio, ya que serán el
  núcleo de las ampliaciones de la práctica 4.
- No se tendrá en cuenta el despliegue del juego, ya que será el núcleo de
  las ampliaciones de la práctica 5.

Además, se hará un mini "GDD" que **no podrá exceder de una cara en A4** en ningún caso. Es decir,
será un documento corto descriptivo en el que tendréis que:

- Poner título al juego.
- Publico objetivo, calificación de edad estimada.
- Contar la historia (es obligatorio una) y los objetivos.
- Explicar cómo jugar.
- Hacer un poco de "venta" del juego: ¿por qué querría alguien jugar al juego?
- Referencias utilizadas.

## Características opcionales

*Todas*. Cualquier aspecto extra del juego, tanto a nivel tecnológico como de
diseño, será aceptado y tenido en cuenta tanto para compensar la evaluación
como en el apartado de la colaboración de evaluación continua.

No hay límite en lo que se puede hacer. La intención de esto es animaros a que
creéis videojuegos y olvidéis un poco la nota y la evaluación. Pensad que, si
el juego merece la pena ser publicado online, será una primera página de
vuestro *portfolio*.

## No es una práctica de diseño de juegos

Es importante tener en cuenta que no se trata de una práctica de diseño de
videojuegos. Por supuesto que se valorará cualquier apartado de  *game-play* o
gráfico, pero no compensará ningún defecto en la programación (la asignatura,
al fin y al cabo, es de componente técnico).

Aún así, tened en cuenta que al final del curso se harán presentaciones de
vuestros proyectos y, cuanto mejores sean, más valor se les dará y, lo más
importante, más habréis aprendido.
