---
title: "El Motor Físico de Phaser: El Motor Ninja y P2"
# author: Carlos León e Ismael Sagredo
vim: spelllang=es
...


# Colisiones con el Motor Ninja

---

El motor Ninja está pensado para una simulación mucho más realista de la física. Por ejemplo, permite crear sprites o tiles con partes transparentes aunque de formas muy limitadas. Tener cuestas y poder deslizarte por las mismas, así como poder empujar otros objetos. Sigue sin tener rotación de sprites, por lo que un objeto no puede rodar sobre una pendiente, simplemente se desliza. 

---

Características del motor Ninja

* Permite colisiones entre círculos y rectángulos.
* Permite objetos inamovibles.
* Mejor soporte de gravedad y rebotes.
* Soporte de tiles con ciertas formas como cuestas o picos.



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

Añade un tile o una lista de tiles a la física con la que posteriormente se podrán colisionar.

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

* El tile 32 es un tile físico de tipo 1
* El tile 95 es un tipo de tile físico 2 (cuesta arriba 45º)
* El tile 137 es un tipo de tile físico 3 (cuesta abajo 45º)



## ¿Que id de tile físico?


![Tenemos de ayuda una imagen de depuración](http://examples.phaser.io/assets/physics/ninja-tiles128.png)


## Colisión con los tiles físicos

llamamos al método **circle.collideCircleVsTile** si es un círculo o **collideAABBVsTile** si es un rectángulo.

```js
    for (var i = 0; i < tiles.length; i++)
    {
        sprite1.body.circle.collideCircleVsTile(tiles[i].tile);
        sprite1.body.circle.collideAABBVsTile(tiles[i].tile);

    }
``` 

## Consultar la colision

```js
game.physics.ninja.collide(sprite1, tile1, collisionHandler, null, this);
```
* collideCallback (3º parámetro) (collisionHandler): callback de la colisión. Los dos objetos son pasados a la función (function (obja,objb){})
* processCallback (4º parámetro) (null) : callback para procesar la colisión. Añade una condición para que se ejecute el método collideCallback sólo si processCallback es true.
* context (5º parámetro) (this) el contexto de la colisión. 
* devuelve un booleano informando de si se ha producido o no la colisión.


## consultar overlapping

```js
game.physics.ninja.overlap(sprite1, tile1, collisionHandler, null, this);
```

* overlapCallback (3º parámetro) (collisionHandler): callback si se produce overlap. Los dos objetos son pasados a la función (function (obja,objb){})
* processCallback (4º parámetro) (null) : callback para procesar overlapping. Añade una condición para que se ejecute el método overlapCallback sólo si processCallback es true.
* callbackContext (5º parámetro) (this) el contexto de la colisión.
* devuelve un booleano informando de si se ha producido o no el overlapping.


## Ejemplos con Ninja

El motor Ninja no está disponible en el editor Sandbox online :(

Pero tenemos ejemplos en Phaser :)

[Ejemplos con el motor Ninja](https://phaser.io/examples/v2/category/ninja-physics)


# Colisiones con el motor P2




## P2 Engine


P2 permite crear colisiones físicas mucho más complejas. Aquí no nos restringimos a unos cuantos tiles que aproximan el objeto como lo que hemos visto en el Ninja engine. Aquí podemos ajustar muchísimo más los bounding boxes de forma que podemos adaptarlos a la forma del sprite.


---


![Arcade vs P2](imgs/physics-editor-arcade-p2.png)



## Editor de físicas


Estas aproximaciones a la forma del sprite no las hace Phaser automáticamente, por lo que debemos crearlas a mano. Existen muchos editores de física 2D, pero uno de los más usados es **PhysicsEditor**

[physicseditor](https://www.codeandweb.com/physicseditor)


## Physics Editor

 Permite exportar a múltiples formatos: Unity, Cocos2d, Flash, Corona...
 
 En concreto Lime + Corona (JSON) también permite exportar a Phaser ya que es compatible corona (JSON).
 
 Esto genera un json con la descripción de los cuerpos físicos. Los antiguos Bounding Box ahora se convierten en **Shapes**.
 
 
## Iniciar P2 Engine

```js 
game.physics.startSystem(Phaser.Physics.P2JS);
```

 
## Cargar los poligonos en la física
 

Para añadir la descripción de la física a la cache usamos **load.physics**
 
```js 
game.load.physics('physicsData', 'assets/physics/sprites.json');
```

[ejemplo de colisiones con P2](https://phaser.io/examples/v2/p2-physics/contact-events)

---

Para añadirle una shape a un sprite **loadPolygon**.

```js 
sprite = game.add.sprite(100, 200, 'Mario');
sprite.body.clearShapes();
sprite.body.loadPolygon('physicsData', 'Mario');
```


## Añadir un cuerpo a la física y depuración

**enable** permite añadir cuerpos a la física. El segundo atributo si está a true muestra la información de la forma del collider.

```js 
game.physics.p2.enable(ship, false);
```

## Activar los eventos de colisión


Sin ello, la física no generará eventos.

```js 
    game.physics.p2.setImpactEvents(true);
```

## Chequear colisiones

Para chequear los diferentes eventos de colision de un objeto (**onBeginContact**, **onEndContact**) accedemos a su body físico y cargamos el evento con **add**.

```js 
block.body.onBeginContact.add(blockHit, this);
block.body.onEndContact .add(blockHitEnd, this);

function blockHit (bodyA, bodyB, shapeA, shapeB, equation) {}

function blockHitEnd (bodyA, bodyB, shapeA, shapeB) {}
```

---

* **bodyA** y **bodyB** son los cuerpos que colisionan.
* **shapeA** y **shapeB** son sus colliders.
* **equation** array con los puntos de contacto.


## Grupos de colision

Permite especificar qué tipos de objetos colisionan con cuales y que evento lo procesará.

```js 
    var playerCollisionGroup = game.physics.p2.createCollisionGroup();
    var pandaCollisionGroup = game.physics.p2.createCollisionGroup();
    
    panda.body.setCollisionGroup(pandaCollisionGroup);
    ship.body.setCollisionGroup(playerCollisionGroup);
    
    ship.body.collides(pandaCollisionGroup, hitPanda, this);
```


--- 

```js 
function hitPanda(body1, body2) {
    body2.sprite.alpha -= 0.1;
}
```


## Física con tilemaps


Establecer los tiles colisionables: setCollision | setCollisionBetween ... 


```js 
 map.setCollisionBetween(1, 12);
```


---


Convertir un mapa en tiles: Convierte todos los mapas con tiles cuadrados sin tener en cuenta su transparencia. Para ajustar la forma hay que pasarle la información del editor de shape a cada tile como hemos hecho anteriormente.

```js 
game.physics.p2.convertTilemap(map, layer);
```


## Ejemplos con P2


[Ejemplos con P2 Engine](https://phaser.io/examples/v2/category/p2-physics)


