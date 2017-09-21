---
title: "El Motor Físico de Phaser: Colisiones"
# author: Carlos León e Ismael Sagredo
# vim: spelllang=es
...


# Introducción

---

Normalmente es el motor físico el que se encarga de las colisiones de los cuerpos


Es una librería que proporciona una simulación aproximada de un cierto sistema de física como
cuerpos rígidos, cuerpos blandos, fluidos, colisiones, telas...

---

Se usa en videojuegos y simulación

En la mayoría de los juegos, la velocidad de ejecución es más importante que 
la precisión de la simulación 

Por tanto se busca hacer aproximaciones


## Algunos motores físicos 3D

- `Physx`: propiedad de Nvidia y disponible en Unreal Engine y Unity
- `Hawok`: antes propiedad de Intel, ahora adquirido por Microsoft y disponible en CryEngine


## Algunos motores físicos 2D

- `Box2D`: Cocos, Unity, Construct 2 (Angry Birds, Limbo)
- `Chipmunk:` Cocos, Wii



# El motor físico de Phaser


## Motor físico de Phaser

O mejor dicho: **los motores físicos de Phaser**

---

En Phaser hay tres motores físicos disponibles:

- **Arcade Physics**
- **Ninja Physics**
- **P2 Physics**

---

## Arcade Physics


Pensado para tratar colisiones AABB (axis-aligned bounded rectangles): para manejar objetos sin rotaciones

Sólo se comprueba si existen colisiones (solapamiento o overlapping) entre dos rectángulos

Tiene problemas con las áreas transparentes

Está pensado para juegos sencillos

---

## Ninja Physics

Admite rotaciones, y formas más complejas (cuestas)

Tiene más precisión, pero es más lento

Un juego de plataformas sin física compleja usaría este motor

---

## P2 Physics

Tiene un modelo de física mucho más avanzado, *springs* (muelles), polígonos, fuerzas, restricciones

Angry Birds usaría este motor

# Colisiones


## ¿Qué es una colisión?


Cuando dos *bounding boxes* están solapados

Un **Bounding Box** es una caja que representa el objeto (lo simplifica). El tamaño por defecto del bounding box de Phaser
es el tamño del sprite

---

Esto es un Bounding Box

![Bounding box](imgs/custom-physics-aabb.png)


---


Y esto es una colisión entre dos bounding boxes (overlapping)

![Overlapping entre bounding boxes](imgs/custom-physics-least-overlap.png)


## ¿Cómo se calcula la colisión?


Las colisiones más sencillas del motor Arcade son colisiones AABB que se pueden
calcular de la siguiente manera:


```js
function AABBvsAABB(a, b) {
    if(a.max.x < b.min.x || a.min.x > b.max.x) 
        return false;
    else if(a.max.y < b.min.y || a.min.y > b.max.y) 
        return false;
    else
        return true
}
```

---

Phaser hace este cálculo por nosotros


# El motor físico Arcade


## Inicialización del motor Arcade


[Ejemplo del uso del motor arcade](https://phaser.io/sandbox/edit/rGYAfFoJ)


Para iniciar el motor de fisica:

```js
this.game.physics.startSystem(Phaser.Physics.ARCADE);
```


## Agregar entidades a la física


```js
this.player = game.add.sprite(100, 200, 'player');
this.game.physics.arcade.enable(player);
```


## Colisionar con los límites del del mundo


```js
player.body.collideWorldBounds = true
```


## Crear grupo que colisione con un sprite


Se utiliza `physicsGroup()`{.js};


```js
    platforms = game.add.physicsGroup();

    platforms.create(500, 150, 'platform');
    platforms.create(-200, 300, 'platform');
    platforms.create(400, 450, 'platform');
    platforms.setAll('body.immovable', true); //se establece como plataformas estáticas
```

## Comprobar colisiones entre dos objetos

Si queremos comprobar si hay colisión a mano, usamos:

```js
this.game.physics.arcade.collide(player, platforms);
```


---

Si queremos que nos avisen si hay colisión hay que cargar un evento: 


```js
this.game.physics.arcade.collide(player, platforms, onCollision);


// el método recibe dos parámetros, son los objetos que han colisionado
function onCollision(obj1, obj2)
{
// hacer algo
}
```

--- 


`collide`{.js} devuelve un booleano que indica si ha habido colisión:

```js
if(!game.physics.arcade.collide(player, platforms, onCollision)) {
    textInfo.text = "No hay colision";
}
```


## Colisiones con un tilemap


Ejemplos sacados de el ejercicio número 3:

```js
// Creamos el tilemap y sus layer
this.map = this.game.add.tilemap('tilemap');// creo el map al vuelo o lo predefino en el objeto...
this.map.addTilesetImage('patrones','tiles'); // Asignar el patrón al spritesheet
// Creación de las layers
this.backgroundLayer = this.map.createLayer('BackgroundLayer');
this.groundLayer = this.map.createLayer('GroundLayer');
//plano de muerte
this.death = this.map.createLayer('Death');

// le decimos que 
this.map.setCollisionBetween(1, 5000, true, 'GroundLayer');

var collisionWithTilemap = this.game.physics.arcade.collide(this._rush, this.groundLayer);
```


## Colisión en un intervalo


* Colisiona con el rango de tiles que se indican en `start`--`stop`.
* `collides`{.js} es un booleano que activa o desactiva la colisión
* `layer` es donde opera → la capa del tilemap.


```js
setCollisionBetween(start, stop, collides, layer);
```

---

Por ejemplo:


```js
setCollisionBetween(1, 6); // tiles 1, 2, 3, 4 y 5 de la capa actual colisionan
// lo mismo que
setCollisionBetween(1, 6, true, this.currentLayer); 
```

---


### Colisión por exclusión


* indexes es un array que contiene los `id`'s de los tiles excluídos
* `collides` es un booleano que activa o desactiva la colisión
* `layer` es la capa en la que donde opera la función

```javascript
setCollisionByExclusion(indexes, collides, layer, recalculate);
```

---

Por ejemplo:

```js

map.setCollisionByExclusion([93, 94, 95, 96], true);
```

---


### Colisión con toda la capa del tilemap


```js
setCollision(collides, layer)

//podéis sustituir en la práctica por esto:
this.map.setCollision(true, 'GroundLayer');
```
