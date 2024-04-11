% Hechos que definen las conexiones entre ciudades
conexion(vancouver, [ciudad(edmonton, 16), ciudad(calgary, 13)]).
conexion(edmonton, [ciudad(saskatoon, 12)]).
conexion(calgary, [ciudad(edmonton, 4), ciudad(regina, 14)]).
conexion(saskatoon, [ciudad(calgary, 9), ciudad(winnipeg, 20)]).
conexion(regina, [ciudad(saskatoon, 7), ciudad(winnipeg, 4)]).

% Predicado para mostar las conexiones y sus costos
existe_conexion(CiudadOrigen, CiudadDestino, Costo) :-
    conexion(CiudadOrigen, Conexiones),
    member(ciudad(CiudadDestino, Costo), Conexiones).

% Predicado para verificar si una ciudad tiene conexiones salientes
tiene_aristas(Ciudad):- conexion(Ciudad, _).

% Predicado para obtener el costo y la conexión entre dos ciudades
costos_y_conexion_de(CiudadOrigen, CiudadDestino, Costo):-
    buscar_costo(CiudadOrigen, CiudadDestino, [CiudadOrigen], 0, Costo).

% Predicado auxiliar para buscar el costo entre dos ciudades
buscar_costo(CiudadDestino, CiudadDestino, _, CostoAcumulado, CostoFinal):-
    CostoFinal is CostoAcumulado.
buscar_costo(CiudadActual, CiudadDestino, Visitadas, CostoAcumulado, CostoFinal):-
    conexion(CiudadActual, Conexiones),
    member(ciudad(SiguienteCiudad, Costo), Conexiones),
    \+ member(SiguienteCiudad, Visitadas),
    NuevoCostoAcumulado is CostoAcumulado + Costo,
    buscar_costo(SiguienteCiudad, CiudadDestino, [SiguienteCiudad|Visitadas], NuevoCostoAcumulado, CostoFinal).