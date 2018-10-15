# El modelo de ejecución de JavaScript



JavaScript se caracteriza por presentar un modelo de ejecución asíncrono donde
los resultados **no se encuentran disposibles inmediatamente** sino que lo
estarán en un futuro.



## Ámbito y _hoisting_


Como en muchos lenguajes, los nombres de las variables **pueden reutilizarse** y
guardar valores distintos siempre y cuando se encuentren en **ámbitos
distintos**.


El ámbito o _scope_ de una variable es la porción de código donde puede ser
utilizada. **Variables con el mismo nombre en ámbitos distintos son variables
distintas**.


El **ámbito en JavaScript es el cuerpo de la función**, delimitado entre el
par de llaves `{` y `}` que siguen a la lista de parámetros de la función.


```js
function introduction() {
  // Esta es la variable text.
  var text = 'I\'m Ziltoid, the Omniscient.';
  greetings();
  console.log(text);
}

function greetings(list) {
  // Y esta es OTRA variable text distinta.
  var text = 'Greetings humans!';
  console.log(text);
}

introduction();
```


En JavaScript, las funciones pueden definirse dentro de otras funciones y de
esta forma, anidar ámbitos.


El aniadmiento de funciones es útil cuando se quieren usar **pequeñas funciones
auxiliares**.


```js
function getEven(list) {
  function isEven(n) {
    return n % 2 === 0;
  }
  return list.filter(isEven);
}

getEven([1, 2, 3, 4, 5, 6]);
```


Como el ámbito es el de la función, el mismo nombre en una función anidada se
puede referir a dos cosas:


**Si se usa con `var`**, se estará declarando **otra variable distinta**:

```js
function introduction() {
  // Esta es una variable text.
  var text = 'I\'m Ziltoid, the Omniscient.';

  function greetings(list) {
    // Y esta es OTRA variable text distinta.
    var text = 'Greetings humans!';
    console.log(text);
  }

  greetings();
  console.log(text);
}

introduction();
```


En el caso anterior, decimos que la variable `text` de la función anidada
`greetings()` oculta a la variable `text` de la función `introduction()`.


Recuerda que para introducir una **nueva variable** necesitas declararla con
`var` antes de usarla (o al mismo tiempo que la asignas).


Si omites la palabra `var`, no estás creando una nueva variable sino
**reutilizando** la que ya existía.


```js
function introduction() {
  // Esta es una variable text.
  var text = 'I\'m Ziltoid, the Omniscient.';

  function greetings(list) {
    // Esta es la MISMA variable text que la de afuera.
    text = 'Greetings humans!';
    console.log(text);
  }

  greetings();
  console.log(text);
}

introduction();
```


### Hoisting


En JavaScript da igual a qué altura de la función declares una variable.
JavaScript asumirá cualquier declaración como si ocurriese al comienzo de
la función.


Es decir que esto:

```js
function f() {
  for (var i = 0; i < 10; i++) {
    for (var j = 0; j < 10; j++) {
      console.log('i: ', i, ' j: ', j);
    }
  }
}
```


Es equivalente a esto:

```js
function f() {
  var i;
  var j;
  for (i = 0; i < 10; i++) {
    for (j = 0; j < 10; j++) {
      console.log('i: ', i, ' j: ', j);
    }
  }
}
```


Fíjate que JavaScript **_alza_ la declaración de la variable, no la
inicialización**. Es por eso que este código no falla pero imprime `undefined`:

```js
function f() {
  console.log(i);
  var i = 5;
}
f();
```


En modo estricto, usar una variable que no ha sido declarada **es un error**.

```js
function f() {
  console.log(i); // comenta esto después de probar f.
  i = 5;
}
f();
```


Con las declaraciones de funciones esto no pasa, cuando una declaración de
función se alza, se alza entera, **definición incluída**.

```js
function getEven(list) {
  return list.filter(isEven);

  function isEven(n) {
    return n % 2 === 0;
  }
}

getEven([1, 2, 3, 4, 5, 6]);
```


