
## Programación asíncrona y eventos


Prueba el siguiente ejemplo (copia, pega y espera 5 segundos):

```js
var fiveSeconds = 5 * 1000; // en milisegundos.

// Esto ocurre ahora.
console.log('T: ', new Date());

setTimeout(function () {
  // Esto ocurre pasados 5 segundos.
  console.log('T + 5 segundos: ', new Date());
}, fiveSeconds);

// Esto ocurre inmediatamente después
console.log('T + delta: ', new Date());
```


Como puedes comprobar, el mensaje se completa pasados 5 segundos porque lo que
hace [`setTimeout`](
https://developer.mozilla.org/en-US/docs/Web/API/WindowTimers/setTimeout) es
llamar a la función tan pronto como pasen el número de milisegundos indicados.


Decimos que una función es una **_callback_** si se llama en algún momento
futuro, es decir, **asíncronamente**, para informar de algún resultado.


En el ejemplo de `setTimeout` el resultado es que ha pasado la cantidad de
tiempo especificada.


### Eventos
Esta sección presenta el módulo `readline` que es específico de node.


La programación asíncrona en JavaScript y otros lenguajes se usa para **modelar
eventos**, principalmente **esperas por entrada y salida**.


En otras palabras: hitos que ocurren pero que **no sabemos cuándo ocurren**.


La entrada y salida, a partir de ahora IO (del inglés _input / output_), no solo
supone lectura de ficheros o peticiones a la red, también incluye esperar por
una acción del usuario.


Vamos a implementar una consola de diálogo por líneas. Usaremos el módulo
[`readline`](https://nodejs.org/api/readline.html) que es parte de la
funcionalidad que vienen con node:

```js
// En conversational.js
"use strict";

var readline = require('readline');

var cmd = readline.createInterface({
  input: process.stdin,  // así referenciamos la consola como entrada.
  output: process.stdout, // y así, como salida.
  prompt: '(╯°□°）╯ ' // lo que aparece para esperar la entrada del usuario.
});
```


Lanza ese programa con node y verás que no hace nada **pero tampoco termina**.
Esto es típico de los programas asíncronos. El programa queda esperando a que
pase algo. Pulsa `ctrl+c` para terminar el programa.


Ahora prueba:

```js
// Añade al final de conversational.js
console.log('Escribe algo y pulsa enter');
cmd.prompt(); // pide que el usuario escriba algo.

cmd.on('line', function (input) {
  console.log('Has dicho "' + input  + '"');
  cmd.prompt(); // pide que el usuario escriba algo.
});
```


Lo que has conseguido es **escuchar por el evento `line`** que se produce
[cada vez que en la entrada se recibe un caracter de cambio de línea](
https://nodejs.org/api/readline.html#readline_event_line).


Hablando de eventos, la función que se ejecuta asíncronamente recibe el nombre de
**_listener_** pero tampoco es raro que se la llame **_callback_**.


Se habla de **registrar un listener para un evento** o **escuchar por ese
evento** a utilizar el mecanismo que permite asociar la ejecución de una función
con dicho evento.


Con todo, aun no puedes salir del programa. Necesitas algunos cambios más:

```js
// Añade a conversational.js
cmd.on('line', function (input) {
  if (input === 'salir') {
    cmd.close();
  }
});

cmd.on('close', function () {
  console.log('¡Nos vemos!');
  process.exit(0); // sale de node.
});
```


Has añadido un segundo lístener al evento `line` y **ambos se ejecutarán**.
El primero gestiona el funcionamiento por defecto (que es repetir lo que has
puesto) y el segundo trata específicamente el comando `salir`.


Si la línea es exactamente `salir`, cerraremos la interfaz de línea de
comandos. Esto produce un evento `close` y cuando lo recibamos, utilizaremos el
_listener_ de ese evento para terminar el programa.


El método `on()` es un segundo nombre para
[`addListener()`](
https://nodejs.org/api/events.html#events_emitter_addlistener_eventname_listener).


Igual que puedes añadir un lístener, también puedes eliminarlo con
[`removeListener()`](
https://nodejs.org/api/events.html#events_emitter_removelistener_eventname_listener)
y quitarlos todos con
[`removeAllListeners()`](
https://nodejs.org/api/events.html#events_emitter_removealllisteners_eventname).


Puedes escuchar por un evento **sólo una vez** con
[`once()`](
https://nodejs.org/api/events.html#events_emitter_once_eventname_listener).


### Emisores de eventos
Esta sección presenta la clase EventEmitter que es específica de node.


Los eventos **no son un mecanismo estándar** de JavaScript. Son una forma
conveniente de modelar determinados tipos de problema pero un objeto JavaScript,
por sí solo, **no tiene API para emitir eventos**.


**En node**, para que nuestros objetos emitan eventos, tenemos varias
alternativas:


  + Implementar nuestra propia API de eventos.
  + Hacer que nuestros objetos **usen** una instancia de `EventEmitter`.
  + Hacer que nuestros objetos **sean instancias** de `EventEmitter`.


La primera supone crear nuestro propio método `on()` y los mecanismos para
emitir eventos. El segundo y el tercero usan la clase [`EventEmitter`](
https://nodejs.org/api/events.html#events_class_eventemitter) que ya implementa
esta API.


Implementaremos la opción 3 para practicar la herencia:

```js
var events = require('events');
var EventEmitter = events.EventEmitter;

function Nave() {
  EventEmitter.apply(this);
  this._ammunition = 'laser charges';
}
Nave.prototype = Object.create(EventEmitter.prototype);
Nave.prototype.constructor = Nave;

var nave = new Nave();
nave.on; // ¡existe!
```


Ahora que nuestra nave puede emitir eventos, vamos a hacer que dispare y que
emita un evento.

```js
Nave.prototype.shoot = function () {
  console.log('PICHIUM!');
  this.emit('shoot', this._ammunition); // parte de la API de EventEmitter.
};

nave.on('shoot', function (ammunition) {
  console.log('CENTRO DE MANDO. La nave ha disparado:', ammunition);
});

nave.shoot();
```


Emitir un evento consiste en llamar al método
[`emit()`](
https://nodejs.org/api/events.html#events_emitter_emit_eventname_arg1_arg2)
que hará que se ejecuten los _listeners_ escuchando por tal evento.

Los eventos son increiblemente útiles para modelar interfaces de usuario de
forma genérica.


Para ello, los **modelos deben publicar qué les ocurre**: cómo cambian, qué
hacen... Todo **a base de eventos**. Las **interfaces de usuario se
suscribirán** a estos eventos y proporcionarán la información visual adecuada.


Este modelo permite además que varias interfaces de usuario funcionen al mismo
tiempo, todas escuchando por los mismos eventos aunque también permite partir
la interfaz en otras especializadas, cada una escuchando por un determinado
conjunto de eventos.
