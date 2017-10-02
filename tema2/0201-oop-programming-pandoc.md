---
title: Programación orientada a objetos
author: Salvador de la Puente
date: 3/10/2016
vim: spelllang=es
...


# Modelado de problemas

---

Programar es expresar un problema en un lenguaje de programación dado. Modelar
representa un paso intermedio en el que se capturan y organizan lon aspectos
importantes de un problema.

---

El modelado de un problema es independiente del lenguaje de programación que se
elija pero el lenguaje seleccionado condiciona la facilidad con la que podemos
codificar el modelo.

---

Muchas actividades creativas incluyen modelos intermedios entre la realidad y
su expresión en el medio final.

---

![Una página del story board de la serie de animación de Batman]( ./imgs/batman-storyboard.jpg)

---

Los _storyboard_ se utilizan para planificar las secuencias de acción. Capturan
los momentos clave de la secuencia.

---

![Notas de Tolkien para la elaboración del Señor de los Anillos](
./imgs/lotr-notes.jpg){width=30%}

---

Este mapa muestra el paso de "Ella-Laraña", usado para mantener la coherencia
del escenario descrito.

---

![Mapa del video juego Mario en papel cuadriculado](
./imgs/mario-level-design.png)

---

Un diseño de un mapa del videojuego Mario. Las herramientas digitales han
permitido la automatización de modelos en software.

---


![Diagrama de flujo del ciclo de vida de un script en Unity](
./imgs/monobehaviour-flowchart.png) <!-- .element: style="height: 400px;" -->

El diagrama de flujo de cómo se llaman las distintas funciones de un script
de Unity.


---


La programación orientada a objetos es una técnica de **modelado de problemas**
en la que se pone especial énfasis a dos conceptos: **objetos** y **paso de
mensajes**.



# Objetos


---

Los objetos son **representaciones de los aspectos de un problema**.