Esto permite una bonita forma de ordenar el código en el que las funciones
auxiliares pueden situarse más abajo en las funciones que las utilicen.


Así, viendo sólo la línea:

```js
  return list.filter(isEven);
```

Ya podemos saber qué significa.


Y si aun tenemos dudas, podemos bajar e investigar qué es esa función.

```js
  function isEven(n) {
    return n % 2 === 0;
  }
```



## _Closures_


Las funciones son datos y se crean cada vez que se encuentra una instrucción
`function`. De esta forma podemos crear una función que devuelva funciones.


```js
function buildFunction() {
  return function () { return 42; };
}

var f = buildFunction();
var g = buildFunction();

typeof f === 'function';
typeof g === 'function';

f();
g(); // Las funciones hacen lo mismo...

f !== g; // ...pero NO son la misma función
```


Por sí sólo, este no es un mecanismo muy potente pero sabiendo que una
función anidada puede acceder a las variables de los ámbitos superiores,
podemos hacer algo así:


```js
function newDie(sides) {
  return function () {
    return Math.floor(Math.random() * sides) + 1;
  };
}
var d100 = newDie(100);
var d20 = newDie(20);

d100 !== d20; // distintas, creadas en dos llamadas distintas a newDie.

d100();
d20();
```


En JavaScript, **las funciones retienen el acceso a las variables en ámbitos
superiores**.


Una **función que se refiere a alguna de las variables en ámbitos superiores
se denomina _closure_**.


Esto **no afecta al valor de `this`** que seguirá siendo **el destinatario
del mensaje**.


### Métodos, closures y `this`


Considera el siguiente ejemplo:

```js
var diceUtils = {
  history: [], // lleva el histórico de tiradas.

  newDie: function (sides) {
    return function die() {
      var result = Math.floor(Math.random() * sides) + 1;
      this.history.push([new Date(), sides, result]);
      return result;
    }
  }
}
```


Nuestra intención es poder crear dados y llevar un registro de todas las tiradas
que se hagan con estos dados.


Pero esto no funciona:

```js
var d10 = diceUtils.newDie(10);
d10(); // ¡error!
```


Y es así porque **`this` siempre es el destinatario del mensaje** y `d10` se
está llamando como si fuera una función y no un método.


Recordad que podíamos hacer que cualquier función tomara un valor forzoso como
`this` con `.apply()` por lo que esto sí funciona pero es un engorro:

```js
d10.apply(diceUtils);
d10.apply(diceUtils);
diceUtils.history;
```


Lo que tenemos que hacer es que la función `die` dentro de `newDie` se refiera
al `this` del ámbito superior, no al suyo.


Podemos hacer esto de dos maneras. La primera es un mero juego de variables:


```js
var diceUtils = {
  history: [], // Lleva el histórico de dados.

  newDie: function (sides) {
    var self = this; // self es ahora el destinatario de newDie.
    return function die() {
      var result = Math.floor(Math.random() * sides) + 1;
      // Usando self nos referimos al destinatario de newDie.
      self.history.push([new Date(), sides, result]);
      return result;
    }
  }
}
```


Esto sí funciona y es mucho más conveniente:

```js
var d10 = diceUtils.newDie(10);
var d6 = diceUtils.newDie(6);
d10();
d6();
d10();
diceUtils.history;
```


La segunda forma es usando el método [`bind()`](
https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Global_objects/Function/bind)
de las funciones.


El método `bind()` de una función **devuelve otra función cuyo `this` será
el primer parámetro de `bind()`**. De este modo:


```js
var diceUtils = {
  history: [], // Lleva el histórico de dados.

  newDie: function (sides) {
    return die.bind(this); // una nueva función que llamará a die con su
                           // destinatario establecido al primer parámetro.

    function die() {
      var result = Math.floor(Math.random() * sides) + 1;
      this.history.push([new Date(), sides, result]);
      return result;
    }
  }
}
```


