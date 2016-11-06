# Entidades de Phaser


<!-- Explicar la sandbox más en detenimiento. Hablar de las tabs y de cómo
vamos a enseñar en el código la parte más relevante. -->
Los ejemplos de esta lección pueden probarse en la sandbox de Phaser...



<!-- Hay que advertir que hay un bug en la documentación de Phaser más actual
que oculta algunas propiedades. Mirar 2.5 y 2.4 también. -->



## El servidor local
<!-- Quedamos en que esto lo mandábamos como ejercicio obligatorio y lo quitamos
de aquí. Algo como correr el servidor en local y cambiar el logo de Phaser por
uno propio. -->


Una vez hayas copiado la plantilla, lanza el siguiente comando:

```bash
$ node ./node_modules/gulp/bin/gulp run
```


Con ello lanzarás un navegador que cargará la plantilla proporcionada.


Fíjate en la URL del navegador. Indica `localhost:3000` que es el nombre de la
IP local y el número de puerto.


El comando `run` realiza los pasos necesarios para que no sea necesario recargar
cada vez que modifiquemos un archivo fuente. Los fuentes los puedes encontrar en
`src/js/`.



## Entidades `Image`


Las imágenes son las entidades visibles más simples de Phaser. Las entidades
son instancias de la clase [`Image`](
https://phaser.io/docs/2.6.2/Phaser.Image.html).


Su simplicidad las hace ligeras y eficientes en términos de memoria. Utilizamos
imágenes cuando no necesitamos comportamientos complejos como físicas o
animaciones por _keyframes_.


Aun así, las imágenes se pueden mover, rotar, escalar o recortar. Esto las hace
ideales para, por ejemplo, logos, imágenes de fondo, barras de carga,
elementos de interfaz...


Una imagen se crea a través del método factoría [`add.image`](
https://phaser.io/docs/2.6.2/Phaser.GameObjectFactory.html#image) del objeto
juego. Por ejemplo, como parte de la creación de un estado:


### Atributos relevantes de las imágenes


<!-- Contar positin (y contar Point), anchor, alpha, blendMode, angle, scale.
Recuerda que aparte de la Sandbox, puedes tirar de las demos de Phaser. -->


### Métodos relevantes de las imágenes


<!-- Contar crop -->



## El mundo


En Phaser, la factoría de objetos se llama añadir (`add`) por una razón:
**porque añadimos las nuevas entidades al mundo**.


Para Phaser, el mundo, representado por la clase [`World`](
https://phaser.io/docs/2.6.2/Phaser.World.html), es la **abstracción del lugar
(un plano bidimensional) donde habitan las entidades**.


![El mundo, la cámara y entidades más allá de los límites de la cámara](
./imgs/world.svg)


Miramos al mundo a través de
[cámaras](https://phaser.io/docs/2.6.2/Phaser.Camera.html).


![El mundo, la cámara y entidades más allá de los límites de la cámara](
./imgs/world-and-camera.svg)


En Phaser existe sólo un mundo, que se crea automáticamente cuando creamos el
juego y al que se puede acceder a través del atributo [`world`](
https://phaser.io/docs/2.6.2/Phaser.Game.html#world) del objeto de juego.


También se crea una cámara, a la que podemos acceder a través del atributo
[`camera`](https://phaser.io/docs/2.6.2/Phaser.Game.html#camera) del objeto de
juego o del mundo.


Este mundo tiene un tamaño inicial igual al tamaño indicado al construir el
juego pero se expandirá conforme incluyamos entidades que sobrepasen los límites
del espacio de juego.



## Entidades `Sprite`


La mayoría de las entidades visibles de un juego incorporan alguna animación
y comportamiento. La clase [`Sprite`](
https://phaser.io/docs/2.6.2/Phaser.Sprite.html) representa estas "entidades
animadas" y es el componente principal de los juegos con Phaser.


Aunque podamos añadir _sprites_ al mundo utilizando el método factoría
[`add.sprite`](
https://phaser.io/docs/2.6.2/Phaser.GameObjectFactory.html#sprite), el sprite
por defecto es tan simple que no se suele utilizar salvo en ocasiones donde
no se requiere un comportamiento complejo.


Este ejemplo es equivalente a añadir un _sprite_ con `add.sprite`:

```js
// En la pestaña create.
function create() {
  var sprite = new Phaser.Sprite(this.game, 0, 0, 'phaser');
  this.game.world.addChild(sprite);
}
```
https://phaser.io/sandbox/KTYGfoXs


En la mayoría de los casos los _sprites_ tendrán un comportamiento avanzado:
reaccionarán a los controles, ejecutarán algoritmos de IA, necesitarás métodos
auxiliares, etc.


Por ello, en lugar de usar instancias de las clase `Sprite`, es mejor que
creemos clases adaptadas a nuestras necesidades y añadir instancias de estas
clases.


Para ello, nuestras clases _sprite_ deben heredar de [`Phaser.Sprite`](
). Por ejemplo, considera el _sprite_ de un personaje que aparece aleatoriamente
y cae.


```js
function FallingMartian(game) {
  var x = Math.random() * game.world.width;
  var y = Math.random() * game.world.height;
  Phaser.Sprite.call(this, game, x, y, 'phaser');
}
FallingMartian.prototype = Object.create(Phaser.Sprite.prototype);
FallingMartian.constructor = FallingMartian;
```


Ahora podemos personalizar su comportamiento durante la fase de actualización
de Phaser. Por ejemplo:


```js
FallingMartian.prototype.update = function () {
  this.y += 2;
}
```


Usando el ejemplo anterior para añadir un _sprite_, podemos añadir el personaje
que cae:

```js
// En la pestaña create.
function create() {
  for (var i = 0; i < 10; i++) {
    var sprite = new FallingMartian(this.game, 0, 0, 'phaser');
    this.game.world.addChild(sprite);
  }
}
```
https://phaser.io/sandbox/xMDkDhBs



### Atributos relevantes de los sprites

<!-- Contar que tienen todos los de image además de algunos de ciclo de vida
que veremos en el tema 6.2, children, animations y body -->


### Métodos relevantes de los sprites

<!-- Contar overlap, addChild y removeChild -->



## Transformaciones


Las imágenes, como otras entidades en Phaser, pueden alterar su posición,
rotación y factor de escala.


Se llama transformación a la **alteración de los atributos que controlan la
posición, la rotación o el factor de escala de una entidad**.


### Posicionamiento


Para alterar la posición de una entidad, recurrimos a los atributos [`x`](
https://phaser.io/docs/2.6.2/Phaser.Sprite.html#x) e [`y`](
https://phaser.io/docs/2.6.2/Phaser.Sprite.html#y).


<!-- Un ejemplo moviendo al marciano. Conviene que sobreescriban update
y que NO sea la escena la que mueve el sprite. -->


### Rotación


<!-- Contar el atributo angle y ejemplo rotando al marciano. -->

### Escalado


<!-- Contar el atributo y ejemplo escalando al marciano. Contar escalado
negativo para hacer mirroring. -->



## La jerarquía del mundo


El mundo contiene entidades pero además, en Phaser, las entidades pueden
contener otras entidades formando así una jerarquía en forma de árbol.


La relación entre una entidad y sus entidades hijas es la de **pertenencia al
sistema de coordenadas**.


Es decir, si la entidad `Moon` se añade a la entidad `Earth`, significa que
`Moon` se encuentra en el sistema de coordenadas de `Earth`.


Lo que a su vez significa que al transformar `Earth` modificaremos `Moon`
indirectamente.


También significa que si transformaremos `Moon`, lo haremos respecto del sistema
de coordenadas de `Earth` y no del mundo.


<!-- Como ejemplo, un sistema Planeta-Satélite sería perfecto aquí. -->
