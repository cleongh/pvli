---
title: Introducción a la arquitectura de videojuegos
#author: Carlos León
#date: 18/10/2016
#vim: spelllang=es
...

# Qué es la arquitectura de un juego

---

Los videojuegos son, normalmente, sistemas complejos y grandes

---

Tienen muchos subsistemas que, además, gestionan aspectos distintos y hasta
tecnologías heterogéneas

<!-- TODO [Carlos, 19-10-2016 12:32]: foto de subsistemas -->

---

La complejidad puede crecer tanto, que carecer de un diseño global coherente
*puede hacer inmanejable el desarrollo*

---

Por eso se usan *arquitecturas*

Un arquitectura, análoga a la de un edificio, es una manera de organizar el
código para hacer el desarrollo más eficiente

<!-- TODO [Carlos, 19-10-2016 12:34]: foto de Unity -->

---

Pensad en sistemas que hacen muchas cosas, como Unity

<p class="fragment">¿Podríais implementar Unity?</p>

---

Unity es un motor de juego entero

<p class="fragment">(y, además, un editor)<p>

---

Cada parte de un motor de juego como Unity tiene que:

- Ser modificable
- Ser ampliable
- Ser independiente
- Comunicarse con las demás
- Hacer todo esto de forma que los *programadores* empleen el mínimo esfuerzo

# Por qué pensar en la arquitectura

---


La arquitectura software de un videojuego no es para la *máquina*, es para el
*programador*

Pensad en un juego cuyo código comunique los módulos de varias maneras
distintas

---

Cuando se tienen 6 subsistemas distintos, la organización del código es
*indispensable*

Además, puede tener impacto en la eficiencia

# Repaso de programación orientada a objetos


---

Un paradigma de programación muy usado para sistemas software que requieren
arquitecturas complejas es la *programación orientada a objetos* basada en clases

## Clases

---

Las clases son los tipos, las estructuras de las que se crean instancias

![Ejemplo de clases](imgs/umlbasico.pu.svg)


## Instancias

---

Las instancias son cada uno de los elementos/objetos concretos que tienen las
propiedades (atributos y métodos) de una clase

---

Aquí, `player`{.cpp} y `enemy`{.cpp} son instancias de `Player`{.cpp} y
`Enemy`{.cpp} respectivamente:

```cpp
Player player("player", 10, 10, 0, 0, 100);
Enemy enemy("enemy", 15, 15, 0, 0, &player);
```

## Relaciones

---

Las clases, como módulos, se relacionan en un sistema

Hay muchos tipos de relaciones y muchas maneras de usarlas, aquí sólo
comentamos algunas

## Herencia

---

Las clases pueden *heredarse*, de forma que una clase *hija* **es-una**
(`is-a`) clase padre también

![Clases para estructurar un juego](imgs/herencia.pu.svg)

## Uso

---

Las clases pueden *usarse* unas a otras, de forma que se *pasen mensajes*

![Clases que se usan](imgs/asociacion.pu.svg)

## Composición

Las clases pueden *componerse*, de forma que la relación es muy fuerte. Así, si
desaparece el todo, *desaparecen las partes también*

![Composición de clases](imgs/composicion.pu.svg)


# Arquitecturas basadas en herencia

---

La programación orientada a objetos clásica permite una manera de modular sistemas

---

Entre otros, los videojuegos son razonablemente complejos y manejan dos
aspectos que hay que gestionar:

- Modelo de datos (orco, espada, mundo...)
- Modelo de sistemas (gráficos, sonido, entrada...)


---

Muchos videojuegos se han modelado con patrones de herencia

<p class="fragment">¿**Por qué**?</p>

---

¿Por qué *no* seguimos haciéndolo?

<p class="fragment">(Hay mucha gente que sigue haciéndolo, y en muchos casos no es un problema)</p>

## El problema de la herencia

La herencia se basa en la relación *es-un*

---

Muchas veces:

- todos los `Enemigos` son `Movibles`
- todos los `Jugadores` son `Personajes`
- todos los proyectiles son objetos `Físicos`


