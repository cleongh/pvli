# JavaScript en el navegador



## ¿Por qué?


Si queréis publicar juegos en la web, _necesitáis_ saber cómo funciona un navegador, y cómo funciona la web


### ¿Por qué conocer los navegadores?

- Hay consideraciones técnicas a tener en cuenta, tanto a nivel de interfaz como de seguridad
- ¡Herramientas de desarrollo! Debugger, profiler, network requests, etc.


### ¿Por qué conocer tecnologías web?

- Como poco, vuestro juego deberá estar contenido en una página web (HTML), que tendrá cierta apariencia (CSS).
- Es útil para implementar cosas como un botón de fullscreen, o una splash screen, o usar fuentes custom en vuestros juegos
- Si tenéis un bug, necesitáis conocimientos de APIs Web para poder debuggar con éxito (p.ej la API de Gamepad, o WebGL)
- Si queréis modificar el engine o framework para añadir features o arreglar un bug…



## Navegadores


- Son programas que permiten acceder a la Web
- ¡No todos los navegadores son iguales!
    - No todos incluyen el mismo motor de renderizado. P.ej: Gecko (Firefox), Blink (Chrome, Opera)
    - No todos incluyen la misma VM de JavaScript. P.ej: SpiderMonkey (Firefox), V8 (Chrome)


### ¿Cómo detectar qué soporta cada navegador?

