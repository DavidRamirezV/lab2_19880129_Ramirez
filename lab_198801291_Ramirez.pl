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
   RepoOutput=[NombreRepo,Autor,Fecha, [Workspace,Index,Local,Remote]].




/*
 Predicado: fecha(Y).
 Descripción:Consulta la fecha y hora actual al equipo.
 Dominio: Una Variable (Y).
 Resultado: Fecha y hora actual.
 */
fecha(Y) :-
   get_time(X),
   convert_time(X,Y).


/*
 Predicado: gitInit(NombreRepo,Autor,RepoOutput).
 Descripción:Permite devolver el valor que debe tomar RepoOutput
 Dominio  : Nombre del Repositorio (string) y su Autor (string)
 Resultado: Lista con la informacion entregada y cuatro listas vacias
            que representan a las cuatro zonas de un repositorio
*/


gitInit(NombreRepo, Autor, RepoOutput):-
    string(NombreRepo),
    string(Autor),
    fecha(Fecha),
    crearRepo(NombreRepo,Autor,Fecha, [],[],[],[],RepoOutput).

/*
 *
    contiene([4,2,6,7,22,5],5).
    true.
*/
contiene([],_) :-false.
contiene([A],A) :-!, A.
contiene([A|_],A) :-!, A.
contiene([_|Resto],A):-contiene(Resto,A).



gitAdd(RepoInput, Archivos, RepoOutput):-
    is_list(RepoInput),
    is_list(Archivos),
    nth0(0,RepoInput,NombreRepo),
    nth0(1,RepoInput,Autor),
    nth0(2,RepoInput,Fecha),
    nth0(3,RepoInput,Zonas),
    nth0(0,Zonas,Workspace),




    crearRepo(NombreRepo,Autor,Fecha, Workspace,Workspace,[],[],RepoOutput).



/*

gitCommit(RepoInput, Mensaje, RepoOutput).
gitPush(RepoInput, RepoOutput).
git2String(RepoInput, RepoAsString).
*/







