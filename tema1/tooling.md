---
title: Herramientas
#author: Carlos León
#date: 27/09/16
#vim: spelllang=es
...

# Las herramientas **son importantes**

## No sólo escribimos

---

Escribir código no es todo lo que hacemos cuando programamos

---

También:

-   gestionamos archivos
-   gestionamos versiones
-   hacemos publicaciones
-   nos comunicamos con el resto del equipo
-   compilamos/cargamos en el intérprete
-   probamos
-   depuramos
-   ...

## Toolset JS

Existen entornos de desarrollo integrados (IDEs) que permiten trabajar en JavaScript

Nosotros no vamos a trabajar con ellos

<p class="fragment">
El objetivo es aprender cómo funcionan cada una de las piezas
</p>

---

El **ecosistema** de herramientas de JS es muy amplio y hay muchas opciones

Podéis usar las que queráis, pero **tenéis que hacer las entregas según el toolset que se establezca**

## Editor de textos

En general, la mayor parte del tiempo se interactúa con el editor de textos

Esto lo convierte en una de las herramientas fundamentales

---

![GVim](imgs/vim.png){width=70%}

## Consola

La consola (*emulador de terminal*) es la herramienta a través de la cual se interactúa con el sistema operativo mediante comandos textuales

---

La consola es menos evidente para el usuario, pero tiene un sinfín de posibilidades y ofrece mucha **potencia de uso**

---

