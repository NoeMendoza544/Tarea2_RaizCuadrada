;Escribir un algoritmo (programa) en lenguaje ensamblador que calcule
;la raiz cuadrada de un numero entero, sin signo, de 8 bits. El numero
;del que se obtendra su raiz debe ser dado en BCD (decimal), en el
;registro B, de tal manera que podremos obtener la raiz cuadrada
;de numeros en el rango de 0 a 99 (decimal), el resultado (solo
;la parte entera), debe ser depositado (en decimal) en el registro C

; programa
	.org 0000h
	ld B,42	;introducir el numero al que se le quiere sacar raiz
	ld C,0 ;Iniziliza C con 0
	ld A,B ;carga en A lo que hay en B

;Comparador
	cp 0 		;Compara A con 0
	jr Z, final 	;Si A es igual a 0, salta hasta "final"

	cp 1		; Compara A con 1
	jr Z, final 	;Si A es 1, salta hasta "final"

	ld D,1	;Inicializa D con 1
	ld E,1	;Inicializa E con 1

ciclo: ;Este bucle compara el valor de B con D, y si es menor, salta a "final_1"
	;de lo contrario, incrementa E e inicializa los registros H y L con 0.

	ld A,B
	cp D		;Compara A con D
	jr C, final_1 	;Si A < D, salta a "final_1"
	inc E
	ld H,0
	ld L,0


mult: ;El bucle se repite hasta que el valor de E sea igual a H.

	ld A,L	;Carga el valor de L en A
	add A,E	;Suma el valor de E a A
	ld L,A	;Guarda el resultado en L
	inc H	;incrementa el valor de H
	ld A,E
	cp H	;Compara A con H
	jr nz, mult	;Si A no es igual a H, regresamos a "mult"
	ld D,L	;Carga el valor de L en D
	jr ciclo ;Vuelve al "ciclo"

final:	;carga el valor de A en C
	ld C,A
	jr transformar

final_1: ;decrementa E, lo guarda en C.

	dec E
	ld C,E
	jr transformar


transformar: ;convierte un número decimal insertado en B en BCD

	ld A,B
	ld L,0

ciclo_2:

	cp 10 		;Compara A con 10
	jr C, done	;Si A es menor que 10, manda a "done"
	sub 10		;Resta 10 a A
	inc L		;Incrementa L para contar cuántas veces se ha restado 10
	jr ciclo_2	;Repite el ciclo hasta que A sea menor a 10

done:
	sla L		;Desplaza L a la izquierda 1 bit (multiplica por 2)
	sla L		;repite el desplazamiento (por 4)
	sla L		; repite el desplazamiento (por 8)
	sla L		;repite el desplazamineto (por 16)
	or L		;Combina A con L
	ld B,A		;Manda el resultado en BCD a B
	halt

;Fin del programa

	.end