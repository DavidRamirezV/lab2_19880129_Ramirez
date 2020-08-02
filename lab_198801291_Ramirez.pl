/*
Laboratorio 2: Git
Autor: David Ramírez
Rut: 19.880.129-1
*/


/*
Se considerando el siguiente TDA para los Repositorios
  [NombreRepositorio,Autor,Fecha,[[Workspace],[Index],[LocalRepository],[RemoteRepository]]]

*/

crearRepo(NombreRepo,Autor,Fecha,Workspace,Index,Local,Remote,RepoOutput):-
   string(NombreRepo),
   string(Autor),
   string(Fecha),
   is_list(Workspace),
   is_list(Index),
   is_list(Local),
   is_list(Remote),
   RepoOutput=[NombreRepo,Autor,Fecha, Workspace,Index,Local,Remote].




/*
 Predicado  : fecha(Y).
 Descripción: Consulta la fecha y hora actual al equipo.
 Dominio    : Una Variable (Y).
 Resultado  : Fecha y hora actual.
 */
fecha(Y) :-
   get_time(X),
   convert_time(X,Y).


/*
 Como ejemplo creare un workspace con archivos
 Se asumira un archivo como una lista con dos strings
*/

workspace("comida.txt").
workspace("perro.in").
workspace("salida.out").
createWorkspace(Salida):-
  findall(C,workspace(C),Salida).

editZonas(RepoInput,W,I,L,R,RepoOutput):-
    nth0(0,RepoInput,NombreRepo),
    nth0(1,RepoInput,Autor),
    nth0(2,RepoInput,Fecha),
    is_list(W),
    is_list(I),
    is_list(L),
    is_list(R),
    RepoOutput=[NombreRepo,Autor,Fecha,W,I,L,R].





/*
 Predicado  : gitInit(NombreRepo,Autor,RepoOutput).
 Descripción: Permite devolver el valor que debe tomar RepoOutput
 Dominio    : Nombre del Repositorio (string) y su Autor (string)
 Resultado  : Lista con la informacion entregada y cuatro listas vacias
              que representan a las cuatro zonas de un repositorio
*/

gitInit(NombreRepo, Autor, RepoOutput):-
    string(NombreRepo),
    string(Autor),
    fecha(Fecha),
    crearRepo(NombreRepo,Autor,Fecha, [],[],[],[],RepoOutput).


/*
 Predicado  : gitAdd(RepoInput,Archivos,RepoOutput).
 Descripción: Permite añadir valores desde Workspace a Index.
 Dominio    : Repositorio (list), nombre de los Archivos que se quieren
              agregar a Index (list).
 Resultado  : Repositorio editado con la nueva informacion.
 */

gitAdd(RepoInput, Archivos, RepoOutput):-
    is_list(RepoInput),
    is_list(Archivos),
    nth0(0,RepoInput,NombreRepo),
    nth0(1,RepoInput,Autor),
    fecha(Fecha),
    nth0(3,RepoInput,W),
    intersection(Archivos,W,Encontrado),
    crearRepo(NombreRepo,Autor,Fecha, W,Encontrado,[],[],RepoOutput).




gitCommit(RepoInput, Mensaje, RepoOutput):-
   is_list(RepoInput),
   string(Mensaje),
   nth0(0,RepoInput,NombreRepo),
   nth0(1,RepoInput,Autor),
   nth0(2,RepoInput,Fecha),
   nth0(3,RepoInput,W),
   nth0(4,RepoInput,I),
   L=[Mensaje|[I]],
   crearRepo(NombreRepo,Autor,Fecha, W,I,L,[],RepoOutput).




gitPush(RepoInput, RepoOutput):-
   is_list(RepoInput),
   nth0(0,RepoInput,NombreRepo),
   nth0(1,RepoInput,Autor),
   nth0(2,RepoInput,Fecha),
   nth0(3,RepoInput,W),
   nth0(4,RepoInput,I),
   nth0(5,RepoInput,L),
   crearRepo(NombreRepo,Autor,Fecha, W,I,L,L,RepoOutput).



git2String(RepoInput, RepoAsString):-
   is_list(RepoInput),
   nth0(0,RepoInput,NombreRepo),
   string(NombreRepo),
   nth0(1,RepoInput,Autor),
   string(Autor),
   nth0(2,RepoInput,Fecha),
   string(Fecha),
   nth0(3,RepoInput,W),
   is_list(W),
   nth0(4,RepoInput,I),
   is_list(I),
   nth0(5,RepoInput,L),
   is_list(L),
   flatten(L,L2),
   nth0(6,RepoInput,R),
   is_list(R),
   flatten(R,R2),


   string_concat("\n\n######  Repositorio '", NombreRepo, cadena0 ),
   string_concat(cadena0, "' ######"  , cadena1 ),
   string_concat(cadena1, "\nFecha de creación: ", cadena2 ),
   string_concat(cadena2, Fecha, cadena3 ),
   string_concat(cadena3, "\nAutor: ", cadena4 ),
   string_concat(cadena4, Autor, cadena5 ),

   string_concat(cadena5, "\nArchivos en Workspace:\n", cadena6 ),
   atomics_to_string(W,"\n",Works),
   string_concat(cadena6, Works, cadena7 ),

   string_concat(cadena7, "\nArchivos en Index:\n" , cadena8 ),
   atomics_to_string(I,"\n",Index),
   string_concat(cadena8, Index, cadena9 ),

   string_concat(cadena9, "\nComits en Local Repository:\n", cadena10 ),
   atomics_to_string(L2,"\n",Local),
   string_concat(cadena10, Local, cadena11 ),

   string_concat(cadena11, "\nComits en Remote Reposiory:\n ", cadena12 ),
   atomics_to_string(R2,"\n",Remote),
   string_concat(cadena12, Remote, cadena13 ),
   string_concat(cadena13,"####################################\n",RepoAsString).












