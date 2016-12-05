---
title: "El Motor Físico de Phaser: Fuerzas Físicas, el motor P2"
# author: Carlos León e Ismael Sagredo
vim: spelllang=es
...


# Introducción


## Hasta ahora...

Hemos visto colisiones. Ahora veremos una variante de las colisiones que denominamos **Triggers**. 
Los triggers son un método muy utilizado en videojuegos para generar eventos durante el juego. 



# Triggers (sensor)



## ¿Qué es un trigger?

Podemos definir un **trigger** (disparador) como una zona del juego en la que se chequea que objetos entran y salen de ella, informando de ambos eventos a quienes esten interesados.
Normalmente un trigger provoca una invocación a un método asíncrono (evento) asociado a dicho trigger. 

---

Al concepto de trigger a veces se le denomina **sensor**. Por ejemplo, ese es el nombre que utiliza Box2D. 

P2 también utiliza el concepto de sensor. 

---

Para establecer que un collider es un sensor hay que modificar la shape de la física.

```js
sprite.body.data.shapes[0].sensor = true; // Establece que la shape 0 es un sensor.
```
o bien

```js
    triggerShape = trigger.body.addRectangle(10,4,0,-54); //añade un sensor al objeto. Devuelve un shape.
    triggerShape.sensor=true; // modificamos la shape marcándola como sensor.
```

---

<!-- https://codepen.io/codevinsky/pen/JAoHa -->

Al marcarla como sensor, la shape no colisiona con el resto de la física. Por tanto, al objeto se le puede atravesar sin que se produzcan rebotes.

---

Pero podemos seguir escuchando los eventos de contacto

```js
    trigger.body.onBeginContact.add(checkSensorsBegin,this);
    trigger.body.onEndContact.add(checkSensorsEnd,this);
    
function checkSensorsBegin(bodyA,shapeA,shapeB){
    game.debug.text("Collision detected!", 32, 32);
}

function checkSensorsEnd(bodyA,shapeA,shapeB){
    game.debug.text("Collision leaved!", 32, 32);
}
```

# Velocidad


## ¿Qué es la velocidad?
<!-- https://www.codeandweb.com/physicseditor/tutorials/phaser-p2-physics-example-tutorial -->

La **velocidad** es una magnitud física vectorial que expresa la distancia recorrida de un objeto por unidad de tiempo.

Se puede modificar en Phaser directamente en el body físico.

```js
sprite.body.velocity.x
sprite.body.velocity.y
```

Si aplicamos una velocidad a un objeto físico este se moverá hacia la dirección indicada con la magnitud indicada.


## Aplicando fuerzas

una **fuerza** es todo agente capaz de modificar la cantidad de movimiento de un objeto. En física de videojeugos llamamos fuerza a una modificación constante del movimiento de un objeto.

applyForce(force, worldX, worldY)

* force: es un vector 2D (Por ejemplo: [ 200, 100])
* Tanto los puntos WorldX como WoldY, localX, localY son el punto a partir del cual se está aplicando la fuerza. 


## Aplicando impulsos

Un impulso es una fuerza que se ejerce en un momento puntual pero que cesa y se reduce con el tiempo.

applyImpulse(impulse, worldX, worldY)
applyImpulseLocal(impulse, localX, localY)

* impulse: es un vector 2D (Por ejemplo: [ 200, 100])
* Tanto los puntos WorldX como WorldY, localX, localY son el punto a partir del cual se está aplicando el impulso. Si no se especifican se toma el centro del mundo o el centro de masas del objeto.


## Move

* moveRight, moveUp, moveLeft, moveDown

* Mueven el objeto sin necesidad de cambiar la rotación.

* moveForward, moveBackward

* Mueven el objeto en la dirección de rotación del mismo. Si queremos girar tendremos que rotar el objeto.

* thrust: impulsa el objeto hacia su ángulo de orientación (forward)

## Gravedad

La gravedad es un tipo de fuerza constante hacia una dirección. Normalmente hacia abajo:


```js
game.physics.p2.gravity.y = 300;
```

---


Podemos modificar la velocidad relativa de cada objeto usando **gravityScale**

```js
    sprite1.body.data.gravityScale = 1;
    sprite2.body.data.gravityScale = 0.5;
    sprite3.body.data.gravityScale = 0.25;
```

