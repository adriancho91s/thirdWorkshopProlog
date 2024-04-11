relacion(padre, abraham, [herbet, homero]).
relacion(padre, homero, [bart, maggie, lisa]).
relacion(padre, clancy, [patty, selma, marge]).
relacion(madre, mona, [herbet, homero]).
relacion(madre, marge, [bart, maggie, lisa]).
relacion(madre, jacqueline, [patty, selma, marge]).
relacion(madre, selma, [ling]).

% Predicado para verificar si alguien es padre de otro
es_padre_de(Padre, Hijo):- relacion(padre, Padre, Hijos), member(Hijo, Hijos).

% Predicado para verificar si alguien es madre de otro
es_madre_de(Madre, Hijo):- relacion(madre, Madre, Hijos), member(Hijo, Hijos).

% Predicado para obtener los hijos de un padre
hijos_de(Padre, Hijos):- relacion(_, Padre, Hijos).

% Predicado para verificar si dos personas son hermanas
hermanos(Hermano1, Hermano2):- es_padre_de(Padre1, Hermano1), 
    es_padre_de(Padre1, Hermano2), Hermano1 \= Hermano2; 
    es_madre_de(Madre1, Hermano1), es_madre_de(Madre1, Hermano2), 
    Hermano1 \= Hermano2.

% Predicado para obtener los abuelos de un nieto
abuelos_de(Nieto, Abuela, Abuelo):- (es_padre_de(Padre, Nieto), 
                                    es_padre_de(Abuelo, Padre), 
                                    es_madre_de(Abuela, Nieto)); 
    								(es_madre_de(Madre, Nieto), 
                                    es_padre_de(Abuelo, Madre), 
                                    es_madre_de(Abuela, Nieto)).

% Predicado para verificar si dos personas son esposas
son_esposos(Persona1, Persona2):- es_padre_de(Persona1, Hijos1), 
    							  es_madre_de(Persona2, Hijos2), Hijos1 = Hijos2.

% Predicado para verificar si dos personas son primos
son_primos(Primo1, Primo2):- (es_padre_de(Padre1, Primo1), 
                             es_padre_de(Padre2, Primo2), 
                             hermanos(Padre1, Padre2)); 
    						(es_madre_de(Madre1, Primo1), 
                            es_madre_de(Madre2, Primo2), hermanos(Madre1, Madre2)); 
    						(es_padre_de(Padre1, Primo1), es_madre_de(Madre1, Primo2), hermanos(Padre1, Madre1)); 
    						(es_madre_de(Madre1, Primo1), es_padre_de(Padre1, Primo2), hermanos(Madre1, Padre1)).