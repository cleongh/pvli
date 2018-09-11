---
title: 'Lenguajes interpretados y dinámicos'
...

# Lenguajes interpretados

## Qué son lenguajes interpretados

---

Los [lenguajes
interpretados](https://en.wikipedia.org/wiki/Interpreted_language) son
lenguajes diseñados para describir programas que **no** se ejecutan en el
procesador, sino en otro programa

Es decir, hay un programa que emula a un procesador: el **intérprete**

![Esquema de lenguaje interpretado](interpretes.dot.svg){height=30%}


## Cómo funcionan

![Funcionamiento de un intérprete](instrucciones.dot.svg)

## En comparación con los compilados


![Funcionamiento de un programa compilado](compilado.dot.svg)


## ECMAScript

ECMAScript/JavaScript es el lenguaje de los navegadores

Comenzó como un pequeño lenguaje que se interpretaba dentro de
[Netscape](https://es.wikipedia.org/wiki/Netscape_Navigator), principalmente para incluir efectos y operaciones sencillas

![Logo
Netscape](https://upload.wikimedia.org/wikipedia/commons/6/66/Netscape_logo.svg)\

# Lenguajes dinámicos

## ¿Qué nos los lenguajes dinámicos?

Son lenguajes *diseñados para* hacer durante la ejecución lo que otros hacen cuando compilan

Aunque no es una clasificación perfectamente formal, se esperan ciertos atributos en estos lenguajes

## Evaluación

Los lenguajes dinámicos suelen ser capaces de evaluar código generado dinámicamente, con una función de tipo `eval`

## Objetos dinámicos

Los lenguajes dinámicos pueden cambiar los campos de sus estructuras de datos en tiempo de ejecución:

```javascript
var a = {};       // se define el objeto sin campos
a.campo = 'hola'; // se añade un campo nuevo
```


## Reflexión

Otra característica típica es la *reflexión*, o conocer y cambiar las propiedades del programa en sí




# Tipado dinámico y estático


## Tipado estático

Los lenguajes de tipado estático tienen sistemas para declarar y fijar el tipo de las variables, estructuras de datos y funciones

Por ejemplo, a través de la declaración de tipos:

```c
int a = 5;
int suma(int x, int y) { return x + y; }
```


## Compilado de tipos estáticos

El compilador tiene mecanismos para saber si una expresión tiene el tipo correcto, *durante la compilación*:

```cpp
int suma(int x, int y) { return x + y; } 

suma(4, "juan"); // el compilador lanza un error
```

## Tipado dinámico

Los lenguajes de tipado dinámico, por el contrario, no tienen compiladores que comprueben el tipo

Así que la corrección será comprobado más tarde, *durante la ejecución*

```javascript
function suma(x, y) { return x + y; } 

suma(4, "juan"); // el intérprete no da error hasta que esto no se ejecuta
```


# JavaScript

## JavaScript

JavaScript es un dialecto de
[ECMAScript](https://es.wikipedia.org/wiki/ECMAScript)

```javascript
var variable = 6;

if(variable === 5) {
    console.log("Sí, es igual a 5.")
}
else {
    console.log("Pues no, vale " + variable + ".")
}
```

## JavaScript

Su sintaxis es parecida a la de C/C++/Java (intencionadamente)

Cuando JS fue creado, Java estaba muy de moda. Por eso se eligieron el nombre y
la sintaxis

> Pero JavaScript tiene **muy poco que ver con Java**


## JavaScript en los navegadores

Casi todos los navegadores "modernos" tienen dentro una máquina virtual que
ejecuta JavaScript

Además, tienen un API llamado DOM (*Document Object Model*) que permite acceder
a las partes del documento (por ejemplo, acceder a un párrafo o imagen de una
página web)


## JavaScript en el mundo real

JavaScript hoy en día se usa para:

- Videojuegos
- Gmail
- Google Calendar
- Facebook
- Scripting
- *Servidores*

# Ejecutando JavaScript

## Node.js

[Node.js](https://nodejs.org/) es un *intérprete* de JavaScript:

#. Recibe código JS como entrada 
#. Lo analiza (hace *parsing*) 
#. Crea una representación intermedia → ¡no lo compila!
#. Ejecuta esa representación intermedia

## Node.js como máquina virtual

Por lo tanto, `Node.js` contiene una máquina virtual capaz de leer, entender y
ejecutar JS

Una MV es sólo código, un programa que "simula" ser un ordenador

Esta máquina se llama [V8](https://en.wikipedia.org/wiki/V8_(JavaScript_engine))

<p class="fragment">**V8** es el motor de [Chrome](https://www.google.com/chrome/browser/desktop/index.html).<p>

## Usando Node.js

`Node.js` se puede usar desde línea de comandos:

```bash
node script.js

# Pues no, vale 6. 
```

## Git

[Git](https://git-scm.com/) es el sistema de control de versiones que usaremos para la asignatura

- [Guía sencilla](http://rogerdudler.github.io/git-guide/index.es.html)
- [Git in Couples](https://github.com/delapuente/gitincouples)

## Git y copias

Usar `git` no significa copiar

Copiar sigue siendo ilegal en la asignatura