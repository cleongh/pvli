---
title: "Javascript como lenguaje de extensión"
# author: Carlos León e Ismael Sagredo
vim: spelllang=es
...


# Lenguajes de Scripting



## ¿Qué es un lenguaje de scripting?
Los lenguajes de scripting, normalmente interpretados, son lenguajes que son concebidos para ser usados como parte de una herramienta. Javascript fue condebido como una forma de programar sobre el navegador web. Algunos lenguajes de scripting se crearon como lenguajes de propósito general, como Python, pero la mayoría de ellos surgieron como extensiones de herramientas específicas.


---

##Ejemplo: Firefox


<img src="imgs/firefox_architecture.png" alt="Ejemplo: Arquitectura Firefox"  height="550px" width="550px"/>


---

##Ejemplo: Firefox

- Gecko: Es el núcleo de Firefox y está escrito en C/C++.
	- Tiene un motor Web
	- Y un engine de renderización.
- El motor usa un interprete de javascript: Spider-Monkey.
- El interprete de javascript se comunica con Gecko.
- Lo que programas en javascript afecta al comportamiento del engine de Firefox.

##¿Cómo se consigue?


- Hay que crear una API en c/c++ a la que invocar desde javascript.
- Hay que crear las llamadas en javascript que invocan el api en c/c++ para poderlas manejar desde javascript.
	- Por ejemplo el objeto window sólo puede ser usado en javascript cuando estamos en el navegador, no existe en node.
	- Tampoco existe DOM en node.
	- Porque window y DOM son la API que proporciona Firefox para manejar el engine desde javascript.


# Otros lenguajes de scripting


## PHP

PHP es un lenguaje de scripting para permitir expandir la funcionalidad del servidor web Apache. Hoy en día se usa como lenguaje de propósito general para crear aplicaciones web
del lado de servidor. Su motor, **Zend Engine**, está escrito en c y puede ser embebido en cualquier servidor web como lenguaje de scripting de forma fácil. También se puede extender su funcionalidad escribiendo extensiones en c.

## Bash

La consola de comandos Bash, consola principal de los sistemas Linux/Unix, tiene un lenguaje de scripting que permite programar sobre ella.

## Python

Python es un lenguaje de propósito general creado para que fuese fácil de aprender y de usar por usuarios con un nivel de alfabetización básico en lenguajes de programación.

Necesita un interprete que debemos instalar en el sistema para poder usarlo (similar a node con javascript) y se ha usado mucho como sustituto de los lenguajes de scripting clásicos para sistemas operativos como Bash o la consola de MS-Dos/Windows.

---

Actualmente el uso de Python se ha extendido enormemente, no sólo como lenguaje de propósito general, si no como lenguaje de __scripting de propósito general__.

Es relativamente fácil embeber Phyton dentro de una aplicación en otro lenguaje (típicamente c/c++) por lo que se ha usado como lenguaje de scripting 
en muchas aplicaciones. Por ejemplo el motor open source **Ogre3D** tiene una versión en la que se usa Python como scripting.

