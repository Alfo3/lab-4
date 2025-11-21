# lab-4

Alfonso Pavez | 202373613-9 | par: 200
Héctor Chanampe | 202304613-2 | par: 200

Para este laboratorio se uso rars-1.6

---------------------------------
ESPECIFICACION DE ALGORITMOS
---------------------------------

van aqui

---------------------------------
SUPUESTOS DESAFIO 1
---------------------------------

1. Se asumio que los inputs siempre seran positivos
2. La cantidad de Id siempre seran entre 5 y 20 (funciona para fuera de esos rangos igualmente)
3. El n de input de ids sera mayor a 10 y menor a 1000
4. La manera en la que entran los datos son la siguiente: cantidad de id (ejemplo, n) -> se ingresa id1 -> se ingresa id2 -> se ingresa id3..... -> se ingresa idn -> luego hara un display de todos los id con el numero d pasos, id original y el rango

---------------------------------
SUPUESTOS DESAFIO 2
---------------------------------

---------------------------------
RECURSION DESAFIO 1
---------------------------------

CollatzRec se encarga de la recursion, lo hace a traves de los siguientes objetivos:
1. avanzar en la secuancia para un numero n
2. contar los pasos hasta llegar a la minimizacion (1)
3. mantener el valor maximo ingresado en la secuencia
4. retornar todo a traves de las llamadas

Primero que nada se implementa el caso base (n = 1), si el numero ingresado es 1 o se llega a 1, el programa se salta los pasos de recursion

Si el caso no es el base se actualiza el valor maximo, calcula el siguiente n segun collatz, incrementa en 1 los pasos y se vuelve a llamar a si misma con jal

Antes de la recursion, la funcion guarda el contexto de la ejecucion en una pila, luego de una llamada recursiva esta pila se va restaurando en orden que fueron agregadas, y asi es como logra avanzar hasta el caso base y retornar el total de pasos, y con esta informacion catalogar el rango

---------------------------------
ESTRUCTURAS DESAFIO 2
---------------------------------


---------------------------------
INSTRUCCIONES DE USO
---------------------------------

Para la ejecucion de rars, se debe de installar el archivo "rars1_6.jar" y tener una version de java actualizada.

(link para la descarga: https://github.com/TheThirdOne/rars/releases)

Luego, abrir el archivo jar y entrar al programa.

Una vez dentro de rars, ubicar el archivo "subsistema1" y "subsistema2.asm"

Usar el icono de "assemble" y correr el codigo

