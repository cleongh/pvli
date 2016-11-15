#Prácticas sobre Phaser: Carga de recursos.

Hemos desarrollaod un prototipo de un juego de plataformas con los Sprites de un famoso videojuego de la Nes y Super Nes: Battletoads. El ejercicio consiste en completar los TODOs que se indican en cada partado para hacer que el juego funcione.

##Descripción general del juego

El juego  está basado en la plantilla proporcionada en clase y consta de los siguientes ficheros:
* Index.html: página de inicio del juego.
* raw.html: iframe que carga index con el juego.
* js/main.js: En el javascript que se carga en raw.html. Crea el objeto de Phaser y lanza el primer state denominado BootScene. BootScene es la escena de inicio del juego. Piensa ne ella como el típico splash screen de un juego donde se cargan los primeros elementos para poder lanzarlo. En este fichero tambien está implementado la escena de carga del juego tal y como aparece en la plantilla. Aunque la primera escena a cargar después del BootScene es el **MenuScene** que se encuentra en el fichero menu_Scene.js.
* js/menu_scene.js: Es el primer state con interaccion con le usuario donde mostramos el logo de phaser y un boton de inicio. Al pulsar el botón de inicio, el juego pasará a la pantalla de carga **PreloaderScene** definida en el main.js.
* js/play_scene.js: Aqui está desarrollado el state del juego. En dicho state cargamos un tilemap con el mundo que tiene tres capas.
    * Blackground: El fondo de la escena ocn la que el personaje no colisiona.
    * ground: El escenario colisionable con el personaje.
    * deathZone: Zonas de muerte donde s icae el player muere. Al morir se muestra el state del **GameOver** que está en el fichero gameover_scene.js.
* js/gameover_scene.js: Escena donde se muestra el texto de GameOver y un botón para reiniciar el nivel.

##Instalación

Para instalar ejecutar desde la consola:

$ npm install

##Ejecución

Desde dentro de la carpeta del enunciado ejecutar:

$ node ./node_modules/gulp/bin/gulp run


##Ejercicio 1: Configurar game con los diferentes States del juego.

En el fichero Main, completar los TODOS 1.1, 1.2 y 1.3 sobre la gestión de estates en el juego y cómo ejecutar el state de inicio.


##Ejercicio 2: Pantalla de carga.
Realizar el TODO 2.1 y 2.2 sobre la carga en la escena de carga. Debemos cargar:
* la imagen 'images/simples_pimples.png' con el nombre de la cache 'tiles'
* el atlasJSONHash con 'images/rush_spritesheet.png' como imagen y 'images/rush_spritesheet.json'
* Escuchar el evento onLoadComplete (a) y esperar el callback loadComplete() para cargar la escena 'play'. Hay que implementar tambien el método (b).


##Ejercicio 3: Carga de la Google Font.
* Cargar en raw.htm el Google Font //ajax.googleapis.com/ajax/libs/webfont/1.5.18/webfont.js (TODO 3.1)
* Usars WebFont.load() con el objeto wfconfig ya creado para solicitar la fuente a Google. Notese que el método active invoca a un método init() no definido que es el que verdaderamente crea el juego en Phaser que ahora mismo está siendo creadon en el **onload**. El onload debe ser utilziado para iniciar la carga de la fuente. (TODOS 3.2, 3.3 )


##Ejercicio 4: Crear el Tilemap y crearlo en el state de juego.
Crear el Tilemap 'tilemap' en el attributo **map** como miembro de la clase PlayScene en el archivo play_scene.js y asignarle al tileset 'patrones' la imagen de sprites llamada 'tiles' cargado en la state PreloaderScene. 


##Ejercicio 5: Crear el sprite de Rush, el avatar del player.
Creamos a rush con el sprite 'rush' y con el sprite por defecto en la posición (10, 10) con la animación por defecto 'rush_idle01'


##Ejercicio 6: Cargar GameOver y descargar los recursos del juego.
Cuando el personaje colisione con el plano de muerte invocará a onPlayerFell. En ese momento hay que poner la pantalla de GameOver.



##Ejercicio 7: Recargar el juego al perder pulsando el boton Reset Game del state GameOver.
Implementar el TODO 7 de gameover_scene con el callback del boton **var button**



##Ejercicio 8: Crear un botón que nos devuelva al menu de juego en la ventana de GameOver.
Implementa el TODO 8 creando el botón 'Return Main Menu' que cargue el menu de inicio.


##Ejercicio 9: Destruir los recursos 'Tilemap', 'tiles' y 'logo' al terminar el state PlayScene.


 