- [caniuse.com](http://caniuse.com), rápida e intuitiva
- [MDN](http://developer.mozilla.org), tiene detalles concretos sobre la implementación y diferencias entre navegadores



## Lenguajes en la web


### HTML

- Representa el **contenido** de una página: párrafos, títulos, imágenes, vídeos, elementos de canvas, etc.

- Es un lenguaje de **marcado** basado en etiquetas. P.ej:

```html
<h1>Esto es un título</h1>
```


### CSS

- Nos permite personalizar la **apariencia** de los elementos HTML: colores, fondos, bordes, posición, columnas, tamaños…

- Es un lenguage **declarativo** basado en reglas. P.ej:

```css
h1 {
  color: red;
}
```


### JavaScript

- Nos permite implementar **comportamiento** y **lógica**.

- Es un **lenguaje dinámico** orientado a prototipos, con características funcionales.

```javascript
console.log("Hello, world!");
```



## ¿Qué pasa cuando accedéis a una web en un navegador?


### 1. Petición HTTP GET a un servidor

![Paso 1](imgs/request_dance_step1.png)

Se hace un HTTP GET a una URL, y si el recurso existe (y no está cacheado), el servidor lo retorna.


### 2. Descarga de archivos

![Paso 2](imgs/request_dance_step2.png)

Los archivos HTML pueden hacer referencia a otros recursos… que el navegador deberá pedir al servidor.

Mientras tanto, se va renderizando el HTML descargado.


### ¡Un JS salvaje apareció!

Cuando un archivo JS se acaba de descargar, su código se parsea y se **ejecuta**.

Mientras se ejecuta, el navegador queda _bloqueado_.


### 3. Carga finalizada

Cuando todas las imágenes, scripts, CSS, etc. se han cargado, se dispara el **evento `load`** de `window`.

Es muy común incluir el código que inicializa la ejecución del programa en el _handler_ de ese evento.

```javascript
window.onload = function () {
  // hello world
};
```



## Cómo incluir JavaScript en una web


### Estructura básica de un documento HTML

```html
<!doctype html>
<html>
  <!-- el head es metadata -->
  <head>
    <title>Cancamusa</title>
    <meta charset="utf-8">
  </head>
  <!-- el body es contenido -->
  <body>
    <h1>Monkey Island</h1>
    <p>Mira detrás de ti, ¡un mono de tres cabezas!</p>
  </body>
</html>
```


### ¿Dónde va el código JavaScript?

- Podemos incluir JavaScript tanto en el `<head>` como en el `<body>`…
- …pero tened en cuenta el flujo de carga de una web!
    - En el `<head>` se iniciará la carga antes que el resto de recursos… pero bloqueará el renderizado mientras se ejecuta.
    - Al final de `<body>` permitirá que se renderice la web… pero tardará más en ejecutarse.

<small>Esto es una simplificación, info más completa en [este artículo de Jake Archibald](https://www.html5rocks.com/en/tutorials/speed/script-loading/)</small>


### Scripts inline

Podemos incluir código JavaScript inline en el HTML con la etiqueta `<script>`.

```html
<script>
    console.log("Hello, world!");
</script>
```


### Scripts externos

Podemos incluir archivos JavaScript con la etiqueta `<script>` también:

```html
<script src="js/game.js"></script>
```



## Cómo se ejecuta JavaScript


### Modelo asíncrono

- Mientras JavaScript se está ejecutando, **bloquea todo lo demás** (incluida la UI).
- La manera de programar JavaScript en la Web es **subscribiéndonos a eventos** (o usando **callbacks**) y ejecutando código sólo cuando esos eventos se disparan.
- Si los eventos no se disparan, o los callbacks no se llaman, no se ejecuta código.


### Un solo hilo

- Los callbacks de los eventos se ejecutan **de uno en uno**.
- Los callbacks se ejecutan inmediatamente cuando el evento se dispara (el resto del código espera su finalización).


### Ejemplo

```javascript
button.onclick = function (evt) {
    console.log("Click");
}

// ...

button.trigger('click');
// el botón no se desactiva hasta que el handler de "click"
// haya acabado de ejecutarse
button.disabled = true;
```

<small>[Snippet de código](https://jsfiddle.net/1wqevdob/)</small>



## El DOM


### Document Object Model

- Los documentos HTML presentan una estructura de árbol.
- Los navegadores nos dan una **interfaz para interactuar** con esta estructura: el <strong>DOM</strong>
- El punto de entrada para acceder al DOM es el objeto **global `document`**.


### Ejemplo de una sección del DOM

![Sección del DOM](imgs/dom_section.png)


```html
<article>
  <header>
    <h1>Un título molón</h1>
  </header>
  <p>Bla bla bla.</p>
  <p>
    Más bla, bla, bla y
    <a href="http://wikipedia.org">aquí un enlace</a>.
  </p>
</article>
```


### ¿Qué podemos hacer con el DOM?

- Leer/Escribir las propiedades de los elementos, y usar sus métodos.
- Eliminar elementos del DOM.
- Insertar nuevos elementos en el DOM.



## Acceder a elementos del DOM


### Acceder a elementos por ID

Sólo selecciona un elemento (las ID's deben ser únicas).

```html
<button id="show-fullscreen">Fullscreen</button>
```

```javascript
var button = document.getElementById('show-fullscreen');
```


### Acceder a elementos por selector

Esto usa la sintaxis de los selectores CSS para localizar uno (o varios) elementos.

```javascript
// selecciona el primer párrafo que encuentra
var paragraph = document.querySelector('p');
// selecciona el primer elemento con clase .warning
var label = document.querySelector('.warning');
// selecciona TODOS los párrafos
var allPars = document.querySelectorAll('p');
```

<small>Más info sobre selectores para usar con `querySelector` en [la MDN](https://developer.mozilla.org/en-US/docs/Web/Guide/CSS/Getting_Started/Selectors)</small>


### Iterar sobre una lista de elementos

- `querySelectorAll` _no_ devuelve un array, sino una [NodeList](https://developer.mozilla.org/en/docs/Web/API/NodeList).
- No podemos utilizar métodos de `Array` sobre ella. Pero tiene la propiedad `length` y el operador `[]`, así que podemos acceder en un bucle:

```javascript
var buttons = document.querySelectorAll('button');
for (var i = 0; i < buttons.length; i++) {
    buttons[i].style = "display: none"; // hide buttons
}
```

<small>Aunque también podemos iterar con `Array.forEach` si lo utilizamos con `apply`…</small>


### Navegar en el DOM

- Se accede al **padre** de un elemento con la propiedad `parentNode`.
- Se accede a la lista de **hijos** de un elemento con `childNodes`.
- Se accede al **hermano** anterior o siguiente con `previousSibling` y `nextSibling`.

Con esto podemos recorrer todo el DOM en cualquier dirección.



## Propiedades interesantes de elementos del DOM


### innerHTML

- El _interior_ (o contenido) del elemento.
- Podemos escribir HTML dentro, creando al vuelo nuevos elementos del DOM.

```javascript
button.innerHTML = 'Aceptar';
p.innerHTML = 'Párrafo con <b>negrita</b>';
```


### style

- Nos permite aplicar **estilos CSS inline** (tienen la máxima prioridad).
- Muy útiles para ocultar/mostrar elementos.
- También podemos _leer_ la propiedad CSS.

```javascript
var previousDisplay = button.style.display;
button.style="display:none"; // oculta cualquier elemento
button.style="display:inline-block;" // muestra el botón
```

<small>Nota: `display:none` es universal, pero para mostrar un elemento debéis elegir entre varios valores, los más comunes son `inline`, `inline-block` y `block`, pero hay muchos otros.</small>


### classList

- Nos permite acceder a las **clases CSS** de un elemento.
- Útil para cambiar el aspecto de la UI en función de las interacciones.

```javascript
button.classList.add('loading');
button.classList.remove('loading');
button.classList.contains('loading'); // query
button.classList.toggle('loading'); // doesn't work on IE
```

<small>[Snippet de código](https://developer.mozilla.org/en/docs/Web/API/Element/classList) online</small>



## Manipular el DOM


### Insertar elementos

- Podemos insertar elementos nuevos con `innerHTML`…
- …pero también se pueden crear desde cero.

```javascript
var button = document.createElement('button');
button.innerHTML = 'Start';
button.setAttribute('type', 'button');

// <button type="button">Start</button>
```


- Cuando creamos un elemento con `createElement` está **huérfano** y no lo veremos renderizado en la página.
- Hay que añadirlo como "familiar" de algún otro elemento con `appendChild`, `insertBefore`, etc.

```javascript
document.body.appendChild(button);
```

<small>[Snippet de código](https://jsfiddle.net/mpsjmz11/1/) online</small>


### Eliminar elementos

- Podemos reemplazar un elemento por otro con `replaceChild`.
- Podemos **eliminar** un elemento con `removeChild`.

```javascript
var button = document.getElementById('start');
button.parentNode.removeChild(button);
```



## Eventos


### Eventos en el DOM

- Los elementos del DOM disparan eventos a los que podemos subscribirnos (click en un botón, cambio del texto de un `<input>`, cuando seleccionamos una checkbox, etc.)

- `window` también dispara eventos! P.ej: `load`, `resize`, etc.


### Escuchar eventos

- Hay dos maneras de escuchar eventos disparados por un elemento:
    - Usando el método `Event.addEventListener`
    - Usando los _on-event handlers_ (p.ej `onclick`, `onfocus`, etc.)


### On-event handlers

- **Sólo hay un handler** por evento!
- Registramos y desregistramos el handler con una **asignación**.

```javascript
// subscripción
button.onclick = function (evt) { /* ... */ };
// cancelar la subscripción
button.onclick = null;
```

<small>Documentación [en la MDN](https://developer.mozilla.org/en-US/docs/Web/Guide/Events/Event_handlers)</small>


### Event listeners

- Podemos subscribirnos **múltiples veces** al mismo evento.
- Es la manera recomendada y más segura

```javascript
var sayHi = function () { /* */ };
// subscripción
button.addEventListener('click', sayHi);
// cancelar la subscripción
button.removeEventListener('click', sayHi);
```

<small>Documentación [en la MDN](https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/addEventListener)</small>


### Bubbling

- El **bubbling** es la metáfora con la que explicamos cómo se comportan los eventos del DOM.
- Cuando un elemento dispara un evento, **se propaga** hacia arriba en el árbol del DOM.

```html
<section>
    <button>Click me</button>
</section>
```

```javascript
var section = document.querySelector('section')
section.addEventListener('click', function () {
    console.log('Clicked…');
});
```

<small>[Snippet de código](https://jsfiddle.net/mcx0hkou/1/) online</small>


### Interrumpir el bubbling

- Los callbacks de los eventos pueden recibir **un argumento** con información sobre el evento.
- El argumento es un objeto de tipo `Event` y tiene métodos para interrumpir el bubbling

```javascript
button.addEventListener('click', function (evt) {
    console.log(evt);
});
```


Podemos evitar el bubbling con **`Event.stopPropagation`**.

```javascript
button.addEventListener('click', function (e) {
    e.stopPropagation();
});
```


### Cancelar el evento

- Esto **_no_ es interrumpir el bubbling**!
- Es cancelar el evento y evitar acciones por defecto asociadas a él. Es útil para interceptar formularios, p.ej.
- Usamos **`Event.preventDefault`**


```html
<a href="file.zip" download>Download zip</a>
```

```javascript
var link = document.querySelector('a');
link.addEventListener('click', function (evt) {
    // the browser won't detect the link has been clicked
    evt.preventDefault();
});
```



## Toda la documentación de esto está en la MDN

[http://developer.mozilla.org](http://developer.mozilla.org)

Truco: añadir `mdn` a cualquier búsqueda

![Buscador](imgs/search.png)
