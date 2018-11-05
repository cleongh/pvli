---
title: 'Prácticas sobre Phaser: Carga de recursos'
...

# Introducción

Hemos desarrollado un prototipo de un juego de plataformas con los Sprites de un famoso videojuego de la Nes y Super Nes: Battletoads. Pero a nuestro despistado programador se le han quedado algunas tareas por resolver. El ejercicio consiste en completar los `TODOs` que se indican en cada apartado para hacer que el juego funcione.

## Descripción general del juego

El juego está basado en la plantilla de Phaser proporcionada en clase y consta de los siguientes ficheros:

* `index.html`: página de inicio del juego.
* `raw.html`: iframe que carga la página index con el juego.
* `js/main.js`: En el fichero javascript que se carga en raw.html. Crea el objeto de Phaser y lanza el primer state denominado BootScene. BootScene es la escena de inicio del juego. Piensa en ella como el típico `splash screen` de un juego donde se cargan los primeros elementos necesarios para poder lanzarlo. En este fichero también está implementado la escena de carga del juego tal y como aparece en la plantilla. Aunque la primera escena a cargar después del BootScene es el `MenuScene`{.javascript} que se encuentra en el fichero menu_scene.js.
* `js/menu_scene.js`: Es el primer state con interaccion con le usuario donde mostramos el logo de phaser y un boton de inicio. Al pulsar el botón de inicio, el juego pasará a la pantalla de carga `PreloaderScene`{.javascript} definida en el main.js.
* `js/play_scene.js`: Aquí está desarrollado el state del juego. En dicho state cargamos un tilemap con el mundo que tiene tres capas.
	* *Blackground*: El fondo de la escena con la que el personaje no colisiona.
	* *ground*: El escenario colisionable con el personaje.
	* *deathZone*: Zonas de muerte donde si cae el player, muere. Al morir se muestra el state `GameOver`{.javascript} que está en el fichero gameover_scene.js.
* `js/gameover_scene.js`: Escena donde se muestra el texto de GameOver y un botón para reiniciar el nivel.

# Instalación

Es necesario [descargar la plantilla del juego](ejercicios_tema5.zip). Se trabajará a partir de ella.

Para instalar ejecutar desde la consola:

```bash
$ npm install
```

# Ejecución

Desde dentro de la carpeta del enunciado ejecutar:

```bash
$ node ./node_modules/gulp/bin/gulp run
```

# Ejercicios

## Ejercicio 1: Configurar game con los diferentes States del juego

En el fichero Main, completar los `TODOs` 1.1, 1.2 y 1.3 sobre la gestión de states en el juego y cómo ejecutar el state de inicio.


## Ejercicio 2: Pantalla de carga

Realizar el `TODO` 2.1 y 2.2 sobre la carga en la escena de carga. Debemos cargar:

* La imagen `images/simples_pimples.png` con el nombre de la cache `tiles`
* El atlasJSONHash con `images/rush_spritesheet.png` como imagen y `images/rush_spritesheet.json`
* Escuchar el evento `onLoadComplete`{.javascript} (`TODO` a) y esperar el callback `loadComplete()`{.javascript} para cargar la escena 'play'. Hay que implementar también el método (`TODO` b).


## Ejercicio 3: Carga de la Google Font

* Cargar en raw.htm el Google Font usando `//ajax.googleapis.com/ajax/libs/webfont/1.5.18/webfont.js` (`TODO` 3.1)
* Usars `WebFont.load()`{.javascript} con el objeto wfconfig ya creado, para solicitar la fuente a Google. Nótese que el método **active** invoca a un método init() no definido que es el que verdaderamente crea el juego en Phaser que ahora mismo está siendo creado en el **onload**. Sin embargo, el método onload realmente debe ser utilziado para iniciar la carga de la fuente. (`TODOS` 3.2, 3.3)


## Ejercicio 4: Crear el Tilemap en el state de juego

Crear el Tilemap 'tilemap' y guardarlo en el attributo **map** como miembro de la clase PlayScene en el archivo play_scene.js (Notese que la variable ya se usa mas adelante en el código con ese mismo nombre. Si, no peta, esto es javascript :P) y asignarle al tileset 'patrones' la imagen de sprites llamada 'tiles' cargada en la state `PreloaderScene`{.javascript}. 


## Ejercicio 5: Crear el sprite de Rush, el avatar del player

Creamos a **rush** con el sprite 'rush' previamente cargado en la cache en la posición (10, 10) con el frame por defecto 'rush_idle01'


## Ejercicio 6: Cargar GameOver y descargar los recursos del juego

Cuando el personaje colisione con el plano de muerte dibujado en la capa `Death`{.javascript}, invocará a `onPlayerFell`{.javascript}. En ese momento, hay que poner la pantalla de GameOver.


## Ejercicio 7: Recargar el juego al perder pulsando el boton Reset Game del state GameOver

Implementar el `TODO` 7 de gameover_scene con el callback del botón `var button`{.javascript}.



## Ejercicio 8: Crear un botón que nos devuelva al menú de juego en la ventana de GameOver

Implementa el `TODO` 8 creando el botón 'Return Main Menu' que cargue el menú de inicio.


## Ejercicio 9: Destruir los recursos 'Tilemap', 'tiles' y ~~'logo'~~ al terminar el state PlayScene

No hay que eliminar el logo porque se necesita en el ejercicio anterior (return main menu). Y hay que reestablecer el tamaño del mundo al ambiar el state usando
`this.game.world.setBounds(0,0,800,600);`{.javascript} para reestablecer el tamaño del mundo.


 
