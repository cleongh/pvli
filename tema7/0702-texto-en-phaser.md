---
title: Texto en Phaser
author: Ismael Sagredo y Carlos León
vim: spelllang=es
...


# Texto en Phaser


## Crear texto usando fuentes del sistema

Para crear texto simplemente podemos usar la entidad `Text`{.js} con la factoría de Phaser `add.text`{.js}

---

Pero podemos modificar los atributos de `text`{.js} para cambiar su aspecto como:

* `align`{.js}: alineación del texto.
* `font`{.js}: tipo de letra.
* `fontSize`{.js}: tamaño.
* `fontWeight`{.js}: si queremos negrita o no.
* `stroke`{.js}: color del borde.
* `fill`{.js}: color de relleno.
* `strokeThickness`{.js}: grosor del borde.

---

```js
var text = game.add.text(game.world.centerX, game.world.centerY, '- phaser text stroke -');

// alineación del texto
text.anchor.set(0.5);
text.align = 'center';

// Font style
text.font = 'Arial Black';
text.fontSize = 50;
text.fontWeight = 'bold';

//Color del reborde de la letra y grosor.
text.stroke = '#000000';
text.strokeThickness = 6;
text.fill = '#43d637';
text.setShadow(5, 5, 'rgba(0,0,0,0.5)', 5);
```

## Problema de las fuentes del sistema


Una fuente de nuestra máquina puede no estar disponible en la máquina del
usuario

¿Solución? Usar fuentes estándar, crear nuestras propias fuentes de mapa de
bits (bitmaps) o usar fuentes Web (**webfonts**) como [Google
Fonts](https://fonts.google.com/)


## Texto con fuentes de mapa de bits

Para cargar un fuente de mapa de bits hay que usar `game.load.bitmapFont()`{.js} en el
`preload`{.js} donde hay que pasarle el PNG con las fuentes y el XML que las
describe

Para generar el XML y el mapa de bits podemos usar [Littera](http://kvazars.com/littera/)

O BMFont para Windows [Bmfont](http://www.angelcode.com/products/bmfont/)

```js
preload: funciton(){
    game.load.bitmapFont('bitmapFont', 'assets/fonts/bitmapFonts/bitmapFont.png', 
	'assets/fonts/bitmapFonts/bitmapFont.xml');
}
create: function(){
text = game.add.bitmapText(200, 100, 'bitmapFont','Bitmap Fonts!',64);
}
```


## Texto con fuentes Web

Podemos cargar fuentes desde la web, por ejemplo desde Google Fonts.

Hay que cargar la fuente previamente antes de usarla

---

Podemos cargar el JavaScript de Google Fonts previamente en la página:

```html
<script src="//ajax.googleapis.com/ajax/libs/webfont/1.5.18/webfont.js"></script>
```

O podemos cargarlo desde Phaser:

```js
game.load.script('webfont', '//ajax.googleapis.com/ajax/libs/webfont/1.4.7/webfont.js');
```

---


Hay que esperar a que la fuente sea cargada para poder usarla.

Para ello podemos definir el siguiente objeto que le dice al API de Google Fonts que fuente hay que cargar y a que método hay
que llamar cuando termine. 

---

WebFont es el objeto JavaScript de Google cargado:

```js
var wfconfig = {
// el método que invoca Google font al terminar de cargar la fuente.
    active: function() { 
        console.log("font loaded");
        init(); //llamada al método de creación de Phaser.
    },
 
    google: {
        families: ['Sniglet'] //la fuente o fuentes a cargar
    }
 
};

window.onload = function() {
	WebFont.load(wfconfig); //carga la fuente definida en el objeto anterior.
};
```

---


Y luego para usarlo simplemente se cambia el estilo de la fuente

```js
var textStart = this.game.add.text(0, 0, "Hola mundo!");
textStart.font = 'Sniglet';
```

## ¿Problemas de las Google Fonts u otras fuentes Web?

Que dependemos de ellas para que el juego funcione y no tenemos control sobre ellas
