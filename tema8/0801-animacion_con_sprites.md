---
title: Animación con sprites
# vim: spelllang=es
...

# El pasado

---

El [alma](https://es.wikipedia.org/wiki/Alma), se creía/cree, es eso que
tenemos y que nos hace movernos

---

Alma en latín se dice `anima`

---

*Animar* es dar *alma*, dar *movimiento*

# El siglo XIX

---

[Eadweard Muybridge](https://en.wikipedia.org/wiki/Eadweard_Muybridge)
diseñó un sistema de fotografía en el que, haciendo muchas fotos seguidas con
una cámara fija, conseguía que el ojo human no pudiera distinguir los
fotogramas como imágenes separadas

Sino como *movimiento*

---

![The Horse in Motion (Wikipedia)](https://upload.wikimedia.org/wikipedia/commons/7/73/The_Horse_in_Motion.jpg)

---

![The Horse in Motion animado (Wikipedia)](https://upload.wikimedia.org/wikipedia/commons/0/07/The_Horse_in_Motion-anim.gif)

---

Con la misma idea, los [Hermanos
Lumière](https://es.wikipedia.org/wiki/Hermanos_Lumi%C3%A8re) inventaron el
cinematógrafo

# Hoy

---

La idea prácticamente no ha variado

Para crear la **sensación** de movimiento (animación), reproducimos imágenes en
orden, suficientemente rápido

# Sprites

---

Un [*sprite*](https://en.wikipedia.org/wiki/Sprite_(computer_graphics)) es una imagen sencilla, única, en 2D

---

Su origen es parte de las historia del videojuego

Algunas de las primeras máquinas dedicadas a correr juegos tenían hardware
*dedicado* para sprites

---

Por tanto, esta tecnología de sprite no realizaba cambios en RAM que se
volcaban al dispositivo gráfico

---

Esta es una de las razones por las que los sprites tenían restricciones
físicas

---


Hoy en día, generalmente, hacemos la creación de la escena gráfica (**frame**)
en la RAM y volcamos (`blit`{.js}) al contexto gráfico

Esto nos da una flexibilidad enorme, pero es *más lento*

---

Obviamente, esto en irrelevante en términos de eficiencia con el hardware moderno



## Sprites hoy

---

Hoy en día, los sprites son generalmente mapas de bits de cualquier tamaño

---

En general, usamos formas rectangulares con formatos (razonablemente) estándar

Dado cómo usamos los sprites, el tamaño o el número de colores ya no es,
generalmente, un problema

---

Solemos usar formatos con transparencia explícita

Para ello hace falta un formato que lo acepte (como PNG)

![Sprite](imgs/tux.png)

---

También (esto depende del formato de la imagen) podemos usar un color concreto
de fondo

---

Esta idea es muy similar a como funciona un [croma](https://es.wikipedia.org/wiki/Croma)

![Sprite](imgs/tux_fondo.png)

---

Ya hemos cargado y usado sprites, ahora vamos a ver cómo podemos hacer que esos
sprites estén animados

# Muchos sprites

---

Producimos la *sensación* de animación al reproducir imágenes consecutivas con
pequeños cambios secuenciales, *suficientemente rápido*

---

Para conseguir esto en videojuegos, simplemente disponemos de varios sprites
que representan secuencias de movimientos seguidos, diferenciales

![Spritesheet
(https://www.flickr.com/photos/goosemouse/4998615136)](https://c1.staticflickr.com/5/4147/4998615136_dc0b7b1e39_b.jpg){width=35%}

---

Una vez que tenemos la información, simplemente tenemos que usarla para
dibujar, en un contexto gráfico, los sprites por orden

De la misma manera que el cine

---

Para hacer esto de forma que el movimiento, la animación, sea convincente,
tenemos que asegurarnos de que el reemplazo de una imagen por la siguiente en
la secuencia no tenga "fallos"


---

Estos requisitos los cumplimos manteniendo propiedades básicas entre las imágenes:

- Mismo tiempo por fotograma
- Mismo tamaño de fotogramas
- Mismo fondo
- Misma paleta de colores
- Misma información de transparencia
- Misma localización relativa del sprite en el recuadro
- Misma escala

---

Si mantenemos esos requisitos (lo cual no es *técnicamente* necesario), el
programa que procese la información para representarla por pantalla podrá ser
sencillo

---

```javascript
// asumimos tiempo fijo entre frames
// el tamaño y la posición del personaje: fijos
var width = 10, height = 10;
var x = 10, y = 10;
var tiempo_entre_frames = 0.01;
var frames = [frame1, frame2, frame3, ..., framen];
var frames_por_ciclo = frames.length;

while(true) { // repite la animación indefinidamente
    for(int frame_actual = 0; frame_actual < frames_por_ciclo; frame_actual++) {
        frame_que_pinto = frames[frame_actual];
        pintar_frame(frame_que_pinto, width, height, x, y);
        esperar(tiempo_entre_frames);
    }
}
```




# Spritesheets

---

Es generalmente cómodo y fácil tener todos los frames de una animación en un
solo recurso

---

Podemos usar un atlas de imagen en el que cada imagen sea un frame de la
animación


## *Frames*

---

Un frame, como hemos visto, es cada una de las imágenes que serán representadas
en una animación

---

Generalmente se representa cada frame seguido del siguiente

---

Varios frames forman un *ciclo*

## *Ciclos*


---

Un recurso de animación puede contener varios *ciclos* de animación

Normalmente, una entidad en un videojuego puede hacer varias cosas, de forma
que necesitará una animación para representar cada una de ellas

---

- Andar
- Saltar
- Agacharse
- Disparar

---

Cada una de estas acciones se representa en animación con lo que llamamos
*ciclo*

Un ciclo es una secuencia ordenada de frames que representan un movimiento
continuo

---

Los ciclos pueden ser:

- Cíclicos: diseñados para que, cuando se acabe el último frame, empiece el
  siguiente (andar)
- Simples: diseñados para que se quede en un estado estacionario (morir)


## Combinando frames y ciclos

---

Para combinar frames y ciclos solemos usar una disposición en rejilla

---

Así, cada fila es un ciclo, y cada columna es un frame del ciclo

---


![Spritesheet
(https://www.flickr.com/photos/goosemouse/4998615136)](https://c1.staticflickr.com/5/4147/4998615136_dc0b7b1e39_b.jpg){width=35%}

---

Es importante notar que los ciclos no tienen que tener todos los mismos frames

Desde *el código*, o exportando datos adicionales, se carga la información de:

- El tamaño de cada frame
- Qué ciclos hay
- Los frames de cada ciclo

---


![Frames (verde) y ciclos (rojo)
(https://www.flickr.com/photos/goosemouse/4998615136)](imgs/frameciclo.jpg){width=35%}

(Fijémonos en que el tamaño de frame es distinto en esta imagen: no es cómodo,
pero es posible: habría que indicarlo desde código u otro recurso (un JSON))

## Reusar ciclos

---

Cuando un personaje en 2D se mueve, es muy normal que pueda hacerlo en varias
direcciones

---

Así, en una vista de arriba a abajo, es de esperar que el personaje pueda ir
hacia la izquierda, derecha, arriba y abajo

---

Si tenemos un ciclo de animación en el que el personaje puede ir en una
dirección, no tenemos por qué dibujarlo yendo en la contraria, ya que podemos
aprovechar la simetría

Haciendo esto, hacemos la imagen espejada por software y la usamos como el
ciclo de animación correspondiente


## Enlazando los ciclos

---

Cuando se crean ciclos, es de esperar que, en el videojuego, se pase de uno a
otro de manera "suave"

---

Esto quiere decir (con un ejemplo práctico) que el personaje tiene que pasar
del ciclo de *salto* al ciclo de *andar* de una manera fluida

---

Para hacer esto, se aplica un poco de artesanía al dibujo del sprite, y se
pueden aplicar algunas (o varias) de estas técnicas, entre otras:

---

- se dibujan los principios y finales de las ciclos de manera que sean
  "neutros" (el personaje en una postura que dé lugar a otros ciclos)
- se asume un estilo de sprite animado en el que la transición se muestra muy
  bruscamente
- se hacen diferentes ciclos de transición:
    - se activa andar
    - cuando se deja de andar, se pasa a un ciclo de "parándose", que no es
      cíclico
    - cuando se termina el estado "parándose", se puede activar la animación de
      "quieto" de forma natural
- se anima por huesos (no lo veremos hoy) y se hace la transición de otra forma

# Animación en Phaser

---

Phaser permite animar mediante secuencias de frames y ciclos, y también
mediante animación por esqueleto

## Cargar un spritesheet

Con
[`spritesheet`{.js}](https://phaser.io/docs/2.3.0/Phaser.Loader.html#spritesheet):

```javascript
// se le da el ancho, alto y cuántos frames
game.load.spritesheet('mummy', 'assets/sprites/imagen.png', 37, 45, 18);
mummy = game.add.sprite(200, 360, 'mummy', 5); // '5' es el número de frame
```


## Establecer un ciclo de animación

Se pueden modificar las propiedades de la animación con
[`AnimationManager`{.js}](http://www.phaser.io/docs/2.6.2/Phaser.AnimationManager.html)

```javascript
// animations en un AnimationManager
anim = mummy.animations.add('walk');
```






## Comenzar y detener la animación

---

Con `play`{.js} se ejecuta una animación

El primer parámetro es el framerate (frames por segundo, `null`{.js} para usar el
de la animación por defecto)

El segundo parámetro es para hacer "loop"

```javascript
phoenix.play(null, true);
```


---

Para parar una animación, con `stop`{.js}:

```javascript
phoenix.stop();
```


## Eventos en animaciones

---

Es posible hacer "callbacks" para ser informados de cuándo una animación se
pone en marcha o se detiene:


```javascript
anim.onStart.add(animationStarted, this);
anim.onLoop.add(animationLooped, this);
anim.onComplete.add(animationStopped, this);
```

---

Con esto, podemos controlar, sin necesidad de conteo de frames a mano, el
estado de la animación y actuar en consecuencia:

```javascript
function animationLooped(sprite, animation) {

    if (animation.loopCount === 1)
    {
        loopText = game.add.text(32, 64, 'Animation looped', { fill: 'white' });
    }
    else
    {
        loopText.text = 'Animation looped x2';
        animation.loop = false;
    }

}
```


## Más cosas con animaciones por frames

---

Saber si la animación sigue funcionando

```javascript
function update() {

    if (anim.isPlaying)
    {
        back.x -= 1;
    }

}
```

---

Controlar su condición de "loop"

```javascript
animation.loop = false;
```

