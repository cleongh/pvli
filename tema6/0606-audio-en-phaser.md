---
title: Audio en Phaser
vim: spelllang=es
...

# Motores de audio

---

El sonido, a bajo nivel, es un aspecto complejo y requiere de conocimiento
amplio de física y procesamiento de señal

---

En general, cuando estamos haciendo videojuegos, queremos una *capa de
abstracción* sobre la gestión de sonido

---

Es muy normal asumir que el sonido en un videojuego consiste en un conjunto de
archivos (sonidos y música) que queremos reproducir (al lanzarse eventos, o de
fondo)

---

Aunque, desde luego, esto no sea necesariamente así en todos los juegos, es
como vamos a tratarlo en este curso

# Formatos

---

Los sonidos se almacenan en digital de dos formas:

- Guardando la onda (análogo a un mapa de bits)
- Guardando las notas musicales, su duración, etc. (análogo a una imagen
  vectorial): [MIDI](https://es.wikipedia.org/wiki/MIDI)

---

Nosotros trabajaremos sólo con audio de onda (no MIDI)



# Audio en Phaser

---

Phaser provee, entre otros módulo, uno de gestión de audio de *muy alto nivel*

---

Esto quiere decir que, para gestionar audio, sólo tenemos que preocuparnos de:

#. tener los archivos
#. cargarlos
#. (asegurarnos de que están bien cargados)
#. reproducirlos
    - de fondo
    - con eventos
    - en loop
#. enterarnos de cuándo han acabado de reproducirse (si queremos)

# Carga de sonidos

---

Cargar el sonido `explosion.mp3` y asignarle un nombre:

```javascript
game.load.audio('explosion', 'assets/audio/SoundEffects/explosion.mp3');
```

---

También podemos hacer una "lista de prioridad" de carga. El navegador intentará
cargar estos archivos (por orden), sólo se quedará con uno


En `preload`{.js}:

```javascript
game.load.audio('boden',
               ['assets/audio/bodenstaendig_2000_in_rock_4bit.mp3',
               'assets/audio/bodenstaendig_2000_in_rock_4bit.ogg']);
```

(Por ejemplo, Firefox elegirá el OGG)

---

Añadimos el audio al juego:

```javascript
explosion = game.add.audio('explosion');
```

---

Y, finalmente, reproducimos el sonido:

```javascript
explosion.play();
```

---

Si queremos reiniciar la reproducción:

```javascript
music.restart();
```

---

Si queremos borrarlo en algún momento, destruimos la entidad (con
`destroy()`{.js}) y el recurso (con `removeSound`{.js})

```javascript
explosion.destroy();
game.cache.removeSound('explosion');
```

# Eventos de sonido en Phaser

---

No solemos saber (o no es cómodo saber) cuánto dura un sonido

Así que lo que hacemos es *decirle a Phaser que haga algo cuando el sonido
termine de reproducirse*

## Evento cuando el sonido termina de reproducirse

```javascript
function create() {
    explosion.onStop.add(soundStopped, this);
}


// Esta función es llamada cuando `explosion` 
// termina de reproducirse
function soundStopped(sound) {
    // ...
}
```


## Callback de descodificación

Otro tipo de *callback* es el que se necesita cuando se descomprime un archivo
de audio comprimido

---

Dado que lleva tiempo descomprimir un MP3 para ser reproducido, hacer

```javascript
function create() {

    explosion = game.add.audio('explosion');
    sword  = game.add.audio('sword');
    // se llama a `start` cuando todos los sonidos de la lista están cargados
    game.sound.setDecodedCallback([ explosion, sword ], start, this);
}

function start() {
    explosion.onStop.add(soundStopped, this);
}
```

## Repetir

```javascript
// hace que `explosion` se vuelva a reproducir cuando acabe
// (muy útil para música)
explosion.loop = true;
```

# Recursos de audio

---

- Podéis usar los recursos de audio de Phaser (los **assets**)
- [Free sound](https://www.freesound.org/)
- [Free SFX](http://www.freesfx.co.uk/)
- Generadores
    - [Bfxr](http://www.bfxr.net/)
    - [Chiptone](http://sfbgames.com/chiptone/)
    - [as3sfxr](http://www.superflashbros.net/as3sfxr/)
    - [sfxr](http://www.drpetter.se/project_sfxr.html)

# Más cosas

---

Phaser puede hacer mucho más con el sonido

Recordad:

- Mirar la documentación
- Mirar en Internet
- Probar
- Preguntar
