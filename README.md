# lab-4

Alfonso Pavez | 202373613-9 | par: 200
Héctor Chanampe | 202304613-2 | par: 200

Para este laboratorio se uso rars-1.6

---------------------------------
ESPECIFICACION DE ALGORITMOS
---------------------------------
Desafio 1:
1. el algoritmo lee la entrada n que representa la cantidad de id a ingresar
2. para cada id, aplica la funcion de collatz
3. la recursion retorna el numero de pasos hasta llegar a 1
4. con el numero de pasos, se clasifica el rango del id
5. se imprime el id, la cantidad de pasos y el rango para cada id

Desafio 2:
1. lee una cadena de 16 caracteres
2. capa 1: clasifica cada caracter en 1 de 4 categorias (mayuscula, minuscula, numero y signos especiales)
3. se verifica que haya exactamente 4 de cada categoria
4. capa 2: se divide en 4 bloques donde se calcula la suma de los codigos ascii, cuenta cuantas de estas sumas son impar y verifica si almenos 3 cumplen esta condicion
5. capa 3: se recorren los 16 caracteres para calcular el hash total de la cadena, y se verifica si es mayor a 10000
6. en caso de fallar en cualquier capa, se retorna un mensaje impreso con con el error y en el numero de capa que ocurrio el error, de lo contrario solo imprime un mensaje de exito.


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

no hay supuestos

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
El desafio 2 ocupa las siguientes 5 estructuras claves:

1. buffer de entrada: Se utiliza como fuente para el análisis de tipos de caracteres, para la conformación de bloques de 4 bytes y para el cálculo del hash final
2. tabla de caracteres especiales: Permite validar que los caracteres especiales utilizados por el usuario están dentro del conjunto autorizado
3. Estructura con contadores para su clasificacion: La Capa 1 exige que todos los contadores sean exactamente 4, lo que impone una clasificación estricta de la clave
4. Conjunto de constantes de configuración del sistema: permiten tener la estructura estricta necesaria para pasar de la segunda a la tercera capa
5. Acumulador de hash: Registra el estado del hash incremental, y determina si supera el valor pedido de 10000

---------------------------------
INSTRUCCIONES DE USO
---------------------------------

Para la ejecucion de rars, se debe de installar el archivo "rars1_6.jar" y tener una version de java actualizada.

(link para la descarga: https://github.com/TheThirdOne/rars/releases)

Luego, abrir el archivo jar y entrar al programa.

Una vez dentro de rars, ubicar el archivo "subsistema1" y "subsistema2.asm"

Usar el icono de "assemble" y correr el codigo

