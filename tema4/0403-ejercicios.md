---
title: Ejercicios de arquitecturas de componentes con JavaScript
#author: Carlos León
#date: 18/10/16
#vim: spelllang=es
...

<!-- # Introducción -->

<!-- Estos ejercicios se entregarán en el Campus Virtual, siguiendo las
[instrucciones usuales de
entrega](../general/criterios_evaluacion.html#cómo-entregar). La fecha de
entrega está publicada en la tarea correspondiente. -->

<!-- Todos los ejercicios son ampliaciones sobre el código del tema 4. Por lo tanto,
la entrega consistirá en un solo repositorio y un solo `commit`.  -->

<!-- En los comentarios de la práctica debéis comentar qué ejercicios resolvéis, y
cómo lo hacéis. **Un ejercicio resuelto pero no indicado en los comentarios de
la entrega será considerado _no resuelto_**. -->

# Ejercicio 1

Basándote en el código del tema 4, añade un tipo de mensaje llamado `Sleep`,
que haga que la entidad que lo reciba no haga nada durante su ciclo, pasen los
ciclos que pasen, hasta que reciba un mensaje `WakeUp` (también tienes que
implementar este mensaje).

# Ejercicio 2

Basándote en el código del tema 4, crea un tipo de componente que, en cada
ciclo, aumente la vida de una entidad. Llámalo `Healer`. Ten en cuenta que en
el diseño original del código del tema 4, las entidades no tienen vida. Tendrás
que crear, para implementar este componente, otro componente que usen las
entidades que tienen vida. 

Piensa en cómo deben comunicarse estas entidades. La idea del ejercicio es que
el diseño siga siendo orientado a componentes y que sea lo más puro posible.

# Ejercicio 3

Modifica el código original para que la función `tick` de `Game` no se envíe el
mensaje `Presence`, sino que cada entidad lance el mensaje según lo considere
oportuno.

(PISTA: las entidades "dormidas" no tienen que anunciar su presencia, pero esto
no debería modificar mucho el código del [ejercicio 1](#ejercicio-1)).

# Ejercicio 4

1.  Haz un componente para entidades que se muevan. No te preocupes por la
    implementación, con que la entidad imprima "me estoy moviendo" en cada
    ciclo, junto a su nombre, es suficiente.
2.  Haz un componente para entidades que tengan volumen físico (entidades con
    las que se pueda colisionar). No te preocupes por la implementación, con
    que la entidad imprima "tengo volumen" en cada ciclo, junto a su nombre,
    es suficiente.
3.  Crea una entidad que se mueva, pero no tenga volumen físico. Añádela
    al juego.
4.  Crea una entidad que tenga volumen físico, pero que no se mueva. Añádela
    al juego.
5.  Crea una entidad que tenga volumen físico y que se mueva. Añádela al juego.

-----

Ahora, teniendo en cuenta que *tienes que usar herencia*, añade en alguna parte
de tu código un comentario con una jerarquía de clases que te permita
implementar los puntos 3, 4 y 5. **No tienes que implementarla, sólo pensar en
ella y añadir un bloque de comentario en el archivo con lo que se te ocurra**. Sé
original y piensa en las alternativas.
