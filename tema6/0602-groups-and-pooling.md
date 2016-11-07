# Pooling con grupos de entidades



Los ejemplos de esta lección se deben probar sobre un proyecto Phaser basado
en la [plantilla que os proporcionamos](../plantilla-juego). Realiza los cambios
que se indiquen en cada ejemplo.



Tienes todos los assets en la carpeta `imgs/assets` del tema pero siempre
puedes encontrar más, libres para uso no comercial, en [spriters-resource.com](
https://www.spriters-resource.com/)


## El efecto de los objetos sobre el rendimiento


En general, cuantas más entidades gestione un juego, más deterioro del
rendimiento.


No es difícil degradar el rendimiento de un juego simplemente arrojando
nuevas entidades a la escena. No es necesario ni modificarlas.

https://phaser.io/sandbox/dlqdIWMn


El único factor que afecta al rendimiento es el **tiempo de procesamiento entre
frames**. El problema es que el tiempo de procesamiento puede incrementarse
de un sinfín de formas.


La creación de entidades, su destrucción y el pintado de las mismas afecta al
rendimiento porque crear, destruir y recorrer la lista de entidades a pintar
**toma tiempo**.


Si el tiempo entre frame y frame excede los 16.6 ms, el [_frame rate_](
https://en.wikipedia.org/wiki/Frame_rate) disminuirá por debajo de 60 fps.


En la pestaña "Rendering", podemos activar la opción "FPS Meter" en Chrome.


Además, en la pestaña "Profiles", podemos guardar una ejecución del programa y
veremos qué funciones se ejecutan y cuánto tiempo tardan en hacerlo. 


Hacer *profiling* es fundamental para ver cuál es el impacto **real** (y no
sólo en teoría) de las partes de nuestro código. 


### El recolector de basura


En JavaScript apenas nos preocupamos por la vida de un objeto. Creamos el
objeto con `new` y cuando no lo necesitamos más, sencillamente dejamos de
usarlo.


¿Qué pasa con los objetos que ya no se usan? La respuesta es que son recogidos
por el [recolector de basura](
https://en.wikipedia.org/wiki/Garbage_collection_(computer_science)) y
destruidos de forma que la memoria que ocupan queda disponible de nuevo.



Para ver cómo funciona, activamos las opciones de desarrollo (en este caso, en
Chrome), y en la pestaña "Timeline" grabamos mientras ejecutamos un juego.



El recolector de basura es conveniente porque nos evita tener que liberar
la memoria manualmente, previniendo que un objeto sea destruido accidentalmente
cuando aún tenemos que usarlo.


Sin embargo, introduce un problema de impredecibilidad, dado que no sabemos
**ni cuándo sucederá ni cuánto tardará**.


Una recolección de basura especialmente larga puede tirar el rendimiento y nada
garantiza que la siguiente recolección no haga lo mismo y suceda en menor
tiempo del deseado.



## Pooling


Una forma de controlar el efecto de la creación de objetos y evitar la
recolección de basura es mediante el uso del **[patrón _Object Pool_](
https://en.wikipedia.org/wiki/Object_pool_pattern)** o depósito de objetos.


La idea es sencilla: primero crearemos un _pool_ (depósito) de objetos estimando
los que vayamos a utilizar durante el programa.

![Pool de objetos](imgs/pool.svg)


Cuando necesitemos un objeto, **en lugar de crearlo, se lo pediremos al
_pool_** y luego lo usaremos normalmente.

![Coger un objeto del pool](imgs/takepool.svg)



Una vez terminemos de usar el objeto, **cuando ya no lo necesitemos, lo
devolveremos al _pool_**.

![Devolver el objeto al pool](imgs/storepool.svg)


Cuando necesitemos otro, volveremos a pedirlo al _pool_ de objetos. A lo largo
de la ejecución del programa, los depósitos de objetos pueden permanecer fijos o
redimensionarse de acuerdo a las necesidades del mismo.



## El ciclo de vida de las entidades


Si creamos una entidad con `new`, como hacíamos con los _sprites_, el objeto
morirá cuando lo hacen todas los objetos de JavaScript, es decir, cuando nada
hace referencia a él. En general, al salir del _scope_.


Pero si añadimos la entidad al juego, bien explícitamente o a través de los
métodos factoría de `add`, esta se mantendrá viva mientras dure el juego.


La manera en que podemos destruir una entidad, es decir, eliminar todas sus
referencias de forma que el recolector de basura pueda llevársela es mediante
el método [`destroy()`](http://phaser.io/docs/2.6.2/Phaser.Sprite.html#destroy)
de la entidad.


Por ejemplo, el siguiente ejemplo muestra un máximo de 10 sprites en pantalla
destruyendo la entidad más vieja cuando excedemos el máximo.


```js
// En la sandbox de Phaser
function update() {
    var x = Math.random() * this.game.world.width;
    var y = Math.random() * this.game.world.height;
    this.game.add.sprite(x, y, 'phaser');

    if (this.game.world.children.length > 10) {
        this.game.world.children[0].destroy();
        console.log('World children count:', this.game.world.children.length);
    }
}
```
https://phaser.io/sandbox/ODAglzNQ


Como veremos en breve, a veces nos interesará no destruir la entidad pero sí
**dejarla inerte** de forma que no se actualice, ni se pinte, ni interactúe con
nada hasta que vuelva a interesarnos.


Para ello podemos _matar_ la entidad usando el método [`kill()`](
http://phaser.io/docs/2.6.2/Phaser.Sprite.html#kill).


Phaser considera que una entidad "asesinada" ha dejado de existir y pone su
atributo `exists` a `false`.


Aunque la nomenclatura resulte confusa, que una entidad "no exista" no significa
que haya sido destruida. Significa que para Phaser, esta entidad no participará
en las fases de actualización y pintado.


Este ejemplo mata los sprites más viejos pero no los destruye. El efecto es
parecido pero no igual puesto que los objetos siguen existiendo y la cantidad
de memoria consumida se mantiene en aumento.


```js
// En la sandbox de Phaser
function update() {
    var x = Math.random() * this.game.world.width;
    var y = Math.random() * this.game.world.height;
    this.game.add.sprite(x, y, 'phaser');

    if (this.game.world.children.length > 10) {
        // Fíjate en como encontramos el sprite más viejo en relación a cómo
        // lo hacíamos antes.
        this.game.world.getFirstExists().kill();
        console.log('World children count:', this.game.world.children.length);
    }
}
```
https://phaser.io/sandbox/mVatKOPT


Observa la salida por consola de ambos ejemplos para comprobar como al destruir
un objeto este desaparecía del mundo por lo que el conteo de entidades en la
escena **se mantiene constante**. Esto no ocurre en el segundo ejemplo donde el
número de entidades **no para de crecer**.


Para devolver una entidad a la existencia, según Phaser, usamos [`reset()`](
http://phaser.io/docs/2.6.2/Phaser.Sprite.html#reset).



## Grupos en Phaser


Como ocurre con todas las entidades de Phaser, un [grupo](
http://phaser.io/docs/2.4.4/Phaser.Group.html) **puede albergar otras
entidades** pero además, los grupos exponen una API especialmente diseñada
para la **búsqueda, ordenamiento y manipulación en grupo** de
las entidades que contiene.


El mundo del juego es un grupo, por ejemplo. Por eso pudimos utilizar el
método [`getFirstExists`](
http://phaser.io/docs/2.4.4/Phaser.Group.html#getFirstExists) que es propio
de los [grupos](http://phaser.io/docs/2.4.4/Phaser.Group.html#methods) y
devuelve la primera entidad cuya propiedad `exists` sea `true`.


### API de búsqueda


Un grupo es un contenedor. Creamos entidades y las añadimos al grupo.


```js
var martian = Martian(); // 'Martian' es un 'Sprite'
var enemies = game.add.group();
enemies.add(martian);
```



> Aquí comentamos algunas funciones ilustrativas. Podéis usar, del API, las que
> más sentido tengan, sean estas o no.


Phaser nos da acceso a todas las entidades de un grupo.


```js
function update() {
    // Recorremos un grupo (en este caso, World)
    game.world.forEach(function(item) {
        item.x ++;
    });
}
```



Además, nos permite preguntar al grupo ciertas cosas:

```js
var e = new Martian("m");
var g = game.add.group();
g.add(e);

var yesNo = g.contains(e); // si el grupo contiene una entidad
var d = g.countDead(); // el número de "muertos"
var e2 = g.getByName("m"); // dado un nombre, nos da una entidad
var masCercano = g.getClosestTo(e2); // nos devuelve el más cercano
var aleatorio = g.getRandom(); // un elemento aleatorio del grupo
g.removeChild(e2); // quitamos un elemento del grupo
```


### API de ordenamiento


Generalmente, los grupos tienen un propósito y hay una buena razón para agrupar
las entidades.


Por ejemplo, si queremos crear un subconjunto de entidades que hacen o reciben
algo concreto.


Muchas veces, las entidades dentro del grupo tienen que estar ordenadas (o
viene bien, por eficiencia, que lo estén).

```js
// ordenamos los elementos por su atributo "y"
// es muy parecida al 'sort' normal de listas en JavaScript
g.customSort(function(a, b) {
    return a.y - b.y;
});

// Como es muy normal ordenar por parámetro, tenemos en el API también esta
// función
// Ordenamos según el parámetro 'x' de cada entidad
g.sort('x', Phaser.Group.SORT_ASCENDING);
```



### API de manipulación en grupo


Otra de las cosas que podemos hacer con los grupos es tratarlos como una sola
entidad.


Por ejemplo, podríamos querer eliminar todos los bloques de hielo en un nivel,
o hacer que todos los enemigos avancen más rápido.

```js

var g = game.add.group();

// También existe 'forAllAlive', que sólo itera sobre los que están vivos
g.forEach(function(item) {
    item.speed += 2;
});

g.callAll('kill'); // llama a 'kill' en todas las entidades del grupo
g.callAllExists('kill'); // lo mismo, pero sólo las que existen (exists -> es actualizado)
```


## Implementación de pooling con grupos de Phaser


Phaser no incluye pools directamente pero podemos utilizar nuestra propia clase
`Pool` que utilice grupos internamente para ello.


### Creación del pool


El constructor de _Pool_ recibe el juego en `game`, **añade un grupo al juego**
con [`add.group()`](
http://phaser.io/docs/2.6.2/Phaser.GameObjectFactory.html#group) y guarda
ese grupo internamente. También recibe la lista de entidades que se van a
reciclar.


```js
// En la pestaña create, antes de la función create().
function Pool(game, entities) {
   this._group = game.add.group();
   this._group.addMultile(entities);
   this._group.callAll('kill');
}
```


### Recuperación de una entidad


Recuperamos una entidad del _pool_ utilizando el método `spawn()` que recibe las
nuevas coordenadas del sprite `x` e `y`,


```js
// A continuación de la función Pool.
Pool.prototype.spawn = function (x, y) {
    var entity = this._group.getFirstExists(false);
    if (entity) {
      entity.reset(x, y);
    }
    return entity;
}
```


### Devolución de una entidad

Devolver una entidad requiere llamar al método `kill()` sobre esa entidad.


```js
// Supón que no necesitamos más entity.
entity.kill();
```


Podéis encontrar un ejemplo completo que usa _pooling_ en el siguiente enlace:

https://phaser.io/sandbox/BsmLVkSB

Observa las pestañas `create` y `update`.


<!-- Sería interesante añadir redimensión automática como lo hace Belén en
https://github.com/belen-albeza/ldjam-32/blob/master/app/js/utils.js#L23 -->