Las dos formas son **ampliamente utilizadas** pero la segunda se ve escrita
muchas veces de este modo:


```js
var diceUtils = {
  history: [], // Lleva el histórico de dados.

  newDie: function (sides) {
    return function die() {
      var result = Math.floor(Math.random() * sides) + 1;
      this.history.push([new Date(), sides, result]);
      return result;
    }.bind(this); // el bind sigue a la expresión de función.
  }
}
```



## Diferencias entre ámbitos en node y el navegador


Hemos dicho que el ámbito en JavaScript es equivalente a la función pero sabemos
que podemos abrir una consola o un fichero y empezar a declarar variables sin
necesidad de escribir una función.


Esto es así porque estamos usando el **ámbito global**. El ámbito global está
**disponible en el navegador y en node**.


```js
// Esta es una variable text en el ámbito GLOBAL.
var text = 'I\'m Ziltoid, the Omniscient.';

// Esta es una función en el ámbito GLOBAL.
function greetings(list) {
  // Esta es OTRA variable text en el ámbito de la función.
  var text = 'Greetings humans!';
  console.log(text);
}

greetings();
console.log(text);
```


Sin embargo, existe una peculiaridad en node. El ámbito global es realmente
**local al fichero**. Esto quiere decir que:

```js
// En a.js, text es visible únicamente dentro del FICHERO.
"use strict";
var text = 'I\'m Ziltoid, the Omniscient.';

// En b.js, text es visible únicamente dentro del FICHERO.
"use strict";
var text = 'Greetings humans!';

// En una consola iniciada en el mismo directorio que a y b
require('./a');
require('./b');
text;
```



## Módulos
Esta sección presenta la característica _módulos_ que es específica de node.


Una de las principales desventajas de JavaScript (aunque en las últimas versiones esto ya se puede hacer) es que no hay forma de organizar el código en módulos.


Los módulos sirven para aglomerar funcionalidad relacionada: tipos, funciones,
constantes, configuración...


**Node sí tiene módulos** y, afortunadamente, existen herramientas que simulan
módulos como los de node en el navegador.


En node, **los ficheros JavaScript acabados en `.js` son módulos**.


Node permite exponer o **exportar funcionalidad de un módulo**:

```js
// En diceUtils.js
"use strict"; // pone el módulo en modo estricto.

var history = [];

function newDie(sides) {
  return function die() {
    var result = Math.floor(Math.random() * sides) + 1;
    history.push([new Date(), sides, result]);
    return result;
  };
}

// ¡Lo que se exporta realmente es el objeto module.exports!
module.exports.newDie = newDie;
module.exports.history = history;
```

Poniéndola dentro del objeto `module.exports`


Realmente, lo que se exporta es **siempre `module.exports`**, que en principio
es un objeto vacío:

```js
typeof module.exports;
module.exports;
```

Lo que pongas dentro, queda también exportado.


Aahora puedes **importarlo desde otro módulo**:

```js
// En cthulhuRpg.js
"use strcit"
var diceUtils = require('./diceUtils');
var d100 = diceUtils.newDie(100);
var howard = {
  sanity: 45,
  sanityCheck: function () {
    if (d100() <= this.sanity) {
      console.log('Horrible, pero lo superaré. Estuvo cerca.');
    } else {
      console.log('¡Ph\'nglui mglw\'nafh Cthulhu R\'lyeh wgah\'nagl fhtagn!');
    }
  }
};
howard.sanityCheck();
```


Para importar un módulo desde otro hay que pasar a [`require`](
https://nodejs.org/api/modules.html#modules_module_require_id)
**la ruta relativa hasta el fichero del módulo** que queremos importar
**sin extensión**. La ruta **es relativa al fichero que quiere importar**.


Si en lugar de una ruta, pasamos un nombre, accederemos a la **funcionalidad
que viene por defecto con node** o la que instalemos de terceras partes.
Usaremos esta forma en un par de ocasiones más adelante.