[gravityScale](http://phaser.io/examples/v2/p2-physics/gravity-scale)


# Aceleración


## ¿Qué es la aceleración?

La aceleración es una magnitud vectorial que nos indica la variación de velocidad por unidad de tiempo.



---

En física se define la velocidad uniformemente acelerada como:

v=v0+a⋅t

Donde:

* v: velocidad.
* v0: velocidad inicial.
* a: aceleración.


---

El desplazamiento:


![Aceleración](imgs/aceleracion.svg)

* e(t): posición
* e0: posición inicial.
* t: tiempo.
* a: aceleración.
* vo: velocidad inicial.


---


Veamos un ejemplo



```js
function accelerateToObject(obj1, obj2, speed) {
    var angle = Math.atan2(obj2.y - obj1.y, obj2.x - obj1.x); //Ángulo entre dos vectores (arcotangente)
    obj1.body.rotation = angle + game.math.degToRad(90);  // corrige el ángulo (depende del sprite)
    obj1.body.force.x = Math.cos(angle) * speed; // proyección del ángulo en x * módulo.
    obj1.body.force.y = Math.sin(angle) * speed; // proyección del ángulo en y * módulo
}
```


[Aceleración](http://phaser.io/examples/v2/p2-physics/accelerate-to-object)


# Constrains


## ¿Qué es una constraint?

Una **Constraint** es una restricción al movimiento.

```js
var constraint = game.physics.p2.createDistanceConstraint(sprite1, sprite2, 150);
var constraint1 = game.physics.p2.createGearConstraint(sprite, sprite2, 0, 1);
```

* Distance constraint  afecta a la distancia a la que puede estar un objeto de otro. [Distancia](https://phaser.io/examples/v2/p2-physics/distance-constraint)

* Gear constraint afecta a la velocidad de rotación a la que puede girar un objeto con respecto a otro. [Gear](https://phaser.io/examples/v2/p2-physics/gear-constraint)


## Joins

Son un tipo especial de constraint.

Conecta dos cuerpos creando una restricción de rotación. Un objeto rota en función del otro. Esto sirve para construir objetos pendulantes como cuerdas o cadenas. Básicamente cualquier sistema donde el movimiento de uno afecte al movimiento del resto
en algén grado.


---

game.physics.p2.createRevoluteConstraint
(bodyA, pivotA, bodyB, pivotB, fuerza) 

* bodyA Objeto padre
* punto de pivote de A
* bodyB Objeto hijo.
* punto de pivote de B.
* Fuerza Máxima que mantiene a las partes juntas.

[Chains](https://phaser.io/examples/v2/p2-physics/chain)


## Springs

Los **Springs** o muelles sirven para mantener una distancia flexible a un objeto.

```js
spring = game.physics.p2.createSpring(bodya, bodyb, 0, 30, 1);
```

* **restLength**: La longitud del spring.
* **stiffness**: Rigidez del spring.
* **damping**: Amortiguación.

[Springs](https://phaser.io/examples/v2/p2-physics/mouse-spring)


# Kinematic Body



## Cuerpos Kinemáticos Vs Cuerpos Físicos.

**Kinematic bodies** son cuerpos que están en la física pero que queremos mover nosotros por código.

Típicamente las plataformas de los juegos de plataforma. También se suelen incluir los enemigos que son controlados por la IA o el player si no modificamos su posición con la física. 


---

En un juego normal, no queremos usar la física para mover un objeto controlado por el jugador o por la IA ya que esto puede provocar muchos problemas. 

La física es dificil de controlar y produce errores de redondeo. 

Lo más razonable para garantizar las mecánicas es moverlo nosotros con la lógica del juego. 


Sin embargo, sí que queremos tener colisiones, de ahí que necesitamos que pertenezca a la física de alguna forma.


## ¿Cómo establecemos un cuerpo kinemático?


Podemos modificar la propiedad kinematic de body;

```js
kinematic1.body.kinematic = true;
```

---


## ¿Qué cosas afectan a un kinemático?


A un objeto kinemático no le afecta la gravedad

Ni los impulsos 

Ni las colisiones modifican la velocidad del objeto, es decir un choque impide le paso, ero no modifica la velocidad del objeto, porque la física no peude alcular la velocidad de un objeto kinemático. 

Solo podemos preguntar si hemos colisionado con el.

O si él ha colisionado con algo.


[Movimientos kinemáticos](https://phaser.io/examples/v2/p2-physics/kinematic-body)


