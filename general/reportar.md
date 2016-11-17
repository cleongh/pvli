---
title: Cómo preguntar dudas e informar de errores
author: Carlos León
vim: spelllang=es
...

# Cuando surgen los errores

Es normal (y positivo) que, durante el desarrollo de la asignatura, surjan
errores de código y ejecución. Cuando sea así, podéis y debéis preguntar
tanto a vuestros compañeros como al equipo docente.

# Antes de preguntar

#. Busca en el foro de la asignatura, si es una duda concreta sobre la
práctica.
#. Busca en Internet ([Stack Overflow](http://stackoverflow.com/), Google...)
si los problemas son generales (Phaser, JS...)
#. Intenta arreglarlo. Piensa, reduce el error al mínimo.
    #. Depura (`console.log`{.js} funciona, pero usa depuración gráfica)
    #. Identifica qué puede ir mal

Ten en cuenta que cada pregunta requiere tiempo tuyo, de tus compañeros y de
tus profesores. Y a nadie le sobra. Además, aunque sea cómo (y egoísta)
preguntar sin haber hecho el trabajo primero, buscar e intentar encontrar la
solución **es el mejor camino para convertirse en un buen programador**.

Pero, por supuesto, no tiene sentido buscar como locos durante una semana. Si,
tras la búsqueda, no habéis encontrado nada, es el momento de hacer la
pregunta.

# Cómo preguntar

Imaginad que llamáis al médico, y tenéis la siguiente conversación:

---Doctor, me encuentro mal.\
---Bien, dígame, ¿cómo puedo ayudarle?\
---No sé, no estoy bien. Intento estar bien, pero no lo consigo. Tengo síntomas
extraños. No estoy como me gustaría. **¿Qué me pasa?**

Puede parecer una broma, pero es posible que esto os suene más real:

---Profesor, mi práctica no funciona.\
---Bien, dime, ¿cómo puedo ayudarte?\
---No sé, no va bien. Intento que funcione, pero no lo consigo. Me da un error
extraño. No imprime lo mismo que dice el enunciado. **¿Qué he hecho mal?**

Aunque exagerándolo, y con un poco de humor, este tipo de descripciones es
normal. Es imposible dar una respuesta con tan poca información.

## ¿Cómo formulo mi error?

Para tener una solución, hay que hacer un diagnóstico. Y, para tener un
diagnóstico, hacen falta **datos**. Dado que estamos programando, vuestros
datos son:

- El código. Tenéis que poner todo el código relevante (no sólo una línea, e
  idealmente poner un enlace a un commit/repo, o mediante
  [pastebin](http://pastebin.com/) o [Gist](https://gist.github.com/)).
- Las versiones de intérpretes, navegadores y demás que usáis: salida de `node --version`{.js}, versión del navegador, etc.
- La salida por consola: intentad evitar capturas de pantalla. Copiad y pegad
  texto. Usad [pastebin](http://pastebin.com/). En el caso del navegador, sin
  embargo, una captura puede ser útil.
- La secuencia que habéis seguido para que os dé el error (si es de ejecución).
  Una lista, ordenada, paso a paso, para reproducir el error:
    #. Ejecuto `node init.js`{.bash}
    #. Cuando sale el menú (ejemplo en <http://pastebin.com/s2n986aund>), elijo `0`{.bash}.
    #. El error salta.

## Ejemplo

> Hola a todos:
>
> Estoy con la práctica 6 y tengo un error extrañísimo. El entrar en el menú de
> opciones y elegir "aplastar enemigo con alegría", me dice que no se puede
> llamar a `undefined`{.js}.
>
> Yo 1. arranco con `node init.js`{.sh}, 2. elijo "aplastar enemigo", 3. elijo
> "aplastar con alegría", y me sale el error que podéis ver en
> <http://pastebin.com/s2n986aund>.
>
> Mi código está en Github, en alumnofiera267/practica7, en el commit
> `a56afde34`...
>
> Una captura de lo que me sale en el navegador está en
> <https://imagebin.ca/v/32HTFG3qbe4k>.
>
> ```
> # node --version
> v4.6.1 
> ```
>
> ```
> # chromium --version 
> Chromium 54.0.2840.100
> ```
>
> ¡Gracias!


## ¿Dónde pongo la pregunta?

En el foro del Campus Virtual.

Cualquier pregunta privada ocurre varias veces, todos los años. Si vuestra
pregunta está en el foro, todos podrán beneficiarse de la solución, además de
que otro compañero puede ayudaros y, a veces, con menos retraso que el equipo
docente (estamos siempre atentos, pero no damos abasto muchas veces).


# Compartir es positivo

No tengáis miedo de compartir material. Mostrar el código y leer código de los
demás es muy didáctico y facilita la colaboración. **Vuestro código no tiene
valor, lo que tiene valor es lo que aprendéis mientras lo escribís**.

## Cuidado con las copias

Como se comenta en varios lugares, **copiar es ilegal, y supone suspender**.
Una cosa es compartir código e información (que *siempre* es positivo) y otra
muy distinta usar las líneas de código de otro en nuestra práctica. Recordad:
estáis cursando este grado y esta asignatura porque queréis aprender. Aquel
para quien no sea así, y sólo quiera aprobar y pasar a lo siguiente, debería
replantearse si está en el sitio apropiado.

Por lo demás, en la asignatura usamos software (muy efectivo) de control de
copias. Copiar es siempre una mala idea.
