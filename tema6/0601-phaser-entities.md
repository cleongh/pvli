# Entidades de Phaser


Los ejemplos de esta lección pueden probarse en la [sandbox de
Phaser](https://phaser.io/sandbox)


(Atención: hay un bug en la documentación de Phaser, y algunas propiedades
están ocultas. Podéis buscar en las versiones 2.5 y 2.4 también).


## El servidor local


Una vez hayas copiado la plantilla y ejecutado `npm install` en la raíz, lanza
el siguiente comando:

```bash
$ node ./node_modules/gulp/bin/gulp run
```


Con ello lanzarás un navegador que cargará la plantilla proporcionada.


Fíjate en la URL del navegador. Indica `localhost:3000` que es el nombre de la
IP local y el número de puerto.


El comando `run` realiza los pasos necesarios para que no sea necesario recargar
cada vez que modifiquemos un archivo fuente. Los fuentes los puedes encontrar en
`src/js/`.

![Estructura de directorios de la plantilla](imgs/estructura_directorios.png)


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


Phaser tiene objetos para representar puntos o vectores centrados en (0, 0).

```js
var myPoint = new Phaser.Point(); // (0, 0)
var myPointXY = new Phaser.Point(10, 10); // (10, 10)
```



Las imágenes rendean texturas, y les podemos decir desde dónde queremos rendear
la textura en relación al origen de la imagen, con `anchor`.


También se puede elegir el *blending* con `blendMode` (¡mirad el API!).


### Métodos relevantes de las imágenes



Una imagen puede ser "recortada" con `crop`, de forma que sólo se vea un trozo de la misma

```js
image = game.add.image(0, 0, 'phaser');
image.crop(new Phaser.Rectangle(0, 0, 10, 10));
```



Cuando la imagen se recorta, realmente no se pierde información. De hecho, el
recorte se puede cambiar dinámicamente:

```js
// en la pestaña update
function update() {
    v += 0.1;
    image.crop(new Phaser.Rectangle(0, 0, v, v));
}
```




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

```js
// en la pestaña create
game.world.setBounds(0, 0, 1920, 1200);
```



También se crea una cámara, a la que podemos acceder a través del atributo
[`camera`](https://phaser.io/docs/2.6.2/Phaser.Game.html#camera) del objeto de
juego o del mundo.

```js
// en la pestaña create
var card = game.add.sprite(200, 200, 'card');
game.camera.follow(card);
```


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


Todos los `Sprite` son también `Image`. Por tanto, tienen todos los atributos
de `Image`


Más adelante veremos más atributos de los `Sprite`, como `animations`, `body`
(para físicas) y `children` (para agrupar)



### Métodos relevantes de los sprites




`addChild` y `removeChild` añaden y eliminan, respectivamente, un hijo.


Un "hijo" es otra entidad cuyas propiedades van unidas y son relativas a las
del padre.


Por ejemplo, si el `Sprite` `A` tiene un hijo `B` y movemos `A`, `B` se moverá
junto a `A` automáticamente.


```js
function create() {
    var c = new Martian('phaser'); // Martian es un Sprite
    c.y = 80;
    var c2 = new Martian('phaser');
    c.addChild(c2); // hacemos que c2 sea hijo de c
    c2.y = 10; // relativo a c, en total corresponde a 90
    game.world.addChild(c);
}
```



`overlap` comprueba si un `Sprite` colisiona con otro:


```js
function update() {
    // si `c` y `c2` se solapan
    if(c.overlap(c2)) {
        // cambiamos la coordenada 'y' de `c2`
        c2.y = 100;
    }
}
```


## Transformaciones


Las imágenes, como otras entidades en Phaser, pueden alterar su posición,
rotación y factor de escala.


Se llama transformación a la **alteración de los atributos que controlan la
posición, la rotación o el factor de escala de una entidad**.


### Posicionamiento


Para alterar la posición de una entidad, recurrimos a los atributos [`x`](
https://phaser.io/docs/2.6.2/Phaser.Sprite.html#x) e [`y`](
https://phaser.io/docs/2.6.2/Phaser.Sprite.html#y).



En el caso de `Sprite`, es conveniente mover al elemento habiendo creado una
clase que herede de `Sprite` y modificar `x` e `y` dentro de su `update`:


```js
function Martian(name) {
    Phaser.Sprite.call(this, game, 0, 0, name);
}

Martian.prototype = Object.create(Phaser.Sprite.prototype);
Martian.constructor = Martian;

Martian.prototype.update = function() {
    this.x += 1;
    this.y += 1;
};

function create() {
    game.world.addChild(new Martian('phaser'));
}
```
https://phaser.io/sandbox/iuezaSHd


### Rotación


`angle` controla la rotación de un Sprite, en grados ([-180...180])


También existe `rotation`, para hacer la rotación de radianes y es ligeramente más
rápido.


Valores negativos del ángulo son rotación antihoraria, y valores positivos,
horaria.



Cualquier valor >360 equivale a restar 360 al ángulo (`angle = 450` es igual
que `angle = 90`).


```js
Martian.prototype.update = function() {
    // El marciano da vueltas sin parar
    this.angle++;
};
```


### Escalado


`width` y `height` controlan la anchura y altura, respectivamente. Con ellos se
pueden escalar objetos.


```js
Martian.prototype.resizeMe = function() {
    this.width = 3;
    this.height = 5;
};
```


Podemos hacer *mirroring*, con consiste en hacer una versión especular de la
imagen, escalando de forma negativa.


En el siguiente código, el `Sprite` se encoge tanto que se acaba dando la
vuelta.


```js
Martian.prototype.update = function() {
    this.width--;
};
```


## La jerarquía del mundo


El mundo contiene entidades pero además, en Phaser, las entidades pueden
contener otras entidades formando así una jerarquía en forma de árbol.


La relación entre una entidad y sus entidades hijas es la de **pertenencia al
sistema de coordenadas** (recordad `addChild`).


Es decir, si la entidad `Moon` se añade a la entidad `Earth`, significa que
`Moon` se encuentra en el sistema de coordenadas de `Earth`.


Lo que a su vez significa que al transformar `Earth` modificaremos `Moon`
indirectamente.


También significa que si transformaremos `Moon`, lo haremos respecto del sistema
de coordenadas de `Earth` y no del mundo.


Podéis ver un [ejemplo](https://phaser.io/sandbox/edit/lWlACykr) en el que las
entidades se agrupan según una jerarquía.