![Terminal de GNOME](https://upload.wikimedia.org/wikipedia/commons/b/b3/Gnometerminalhelloworld.png)



## Intérprete

El *intérprete* es el programa que recibe el código (en forma de archivo o de instrucciones separadas) y se encarga de ejecutarlo

## Navegador

---

Un navegador es un programa capaz de analizar archivos en HTML y mostrarlos como una [página web](https://es.wikipedia.org/wiki/P%C3%A1gina_web).

![Firefox](imgs/firefox.png){ width=40% }\

Hoy en día, los navegadores más usados contienen un intérprete de JavaScript.

---

Además, los navegadores proveen al intérprete con un modelo del documento ([DOM-Document Object Model](https://es.wikipedia.org/wiki/Document_Object_Model)), que es un API para acceder a una página web


## Servidores web

Un *[servidor web](https://es.wikipedia.org/wiki/Servidor_web)* es un programa de ordenador que, a través de la red, "escucha" peticiones según el protocolo HTTP y envía, como respuesta, páginas web


## Librerías

---

Crear programas que ya han sido programados por otros es una **pérdida de tiempo**

---

Las librerías son fragmentos de código que quedan disponibles para el programador:

``` {.javascript}
// usamos librerías para imprimir contenido
console.log("hola");

// o para mejorar nuestro estilo de código
_.map([1, 2, 3], function(num){ return num * 3; });

// o para acceder a frameworks completos
var game = new Phaser.Game(800, 600, Phaser.CANVAS, 'phaser-example', { create: create });
```

## Análisis estático y testing automático

Herramientas como `jslint` analizan el código de forma estática y hacen recomendaciones sobre su calidad

---

Se pueden hacer tests unitarios con JavaScript ([QUnit](https://qunitjs.com/), [Unit.js](http://unitjs.com/))


## Scripts y despliegue

---

Los entornos de desarrollo proveen herramientas (editor, acceso al compilador, ejecución automática) que ahorran mucho tiempo al programador

---

Pero es importante (y muy útil en entornos reales) saber cómo se crea software usando todas las piezas

---

(Además, es mucho más divertido)

---

Un script de despliegue (que suele ir asociado a un programa o librería) actúa de forma manual o automática para preprocesar, comprobar el código y posiblemente hasta recargar la página que contiene el código en el navegador

---

Los scripts de despliegue tienen muchas grandes ventajas:

-   Ahorra mucho tiempo
-   Hacen que no ocurran fallos humanos en las tareas repetitivas
-   Evitan la necesidad de tener que recordar cómo preparar el código para su ejecución (esto, a veces, es complejo)

## Gestión de versiones

Aparte de los programas muy pequeños, nadie escribe un programa, lo termina y no vuelve a tocarlo nunca

---

> **Siempre** existen versiones de código

---

Las versiones de código, bien usadas, permiten:

-   flexibilidad
-   seguridad
-   trabajo en grupo
-   histórico y revisiones
-   análisis de evolución
-   aceptar contribuciones externas
-   libertad de experimentación

## Esquema general de trabajo

---

![Proceso sin herramientas](trabajo_manual.dot.svg)

---

![Proceso con herramientas](trabajo_general.dot.svg)

# Herramientas para este curso

## Herramientas en PVLI

En PVLI vamos a seguir estas ideas, usando herramientas profesionales

## Editor de textos

---

Es importante (al menos muy útil) usar un editor profesional:

-   [VS Code](https://code.visualstudio.com)
-   [Atom](https://atom.io/)
-   [Sublime](https://www.sublimetext.com/)
-   [Vim](http://www.vim.org/)
-   [Emacs](https://www.gnu.org/software/emacs/)

---

Características deseables:

-   Coloreado de sintaxis
-   Indentación apropiada
-   Ayudas a la edición:
    -   Completado de paréntesis
    -   Autocompletado de código
-   Autocompletado semántico

## Consola/Shell

La consola por defecto de Windows es muy pobre

Hay alternativas:

-   [Cmder](http://cmder.net/)
-   [Conemu](https://conemu.github.io/)
-   [iTerm2](https://www.iterm2.com/)
-   Casi cualquiera en GNU/Linux ([GNOME Terminal](https://es.wikipedia.org/wiki/GNOME_Terminal), [Konsole](https://www.kde.org/applications/system/konsole/))

---

La *shell* es el programa que se ejecuta en la terminal (que es la ventana)


``` {.bash}
$ npm install # instala en local todas las dependencias, que están en "package.json"
$ node node_modules/gulp/bin/gulp.js # lanza todas ls tareas 
```

## Alternativas típicas para la shell

-   [Cygwin](https://www.cygwin.com/), o para más comodidad [MSYS2](https://msys2.github.io/), permiten correr shell UNIX en Windows
-   [Bash](https://es.wikipedia.org/wiki/Bash)
-   [Zsh](http://www.zsh.org/)

## Intérprete

Las primeras semanas usaremos `node.js`, con la versión **que haya instalada en los laboratorios**

![Node.js](https://nodejs.org/static/images/logo.svg){width=40%}

---

`Node.js` incluye un *gestor de paquetes*, [`npm`](https://www.npmjs.com/)

![`npm`](http://www.nodehispano.com/wp-content/uploads/npm.png)

---

Un gestor de paquetes es una herramienta, generalmente con interfaz de terminal, que permite instalar librerías, gestionar dependencias entre ellas y lanzar aplicaciones con comandos simples

---

Así, no hace falta buscar una librería en Internet, encontrar la carpeta donde descargarla, probar la versión, ver que falla y tener que buscar la dependencia...

---

```bash
$ npm install http-server
```

---

Los paquetes tienen [dependencias](http://npm.anvaka.com/). Por ejemplo, [`browserify`](http://npm.anvaka.com/#/view/2d/browserify)

![Ejemplo de dependencias de `browserify`](imgs/browserify.png){width=60%}

---

`npm` gestiona las dependencias por nosotros

## Navegador

Usaremos Chrome/Chromium, con la versión **que haya instalada en los laboratorios**

![Navegador Chrome](https://www.google.com/chrome/assets/common/images/chrome_logo_2x.png?mmfb=a5234ae3c4265f687c7fffae2760a907)

## Servidores web

Aunque, en general, no hará falta instalarlo explícitamente, usaremos cualquier servidor `http`

Para probar, podéis instalar `http-server`, es un "one-liner":

---

```bash
$ npm install http-server # para instalarlo
$ http-server # para ejecutarlo
```

<p class="fragment">Esa instrucción lo descarga, crea una carpeta para instalarlo y lo instala en local junto con sus dependencias</p>

## Librerías

Usaremos muchas, pero en general sólo veremos algunas (la mayoría serán dependencias)

Para los juegos usaremos [Phaser](http://phaser.io/){width=50%}

---

![Phaser](http://phaser.io/images/img.png){height=20%}

## Scripts y despliegue

---

Usaremos [Yeoman](http://yeoman.io/) para el *scaffolding*

Con Yeoman, todo el esqueleto de una aplicación (archivos de configuración, estructura de carpetas) es creado a partir de una plantilla

Así, no tenemos que perder tiempo cada vez que queramos hacer un proyecto nuevo

---

[Gulp](http://gulpjs.com/) es un sistema de construcción

Se programan **tareas** (¡en JS!) y luego se llama a las tareas

---

Las tareas de `gulp` pueden tener dependencias

Por ejemplo, antes de `run`, hay que `deploy`

Así, siempre que hagamos `gulp run`{.bash}, se ejecutará `gulp deploy`{.bash} antes


## Gestión de versiones

Las entregas estarán disponibles en un repositorio `git`

--- 

Consistirán en un texto corto con:

- Un enlace al repositorio (commit **exacto**) 
- Los miembros del equipo
- Lo que ha hecho cada miembro
- Una descripción de todo lo *relevante* (por favor, sólo lo *relevante*)
- En el repositorio git todo estará en [UTF-8](http://stackoverflow.com/questions/2241348/what-is-unicode-utf-8-utf-16), a no ser que haya una buena razón (que habrá que explicar en el texto)

---

En las entregas, poned un texto así:

    entrega: Proyecto 4
    miembros: Alan Turing y Alonzo Church
    repo: github.com/lambda/pr4
    commit: a0bcf435d55135bf218a504cd8e45fd85b845de5

    Alonzo cree que todo es lambda y ha escrito mucho sobre ello.

    Alan, por su parte, ha creado una máquina teórica. 

    Nos hemos dado cuenta de que que ambas soluciones son equivalentes.
    Se puede probar con el script:

    $ node entscheidungsproblem.js

    Y se verá que sale el mismo resultado.
    

## Esquema general de trabajo

---

![Proceso con las herramientas del curso](trabajo_curso.dot.svg)

# Cómo empezar a programar

## Plantilla para la asignatura

En `bash`{.sh}, podéis usar estos comandos (en la consola por defecto Windows será distinto, ved más adelante)

```bash
$ npm install yo # instalar 'yeoman'
$ npm install generator-gamejam # 'instalar el generador de juegos hecho por Belén Albeza (Mozilla)
$ npm install jslint # 'instalar el generador de juegos hecho por Belén
$ node_modules/.bin/yo # arrancar el generador
$ npm install # instalar dependencias
$ node_modules/.bin/jslint src/js/play_scene.js
$ node_modules/.bin/gulp run # arrancar 'gulp', haciendo que recargue la página al guardar
```

---

Belén Albeza ha creado una plantilla de Yeoman para juegos, `generator-gamejam`

No es obligatorio ni necesario usarla, pero puede ahorraros mucho, mucho tiempo

<p class="fragment">(Por otro lado, no está de más cacharrear y hacerlo vosotros mismos)</p>

## Ejecutando en Windows

Como muchos usaréis Windows, y la plantilla ya está hecha, podéis simplificar el proceso

Tras bajar la plantilla:

```
> cd plantilla-juego
> npm install
> node_modules\.bin\gulp run
```

## Pero...

Realmente ahora no es necesario tanto despliegue

---

#. Abrid el editor
#. Escribid algo
#. Guardad
#. Probad
#. Volver al paso 2