---

  * Hacen **una cosa solamente**.
  * Exponen un conjunto de **funcionalidad concreta**: la [API](
  https://en.wikipedia.org/wiki/Application_programming_interface#Libraries_and_frameworks).
  * **Ocultan** cómo realizan esa funcionalidad.


---


# Paso de mensajes


---

Los mensajes son **peticiones de acción** de un objeto a otro.


---

  * Parten de un objeto **remitente**...
  * ..hacia un objeto **destinatario**.
  * Codifican qué **funcionalidad de la API** se precisa.



# Modelado orientado a objetos


---

La definición de objetos y las interacciones entre los mismos modelan el
problema.


---

Vamos a modelar informalmente el video juego [Space Invaders](
https://en.wikipedia.org/wiki/Space_Invaders).

![captura de pantalla del video juego space invaders donde se aprecian naves
enemigas, la nave amiga, marcadores de vidas y puntuación, proyectiles amigos
y enemigos y las defensas de la nave.](./imgs/space-invaders.jpg)


## Identificando objetos


---

Una técnica para identificar objetos es pensar en **poner nombres**.


---

<object type="image/svg+xml"
        data="./imgs/space-invaders-objects.svg"
        data-svg-animation="space-invaders-objects">
![Captura de Space Invaders donde se distinguen muchos objetos: 50 enemigos,
9 defensas, 12 disparos, 2 marcadores, 1 nave protagonista...](
./imgs/space-invaders-objects.png)
</object>
<script id="space-invaders-objects">
[
  { "wait": 0.5 },
  { "el": ".circle", "length": 0.6 }
]
</script>


---

Algunos objetos: nave amiga, enemigo 1, enemigo 2, enemigo 3, disparo amigo,
disparo enemigo 1, disparo enemigo 2, defensa 1, defensa 2, marcador de vidas,
marcador de puntuación.


## Tipos de objetos e instancias


---

Queda claro de un vistazo que muchos objetos concretos pertenecen a familias
o **tipos** de objetos. Conviene recordar que también se los llama **clases**.


---

Los tipos **especifican propiedades y comportamientos comunes** a todos ellos
aunque individualmente sean distintos.


---

<object type="image/svg+xml"
        data="./imgs/space-invaders-types.svg"
        data-svg-animation="space-invaders-types">
![Captura de Space Invaders donde se distinguen los distintos tipos de objetos:
marcadores, defensas, enemigos, protagonista y disparos](
./imgs/space-invaders-types.png)
</object>
<script id="space-invaders-types">
[
  { "wait": 0.5 },
  { "el": ".circle", "length": 0.6 },
  { "el": ".quick-circle", "length": 0.2 }
]
</script>


---

Algunos **tipos**: marcadores, defensas, nave amiga, enemigos, disparos.


---

Las **instancias** son cada uno de los objetos individuales. El enemigo especial
será una instancia del tipo **enemigo**.


---

En los modelos de objetos es más conveniente trabajar con tipos de objetos.


---

<object type="image/svg+xml"
        data="./imgs/space-invaders-object-diagram.svg"
        data-svg-animation="space-invaders-object-diagram">
![Diagrama de objetos con los cinco clases identificadas: marcador, defensa,
enemigo, protagonista y disparo.](
./imgs/space-invaders-object-diagram.png)
</object>
<script id="space-invaders-object-diagram">
[
  { "wait": 0.5 },
  { "el": "#background", "length": 4 },
  { "el": "text", "length": 0.001 },
  { "el": ".obj-type", "length": 0.6 }
]
</script>


## Interfaces y métodos

---


Vamos a tratar de determinar la API de nuestros tipos de objetos. Para eso nos
guiarán las interacciones propias del juego.


---

<iframe width="560" height="315" src="https://www.youtube.com/embed/axlx3o0codc" frameborder="0" allowfullscreen></iframe>

Un ejemplo: _los enemigos se mueven todos juntos hacia un lado, avanzan una
línea y se mueven hacia el otro lado mientras disparan aleatoriamente._.


---

Vamos a **buscar verbos** esta vez: **mover**, **avanzar** y **disparar**.


---

Para poder implementar el comportamiento de los enemigos, estos tienen que
poder moverse hacia los lados, avanzar y disparar. Así, tendrán que permitir
que les envíen mensajes pidiendo una de estas operaciones.


---

API del tipo enemigo:
  * Mover hacia la izquierda.
  * Mover hacia la derecha. <!-- .element: class="fragment" -->
  * Avanzar. <!-- .element: class="fragment" -->
  * Disparar. <!-- .element: class="fragment" -->


---

A las cosas que puede hacer un objeto se las denomina **métodos**.


## Estado y atributos


---

Los objetos no sólo pueden hacer cosas sino que además capturan características
de las entidades a las que representan.


---

Cada enemigo, por ejemplo, tiene un **gráfico distinto**, una **puntuación
diferente**, una **posición en pantalla** y además recordará en qué **dirección
se estaba moviendo**.


---

El estado no se suele exponer de forma directa en la API. Por ejemplo, en el
caso de los enemigos, incluso si estos tienen una posición, es preferible
tener métodos específicos con qué manipular la posición como
"mover a la izquierda" o "mover a la derecha" en lugar de dejar libre acceso
a la posición.


---

Estado del tipo enemigo:
  * Gráfico.
  * Dirección actual. <!-- .element: class="fragment" -->
  * Posición. <!-- .element: class="fragment" -->
  * Puntuación. <!-- .element: class="fragment" -->


---

A los aspectos de un objeto se los denomina **atributos**.


## Constructores y creación de objetos


---

Pensemos en la interacción de disparo: _cuando el jugador pulsa el botón de
disparo, aparece un proyectil delante de la nave amiga que avanza hasta alcanzar
la parte superior de la pantalla o colisionar con un enemigo_.


---

El proyectil no estaba ahí antes y tendrá que ser creado en el momento del
disparo.


---

Otro ejemplo, la preparación del nivel antes de jugar: _aparecen 55 enemigos en
pantalla, 5 filas de 11 enemigos con la siguiente configuración: 1 fila de
enemigos de la especie 1, dos filas de la especie 2, 1 de la especie 3 y 1 de
la especie 4_.


---

Está claro que no queremos escribir los 55 enemigos individualmente. ¡Sobre todo
porque todos serán prácticamente iguales!


---

Lo que necesitamos es un mecanismo de **generación automática de objetos**.
Cada lenguaje ofrece formas distintas de crear objetos.


---

Nosotros vamos a añadir un nuevo objeto, el **contructor**, cuya tarea es la de
generar objetos de un tipo dado. Así, encontraremos **un contructor por tipo**.


---

Los constructores tienen una API muy sencilla: nuevo objeto. Este método crea
un nuevo objeto de un tipo dado.


---

Los constructores suelen permitir personalizar partes del objeto que están
creando de forma que se le pueda decir algo como "crea un enemigo con esta
posición, este gráfico y esta puntuación".


## Relaciones entre tipos


---

Cuando modelamos, surgen relaciones de forma natural. Los enemigos **tienen**
una posición. La nave amiga **crea** disparos.


---

Nuestro cerebro tiende a establecer jerarquías entre objetos creando tipos más
generalistas. Por ejemplo: en vez de pensar en enemigos y nave amiga por
separado, es posible pensar en **naves**.


---

El **tipo nave** reune los métodos comunes de la nave protagonista y enemigos:
  * Mover hacia la izquierda.
  * Mover hacia la derecha.
  * Disparar (pongamos que es disparar hacia abajo).


---

También reune los atributos comunes:
  * Gráfico
  * Posición


---

Los enemigos añadirián avanzar a la API. La puntuación y la última dirección
de desplazamiento serían atributos propios de los enemigos.


---

La nave amiga no añade ningún método nuevo pero reinterpreta el método disparar
para que dispare hacia arriba.


---

Esta jerarquía:
  * Nave.
    * Protagonista.
    * Enemigo.

Establece **relaciones de herencia** tambén llamadas relaciones "**es un**" dado
que **el protagonista es una nave** y **el enemigo es una nave**.


---

Como hay nuevos tipos, tendremos nuevos constructores. Los viejos constructores
pueden delegar parte de la creación del objeto (las partes comunes) a los
nuevos.



---

> OOP to me means only messaging, local retention and protection and
> hiding of state-process, and extreme late-binding of all things.

[Alan Kays sobre la programación orientada a objetos](
http://userpage.fu-berlin.de/~ram/pub/pub_jf47ht81Ht/doc_kay_oop_en)
