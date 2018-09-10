# Batalla RPG

El ejercicio consiste en modelar e implementar una batalla de un RPG por turnos
en formato conversacional.

Un grupo de personajes controlados por el jugador (PJs) se enfrentará a un grupo
de monstruos controlados por el ordenador (PNJs). Los combatientes se ordenan
al comienzo de la batalla y actúan siguiendo este orden.

La batalla termina cuando uno de los bandos ha sido totalmente derrotado. Si
el bando derrotado es el de los PJs, el juego termina y el jugador pierde. En
caso de que todos los PNJs hayan sido derrotados, el juego también termina y
el jugador gana.

## Los personajes

Tanto PJs como PNJs poseen un **arma** con la que atacar a sus oponentes. El
arma de un personaje es un [objeto](#objetos).

Además, los personajes poseen características que influirán en su valía durante
el combate. Tales características son iniciativa, defensa, puntos de mana,
puntos de maná máximos, puntos de vida y puntos de vida máximos.

La **iniciativa** determina el orden en el que los personajes apareceren en la
lista de turnos. Cuanto más alto, antes aparecen en esta lista.

La **defensa** establece la probabilidad (del 0 al 100) de que un
[efecto](#efectos) actúe sobre el personaje.

Los **puntos de maná** sirven para pagar los costes mágicos de los hechizos y
los **puntos de vida** indican cuánto daño es capaz de resistir el personaje
antes de ser declarado muerto. Ambas características están ligadas a unos
valores máximos **puntos de maná máximos** y **puntos de vida máximos**
respectivamente que no pueden sobrepasar.

La siguiente tabla resume las características:

| Característica | Mínimo | Máximo | Limitado por           |
|:---------------|-------:|-------:|:----------------------:|
| Iniciativa     |      0 |      - |                      - |
| Defensa        |      0 |    100 |                      - |
| Puntos de vida |      0 |      - | Puntos de vida máximos |
| Puntos de maná |      0 |      - | Puntos de maná máximos |

Los personajes tienen también un **nombre** que los identifica en la interfaz de
usuario y un **arma** con la que podrán atacar a otros personajes.

De entre los personajes, los PNJs tendrán asociada una **IA** que [tomará las
decisiones](#ia-enemiga) de batalla cuando les llegue el turno.

## Armas

Las armas son elementos del juego que pueden equiparse en los personajes.
Todas las armas han de tener un [efecto](#efectos) que **decrezca los puntos de
vida del objetivo**. Las armas no se gastan ni tienen coste y al adquirirse por
un personaje reemplazan su arma actual sin pasar por el
[inventario común](#inventario-común).

Nuestra definición de arma incluye también las extremidades corporales que
se utilicen para causar daño. Un personaje sin arma **no puede**
[atacar](#atacar). Si desea atacar _con sus manos desnudas_ habrá de equipar el
arma _puños_, por ejemplo.

De forma similar los personajes monstruosos usarán armas tales como las
_garras_, _tentáculos_ o _aguijones_ para infligir daño en sus víctimas.

## Pergaminos

Los pergaminos desatan magia al ser leídos en voz alta. Como las armas, tampoco
se gastan pero han de tener un coste **para el usuario en puntos de maná**. El
efecto puede ser cualquiera y al adquirirse se almacenan en el [grimorio
común](#grimorio-común). En este RPG simplificado no hay profesiones y todos los
personajes pueden lanzar hechizos.

### Grimorio común

El grimorio común es la colección de pergaminos de la que disponen los PJs para
lanzar hechizos. Se accede a él usando la [acción _Magia_](#acciones) del menú
de acciones.

## Objetos

Al contrario que armas y pergaminos, los objetos son elementos del juego
fungibles (que se gastan). Su [efecto](#efectos) y [coste](#costes) pueden ser
cualesquiera. Los objetos se acumulan en el
[inventario común](#inventario-común).

### Inventario común

El inventario común es la colección de objetos fungibles de la que disponen los
PJs para utilizar durante el combate. Se accede a él usando la
[acción _Inventario_](#acciones).

El inventario presenta los objetos en su interior agrupados por tipo. Cuando
la cuenta de un objeto llega a cero, el espacio que ocupaba es liberado.

## El juego

La implementación mínima que habréis de entregar incluye las siguientes fases:

  1. [Batalla](#la-batalla)
  2. [Fin de juego](#fin-de-juego)

La batalla, a su vez, se divide en 3 fases que se describen a continuación.

### La batalla

La batalla empieza con una [preparación](#preparación) en la que se eligen los
monstruos y se ordenan los personajes. Le sigue la fase de
[presentación](#presentación) durante la cual se presentan los combatientes y la
lista de turnos. A continuación comienza la fase de
[acciones por turno](#acciones-por-turno). Tras cada turno se comprueba si
alguno de los bandos ha sido derrotado y en tal caso, se declara al otro como
vencedor y termina la batalla.

En resumen:
  1. Preparación
  2. Presentación
  3. Acciones por turno

#### Preparación

Durante la preparación de la batalla se elije aleatoriamente la composición
del bando de monstruos compuesto por un grupo de 1 a 3 PNJs. El bando de héroes
estará compuesto siempre por tres PJs.

Los turnos se establecen ordenando a todos los personajes de **mayor a menor
iniciativa**. Una vez ordenados se pasa al siguiente estado.

#### Presentación

Durante la presentación se **imprime el grupo de mosntruso** y **la lista de
turnos** y se pasa al siguiente estado.

#### Acciones por turno

Los personajes actúan en el orden de la lista de turnos. Durante el turno, el
personaje efectúa una única acción y pasa el turno al siguiente. Al final de
cada turno se comprueba qué personajes han muerto y si los bandos ha sido
[derrotados](#derrota). En caso negativo, la batalla continúa con el siguiente
de la lista.

Una vez se ha pasado por todos los personajes, se comienza desde el principio de
la lista.

Un personaje muere si sus puntos de vida llegan a 0.

#### Acciones

Las acciones que puede hacer un personaje durante el turno son:

  * Atacar
  * Defender
  * Lanzar hechizo
  * Usar objeto

Excepto en **defender**, en todas las demás acciones intervienen el personaje
**activo** (quién realiza la acción), el personaje **objetivo** (quién recibe la
acción), un **indicador de alianza** que describe si personaje activo y
objetivo son aliados o no y un elemento del juego (un arma, un pergamino o
un objeto).

Ningún personaje objetivo puede estar muerto.

##### Atacar

Si el personaje decide atacar, habrá de elegir un personaje objetivo. Una vez
seleccionado se aplican las [reglas de efecto](#reglas-de-efecto) sobre el arma,
el objetivo y el indicador de alianza.

##### Defender

Si el personaje decide defender, recupera un 10% de sus puntos de vida.

##### Lanzar hechizo

Si el personaje decide lanzar hechizo, habrá de elegir el pergamino que quiera
leer de entre aquellos en el [grimorio común](#grimorio-común) El coste del
pergamino seleccionado debe ser inferior o igual a los puntos de maná del
personaje activo. En caso contrario no se podrá usar ese pergamino.

Una vez seleccionado el pergamino, se procede a elegir el objetivo y una vez
elegido el objetivo, se aplican las [reglas de efecto](#reglas-de-efecto) con
el efecto del pergamino, el objetivo y el indicador de alianza.

A continuación se descuenta el coste del pergamino de los puntos de maná
corrigiendo el nuevo valor para que no se salga del rango.

##### Usar objeto

Igual que en lanzar hechizo, al usar un objeto, el personaje activo habrá de
elegir el objeto de entre el [inventario común](#inventario-común). Una vez
elegido, tendrá que seleccionar un objetivo. Elegidos objeto y objetivo se
aplicarán las [reglas de efecto](#reglas-de-efecto) para el efecto del objeto,
el personaje objetivo y el indicador de alianza.

A continuación se descuenta una unidad del objeto seleccionado y se retira
del inventario si llega a 0 objetos.

### Fin de juego

Si es el bando de PNJs es el que resulta vencedor, se informa al jugador de que
ha perdido y la partida termina.

Si por el contrario, es el bando de PJs el que resulta vencedor, la partida
termina y se muestra el daño total recibido. A modo de competición, menor daño
es indicativo de mejores resultados.

## Efectos

Armas, objetos y pergaminos tienen **un efecto asociado**. El efecto es un
**cambio sobre una característica del personaje** expresado como un número
entero positivo o negativo.

Las [reglas de efecto](#reglas-de-efecto) especifican cómo se debe aplicar el
efecto a un personaje durante las acciones de batalla.

### Reglas de efecto

Las reglas de efecto esperan un efecto cualquiera, un objetivo y un indicador
de alianza que indica si el objeto está siendo empleado por un aliado del
objetivo o no.

El procedimiento es el siguiente:

  1. Si el indicador de alianza indica que son aliados, continúa con el paso 2.
  Si no:
    1. Genera un número al azar del 1 al 100.
    2. Si el resultado se encuentra por debajo o es igual a la resistencia del
    objetivo, suspende estos pasos. Si no, continúa con el paso 2.
  2. Por cada característica afectada por el efecto
    1. Suma el valor del efecto al valor de la característica del objetivo.
    2. Corrige el valor para que se encuentre entre 0 y el máximo para esa
    característica, si tiene.

## Control

Durante esta práctica no se implementará ninguna interfaz de control lo que no
significa que no se pueda jugar. Para jugar, importaremos el módulo que
representa nuestro juego en la consola de node y utilizaremos la API de control
del juego para jugar.

### IA enemiga

La inteligencia artificial enemiga sólo puede realizar [ataques](#atacar) contra
héroes. La selección del héroe es aleatoria.
