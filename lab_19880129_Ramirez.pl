/*
Laboratorio 2: Git con Prolog
Autor: David Ramírez
Rut: 19.880.129-1
*/


/*
  Predicado : crearRepo(NombreRepo,Autor,Fecha,Workspace,Index,Local,Remote,RepoOutput):
  Descripción: Se encarga de crear un repositorio, se considerando el siguiente TDA para los repositorios
               [NombreRepositorio,Autor,Fecha,[Workspace],[Index],[LocalRepository],[RemoteRepository]]
               una lista de 7 valores siendo los 3 primeros valore strings y los 4 ultimos listas.*/
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
 Resultado  : Fecha y hora actual. */
fecha(Y) :-
   get_time(X),
   convert_time(X,Y).


/*
 Como ejemplo creare un workspace con archivos
 Se utilizara el predicado createWorkspace(Salida) para simular  un
 workspace con 3 archivos de ejemplo, además del predicado editZonas que
 nos permitira editar el TDA del Repositorio.
 Ejemplo de su uso:
 gitInit("Rep1","David Ramírez",Rep1),createWorkspace(Workspace),editZonas(Rep1,Workspace,[],[],[],Rep2). */
workspace("a1.txt").
workspace("asd.dat").
workspace("blablabla.jpg").

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
 * **********************************************************
 * Requerimientos Obligatorios
 */


/*
 Predicado  : gitInit(NombreRepo,Autor,RepoOutput).
 Descripción: Permite devolver el valor que debe tomar RepoOutput.
 Dominio    : Nombre del Repositorio (string) y su Autor (string).
 Resultado  : Lista con la informacion entregada y cuatro listas vacias
              que representan a las cuatro zonas de un repositorio. */

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
 Resultado  : Repositorio editado con la nueva informacion. */

gitAdd(RepoInput, Archivos, RepoOutput):-
    is_list(RepoInput),
    is_list(Archivos),
    nth0(0,RepoInput,NombreRepo),
    nth0(1,RepoInput,Autor),
    fecha(Fecha),
    nth0(3,RepoInput,W),
    intersection(Archivos,W,Encontrado),
    crearRepo(NombreRepo,Autor,Fecha, W,Encontrado,[],[],RepoOutput).



/*
 Predicado : gitCommit(RepoInput,Mensaje,RepoOutput)
 Descripción: Funcion que permite realizar un commit, enviando los archivos desde Index a Local Repository
              y permitiendonos agregar una pequeña descripcion sobre los cambios agregados.
 Dominio : Repositorio (list),Mensje (String).
 Resultado  : Repositorio editado con la nueva informacion. */
gitCommit(RepoInput, Mensaje, RepoOutput):-
   is_list(RepoInput),
   string(Mensaje),
   nth0(0,RepoInput,NombreRepo),
   nth0(1,RepoInput,Autor),
   nth0(2,RepoInput,Fecha),
   nth0(3,RepoInput,W),
   nth0(4,RepoInput,I),
   string_concat('"', Mensaje, Cadena0 ),
   string_concat(Cadena0, '"', Mensaje1 ),
   L=[Mensaje1|[I]],
   crearRepo(NombreRepo,Autor,Fecha, W,[],L,[],RepoOutput).


/*
 Predicado : gitPush(RepoInput,RepoOutput).
 Descripción: Se encarga de enviar los Commits almacenados en local
              repository al remote repository.
 Dominio : Repositorio (list)
 Resultado  : Repositorio editado con la nueva informacion. */
gitPush(RepoInput, RepoOutput):-
   is_list(RepoInput),
   nth0(0,RepoInput,NombreRepo),
   nth0(1,RepoInput,Autor),
   nth0(2,RepoInput,Fecha),
   nth0(3,RepoInput,W),
   nth0(4,RepoInput,I),
   nth0(5,RepoInput,L),
   crearRepo(NombreRepo,Autor,Fecha,W,I,L,L,RepoOutput).


