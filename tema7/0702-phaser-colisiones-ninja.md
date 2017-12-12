---
title: "El Motor Físico de Phaser: El Motor Ninja y P2"
# author: Carlos León e Ismael Sagredo
# vim: spelllang=es
...

# Colisiones con el Motor Ninja

---

El motor Ninja está pensado para una simulación mucho más realista de la física

---

Por ejemplo, permite crear sprites o tiles con partes transparentes aunque de formas muy limitadas

---

Tener cuestas y poder deslizarte por las mismas, así como poder empujar otros objetos

Sigue sin tener rotación de sprites, por lo que un objeto no puede rodar sobre una pendiente, simplemente se desliza

---

Características del motor Ninja

- Permite colisiones entre círculos y rectángulos
- Permite objetos inamovibles
- Mejor soporte de gravedad y rebotes
- Soporte de tiles con ciertas formas como cuestas o picos



## Inicialización del motor Ninja


```js
game.physics.startSystem(Phaser.Physics.NINJA);
```


## Añadir un Bounding box

En forma de circulo:

```js
game.physics.ninja.enableCircle(sprite1, sprite1.width / 2);
```

En forma de caja

```js
game.physics.ninja.enableAABB(sprite1);
```

## Añadir un tile a la física

Añade un tile o una lista de tiles a la física como tile que puede colisionar

```js
//añade el frame actual del sprite que pertenece al conjunto tile1
game.physics.ninja.enableTile(tile1, tile1.frame);
```

## Convertir tiles gráficos en físicos

Dependiendo del tipo de tile, podemos construir deferentes mapas. En este ejemplo

[Ejemplos con tiles](https://phaser.io/examples/v2/ninja-physics/ninja-tilemap)

Podemos ver

```js
var slopeMap = { '32': 1, '77': 1, '95': 2, '36': 3, '137': 3, '140': 2 };
tiles = game.physics.ninja.convertTilemap(map, layer, slopeMap);
```

---

- El tile 32 es un tile físico de tipo 1
- El tile 95 es un tipo de tile físico 2 (cuesta arriba 45º)
- El tile 137 es un tipo de tile físico 3 (cuesta abajo 45º)


## ¿Que id de tile físico?

Cada tipo de forma física tiene un identificador

Puede mirarse el código, o esta imagen:

![Tenemos de ayuda una imagen de depuración](http://examples.phaser.io/assets/physics/ninja-tiles128.png){width=40%}


## Colisión con los tiles físicos

Llamamos al método `circle.collideCircleVsTile`{.js} si es un círculo o `collideAABBVsTile`{.js} si es un rectángulo

```js
    for (var i = 0; i < tiles.length; i++)     {
        sprite1.body.circle.collideCircleVsTile(tiles[i].tile);
        // dependiendo si es una figura con forma de ciculo o de AABB
        sprite1.body.aabb.collideAABBVsTile(tiles[i].tile);
    }
```

## Consultar la colisión

```js
game.physics.ninja.collide(sprite1, tile1, collisionHandler, null, this);
```

- `collideCallback`{.js} (3º parámetro) (`collisionHandler`{.js}): callback de la colisión. Los dos objetos son pasados a la función (`function (obja, objb){}`{.js})
- `processCallback`{.js} (4º parámetro) (`null`{.js}): callback para procesar la colisión. Añade una condición para que se ejecute el método `collideCallback`{.js} sólo si `processCallback`{.js} es true
- `context`{.js} (5º parámetro) (`this`{.js}) el contexto de la colisión.
- devuelve un booleano informando de si se ha producido o no la colisión


## Consultar overlapping

```js
game.physics.ninja.overlap(sprite1, tile1, collisionHandler, null, this);
```

- `overlapCallback`{.js} (3º parámetro) (`collisionHandler`{.js}): callback si se produce overlap. Los dos objetos son pasados a la función (`function (obja,objb){}`{.js})
- `processCallback`{.js} (4º parámetro) (`null`{.js}) : callback para procesar overlapping. Añade una condición para que se ejecute el método overlapCallback sólo si `processCallback`{.js} es true
- `callbackContext`{.js} (5º parámetro) (`this`{.js}) el contexto de la colisión
- devuelve un booleano informando de si se ha producido o no el overlapping


## Ejemplos con Ninja

<!-- El motor Ninja no está disponible en el editor Sandbox online :(

Pero tenemos ejemplos en Phaser :) -->

[Ejemplos con el motor Ninja](https://phaser.io/examples/v2/category/ninja-physics)