[Embeber Python en una aplicación](https://docs.python.org/3/extending/embedding.html)

## Python en Blender

Blender es una herramienta de código libre para crear y renderizar objetos 3D.

Blender utiliza Phyton como lenguaje de extensión de su herramienta. Con Python se pueden crear macros y extender la funcionalidad de Blender.


[Phyton en blender](https://www.blender.org/api/blender_python_api_2_78a_release/)

---

Internamente Blender utiliza Phyton para crear su interfaz y algunas de sus herramientas internas. Aunque Blender está escrito en C/C++ ha embebido
Phyton como lenguaje de scripting para facilitar la creación de macros y add-ons por parte de los usuarios.



## Lua

Lua es el lenguaje de scripting más usuado en motores de juegos gracias a su facilidad de vinculación con c/c++ y a su relativa velocidad de ejecución.

[Lua](https://www.lua.org/)

---

Lua fue expresamente diseñado para ser embebido como lenguaje de scripting en otros lenguajes.


[Lista de juegos que han utilizado Lua como lenguaje de scripting](https://en.wikipedia.org/wiki/Category:Lua-scripted_video_games)

Pero también se usa en aplicaciones. Por ejemplo, el reproductor multimedia VLC utiliza LUA para que los usuarios puedan crear sus propias extensiones.


[scripting vlc in lua](https://forum.videolan.org/viewforum.php?f=29)


## Luabind.


Luabind es una librería que ayuda a embeber Lua en c++. Simplifica la tarea y permite hacer entre otras cosas:


- Tener clases de c++ en Lua.
- Tener funciones y clases de Lua en c++.
- Polimorfismo de los métodos de una clase base en c++ desde una clase derivada
en Lua.


[Luabind](http://www.rasterbar.com/products/luabind.html)


## Lua en Cocos2d-x.

Cocos2d-X es uno de los motores más usados para crear juegos para móviles. Su principal ventaja es que es multiplataforma. Se programa en C++ y permite compilar
a Android, Windows 10, IOs etc. Cocos2d-x permite hacer scripting usando LUA, pudiendo programar el juego en LUA llamando al motor desarrollado en c++.

[Lua en cocos2d-x](http://cocos2d-x.org/wiki/Lua)


## Lua en CryEngine.

El motor CryEngine de Cryteck utiliza LUA como lenguaje de scripting. Los programadores del engine pueden exponer funciones de sus clases creadas en C++ para que los programadores de scripting en LUA puedan usarlas

[Lua en CryEngine](http://docs.cryengine.com/display/SDKDOC4/Lua+Scripting)



# Ejemplos de uso de Javascript como lenguaje de extensión.




## Introducción

También Javascript se está comenzado a utilizar como lenguaje de extensión de aplicaciones más allá de los navegadores.


## Unity

Unity implementó una versión customizada de Javascript con tipos para integrarlo en su motor. Apostaron muy fuerte por él al principio, pero los usuarios preferian usar C# en vez de la libre interpretación de Unity de Javascript. Actualmente la mayor parte del código escrito para Unity está en C# y Javascript poco a poco va quedando relegado. 


## Cocos2d-x y Cocos2d-JS

Cocos2D-x soporta no sólo scripting en LUA si no también scripting en Javascript.

[Cocos2d-x JSB](http://cocos2d-x.org/wiki/Javascript_Binding)


Hay una versión de Cocos2d en javascript que es también multiplataforma y que añade soporte para Web: Cocos2d-JS.

[Cocos2d-JS](http://cocos2d-x.org/wiki/Cocos2d-JS)



# Construct 2



## Javascript para extender Construct 2

Construct 2 permite extender su funcionalidad usando add-ons en Javascript. Hay diferentes tipos de add-ons que podemos crear:

* Behaviors: comportamientos para Construct.
* Plugins: plugins que permiten aumentar las posibilidades de Construct con nuevas herramientas.
* Los efectos funcionan de otra forma.


---

Para ayudarnos a crear nuestros add-ons, Scirra nos ofrece unas templates que podremos utilizar para crear el contenido.

[Templates](https://www.scirra.com/manual/15/sdk)


---

Para crear un plugin debemos crear una carpeta con el nombre del plugin en 

```js
.\exporters\html5\plugins
```
y para hacer un behavior exactamente lo mismo en 

```bash
.\exporters\html5\behaviors
```


## Creando plugins


En **runtime.js** podemos escribir el comportamiento del plugin.
Con el nombre del plugin, debemos renombrar **cr.plugins_.MyPlugin** y **cr.plugins_.MyPlugin.prototype**
En **edittime.js** trabajaremos la interfaz de edición.

Si queremos añadir un elemento editable desde la interfaz, tendremos que añadirlo a **property_list**
con su correspondiente tipo, por ejemplo para añadir un float:

```js
new cr.Property(ept_float, "Fade in time", 0, "Duration in seconds of fade-in, or zero to skip."),
```

---

En runtime.js **saveToJSON** y **loadFromJSON** sirven para guardar los cambios de la interfaz cuando guardamos el objeto. Así pues,
debemos guardar las variables que queramos conservar.

```js
saveToJSON = function()
{
return {
	"fit": this.fadeInTime,
 }
}
```

---

```js

loadFromJSON = function (o)
{
	this.fadeInTime = o["fit"];
}
```

Para leer el parámetro del editor en el metódo **OnCreate** podemos acceder al array **properties**

```js
this.fadeInTime = this.properties[0]; //lee el valor del primer parámetro.
```


---

Y finalmente podemos modificar alguno de los siguientes métodos para cambiar el comportamiento del plugin


* instanceProto.onCreate = function(): Método que es llamado cuando se crea el objeto.
* instanceProto.onDestroy = function (): Método que es llamado cuando se destruye el objeto para liberar recursos.
* instanceProto.draw = function(ctx) : Método que es llamado cuando se dibuja sobre un layout 2D
* instanceProto.drawGL = function (glw) : Método que es llamado cuando se dibuja sobre un layaout WebGl.

## Creando Behaviors

Para editar un Behavior es similar pero no tenemos los métodos draw ni drawGl y se sustituyen por el método **tick**
que es el encargado de ejecutar el comportamiento frame a frame.

Para leer el tiempo entre frames podéis usar GetDT dentro de runtime

```js
this.runtime.getDt(this.inst);
```



# Embeber javascript en c++.

---
 
Como ya has podido deducir, se puede embeber Javascript en un programa en C++.

Tanto V8 [embeber V8](https://github.com/v8/v8/wiki/Getting%20Started%20with%20Embedding)

Como SpiderMonkey [embeber SpiderMonkey](https://developer.mozilla.org/en-US/docs/Mozilla/Projects/SpiderMonkey/How_to_embed_the_JavaScript_engine)

pueden ser embebidos en una aplicación en c++.

---

Para hacerlo necesitamos el código fuente de V8 y compilarlo junto con nuestro programa. El código fuente podéis
descargarlo aquí [V8 Source Code](https://github.com/v8/v8/wiki/Checking%20out%20source).

Una vez compilado debemos incluir en nuestro programa las cabeceras:

```c
#include "include/libplatform/libplatform.h"
#include "include/v8.h"
```

Y crear las estructuras necesarias para cargar el script a ejecutar desde C++ y ejecutarlo. Conseguir que el código javascript ejecutado pueda manejar objetos
de c++ o que c++ pueda manejar objetos de javascript es algo más complicado, pero posible.




