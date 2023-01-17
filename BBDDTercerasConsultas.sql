/*Seleccionar els departaments i la ciutat en la que estan situats els empleats.*/
select department_name, city
from departments d join locations l on d.location_id = l.location_id;

/*Seleccionar tots els empleats amb el seu nom de departament.
 Obtenir els diferents departaments de la taula empleats.*/

select *
from employees e join  departments d on e.department_id = d.department_id;

/*Seleccionar l’identificador, cognom i ofici (nom d’ofici) dels empleats que pertanyin al departament 80.*/
select employee_id , last_name,department_name
from employees e join departments d on e.department_id = d.department_id
where d.department_id = 80;


/*Obtenir el cognom i l’ofici dels empleats dels quals el seu ofici no sigui cap de vendes (Sales Manager).*/
select last_name, department_name
from employees e join departments d on e.department_id = d.department_id
where d.department_id not in (select department_id from departments
                               where department_name  ilike 'sales');

/*Selecciona els departaments, ciutat i país on estiguin ubicats.*/
select department_name, city, country_name
from departments d join locations  l on d.location_id = l.location_id
join countries c on l.country_id = c.country_id
order by  c.country_id;

/*Selecciona el cognom, nom d’ofici i nom de departament de tots els empleats, pels quals el seu cognom comença per ‘A’
i tingui més de 6 lletres*/




/*
Selecciona el cognom dels empleats que tinguin el mateix ofici que el seu cap.
Obtenir el cognom dels empleats conjuntament amb el cognom del seu corresponent cap, ordenat pel cognom del director.
Llistar els empleats de departaments amb codi major que el codi del departament del Marketing (fer-ho mitjançant subconsulta i mitjançant consulta multitaula)
Selecciona les dades dels empleats que treballen en el departament de Marketing


/*
Selecciona els empleats que tenen un salari inferior al salari mitja (AVG(salary))
 */


/*
Selecciona els països que estan en el mateix continent que Argentina.
 */
/*Selecciona els empleats que tenen un salari inferior al salari mitjà dels empleats que son representants de vendes (job_id=’SA_MAN’).
*/
/*
Obtenir tots els empleats amb el mateix ofici que David Austin.
 */

Obtenir tots els empleats que el seu lloc de treball sigui Sales Manager.
 */
/*Obtenir tots els empleats que no treballin al departament de Steven King
*/
/*
select * from employees where employee_id != (Select employee_id
                                                from employees
                                                where first_name ilike 'Steven' and last_name ilike 'king');
/*
Obtenir les dades dels empleats que guanyen més que qualsevol del departament 30.
 */

/*
Visualitza els departaments que hi són a Seattle.
Selecciona el nom, cognom i el nom del departament dels empleats que treballen en Seattle.
Visualitza aquells empleats que no treballen en el departament de Marketing ni el de vendes
Visualitza aquells empleats que treballen en el departament de Marketing o en el de Vendes.
Llistar els països d'Àsia o Europa.
Obtenir les dades dels empleats els quals el seu nom comença per H i el seu salari és més gran que algun empleat del departament 100.
Troba el nom i els cognoms del cap de David Austin.
Selecciona tots els empleats que treballen a USA.
Troba els empleats que guanyen el salari mínim corresponent a seu lloc de treball.
Obtenir les dades dels empleats que tenen el salari més alte del seu departament.
Seleccionar els departaments que comencen per R que no tinguin empleats.
Selecciona els departaments en els que hi hagi persones amb noms que comencen per la lletra A.
Seleccionar aquells departaments que tinguin empleats que hagin finalitzat el seu contracte a l'any 1996