---

Intentémoslo: 

`entidad` → `movible` → `visible` → `jugador`

---

![Herencia básica](imgs/herenciacorrecta.pu.svg)


---

¿Pero qué pasa cuando queremos crear...

- ... un enemigo *invisible*?
- ... un proyectil manejado por la red?
- ... un enemigo que no tiene propiedades gráficas?


---

Ahora hagamos un jugador que no se puede mover:


![Herencia problemática](imgs/herenciaproblema.pu.svg)

---

A finales de los 90 esto se convirtió en un problema claro, y las arquitecturas
por componentes de entidad se generalizaron

En general (y mucho en diseño de videojuegos) preferimos [composición antes que
herencia](https://en.wikipedia.org/wiki/Composition_over_inheritance)

# Sistemas de componentes

---

Para aliviar los problemas relativos de la estructura de herencia (con
*es-un*), usamos
[**componentes**](https://en.wikipedia.org/wiki/Entity_component_system)

## Qué es un componente

---

Un componente es un aspecto, una propiedad o característica que tiene una
*entidad*

---

Por ejemplo, podemos tener un componente que sirva para pintar

Este componente se usará *sólo para pintar*, y no sabrá nada del sonido

---

También podríamos añadir un componente para modelar un inventario

El componente no sabrá nada de la entidad que lo contiene. Sólo tendrá
información de cómo guardar objetos

---

Puede haber un componente para las entidades que son visibles, y otro
componente para las entidades que tienen respuesta física al sistema
(tabla @tbl:componentes)

---

 Entidad   Física    Visible 
--------- -------- ----------
 Nube        ✗         ✓
 Orco        ✓         ✓ 
 Trigger     ✗         ✗ 
 Espíritu    ✓         ✗ 

: Entidades y sus componentes correspondientes {#tbl:componentes}

## Entonces, ¿qué es una entidad?

---

Una *entidad* no es más que un identificador, un elemento vacío que *contiene
componentes*

La entidad no tiene información de cómo pintarse, ni de cómo moverse

---


- Un personaje ("player") será una entidad
- Un *trigger*, también
- Un botón
- Los enemigos


---


Es decir, una entidad es algo genérico que *sólo tiene una lista de
componentes*

```js
var entidad = {
   id          : 4,
   componentes : [
        drawable,
        sound,
        movable,
        physics
   ]
}
```



---

La entidad **delega** en sus componentes todo el comportamiento:

```js
// en cada ciclo (tick), la entidad simplemente 
// delega en sus componentes
Entity.prototype.tick = function() {
    this.components.forEach(function(component) {
        component.tick();
    });
}
```


# Sistemas de entidades

---

Cada componente tiene información sobre un aspecto del juego

- Física
- Gráficos
- Sonido
- Entrada
- Colisiones
- Bandos
- Inventario
- ...


## Sistemas

---

Tiene sentido, por lo tanto, **dividir** el código en partes (hacer módulos)
que se encarguen de trabajar los dominios correspondientes

Cada uno de estos módulos suelen llamarse *sistemas* o *subsistemas*

---

Cada sistema suele^[Sí, en arquitectura no hay teorías generales. Las cosas
"suelen" hacerse de una u otra manera] manejar y tener acceso a los componentes
correspondientes

---

Por ejemplo, en la parte física no suele influir mucho el sonido:

![Relación entre sistemas y componentes](imgs/sistemascomponentes.pu.svg)

---

Así pues, `AudioComponent` sólo se relaciona con `AudioManager` (y,
probablemente, con `Entity`) pero no sabe nada de `PhysicsManager`

# Hay muchas maneras de hacer arquitecturas

---

En este tema hemos visto (y veremos) *una manera* de hacer arquitecturas por
componentes, pero hay muchas

---

Paso de mensajes, entidades puras, sistemas independientes o acoplados... cada
decisión de diseño depende del problema a resolver

---

> No hay una solución general para todos los problemas