/*
 Predicado : git2String(RepoInput,RepoAsString).
 Descripción: Se encarga de transformar la lista con la información del
              repositorio en un string
 Dominio : Repositorio (list)
 Resultado : String que hara mas facil la visualizacion del repositorio
             entregado usando el predicado write(string). */
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

   string_concat("\n\n######  Repositorio '", NombreRepo, Cadena0 ),
   string_concat(Cadena0, "' ######\n"  , Cadena1 ),
   string_concat(Cadena1, "\nFecha de creación: ", Cadena2 ),
   string_concat(Cadena2, Fecha, Cadena3 ),
   string_concat(Cadena3, "\nAutor: ", Cadena4 ),
   string_concat(Cadena4, Autor, Cadena5 ),
   string_concat(Cadena5, "\n\nArchivos en Workspace:\n   ", Cadena6 ),
   atomics_to_string(W,"\n   ",Works),
   string_concat(Cadena6, Works, Cadena7 ),
   string_concat(Cadena7, "\nArchivos en Index:\n   " , Cadena8 ),
   atomics_to_string(I,"\n   ",Index),
   string_concat(Cadena8, Index, Cadena9 ),
   string_concat(Cadena9, "\nCommits en Local Repository:\n   ", Cadena10 ),
   atomics_to_string(L2,"\n   ",Local),
   string_concat(Cadena10, Local, Cadena11 ),
   string_concat(Cadena11, "\nCommits en Remote Reposiory:\n   ", Cadena12 ),
   atomics_to_string(R2,"\n   ",Remote),
   string_concat(Cadena12, Remote, Cadena13 ),
   string_concat(Cadena13,"\n\n##################################\n",RepoAsString).


/*
 *
 ***************************************************************
 *Requerimientos extras
 */


/*
 * Predicados de ayuda para gitPull, se encargan de rescatar solo los
 * archivos desde el remote repository, sin el comentario */

remoteArchivos([X|_],Archivos):-
   is_list(X),
   Archivos=X.

remoteArchivos([_|Y],Archivos):-
   remoteArchivos(Y,Archivos).


removerDuplicados([],[]).
removerDuplicados([X | Resto], NuevoResto) :-
   member(X, Resto),
   removerDuplicados(Resto, NuevoResto).

removerDuplicados([X | Resto], [X | NuevoResto]) :-
   not(member(X, Resto)),
   removerDuplicados(Resto, NuevoResto).

/*
 Predicado : gitPull(RepoInput,RepoOutput).
 Descripción: Funcion que envia los archivos desde Remote Repository a
 Workspace
 Dominio : Repositorio (list)
 Resultado  : Repositorio editado con la nueva informacion. */

gitPull(RepoInput, RepoOutput):-
   is_list(RepoInput),
   nth0(0,RepoInput,NombreRepo),
   nth0(1,RepoInput,Autor),
   nth0(2,RepoInput,Fecha),
   nth0(3,RepoInput,W),
   nth0(6,RepoInput,R),
   findall(A,remoteArchivos(R,A),R1),
   flatten(R1,R2),
   removerDuplicados(R2,R3),
   intersection(W,R3,R4),
   union(R4,W,R5),
   union(R5,R3,R6),


   crearRepo(NombreRepo,Autor,Fecha, R6,[],[],R,RepoOutput).





/* Ejemplo Completo Actual

gitInit("Rep1","David RamÃ­rez",Rep1),
createWorkspace(Workspace),
editZonas(Rep1,Workspace,[],[],[],Rep2),
gitAdd(Rep2,["a1.txt","blablabla.jpg"],Rep3),
gitCommit(Rep3,"agregados 2 archivos",Rep4),
gitPush(Rep4,Rep5),
gitPull(Rep5,Rep6),
git2String(Rep1,Rep1str),
git2String(Rep2,Rep2str),
git2String(Rep3,Rep3str),
git2String(Rep4,Rep4str),
git2String(Rep5,Rep5str),
git2String(Rep6,Rep6str),

write("\nCREAR REPOSITORIO\n"),
write(Rep1str),
write("\ngit CREAR WORKSPACE\n"),
write(Rep2str),
write("\ngit ADD\n"),
write(Rep3str),
write("\ngit COMMIT\n"),
write(Rep4str),
write("\ngit PUSH\n"),
write(Rep5str),
write("\ngit PULL\n"),
write(Rep6str).

*/
























