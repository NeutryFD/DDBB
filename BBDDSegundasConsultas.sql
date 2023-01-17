select current_date as hora_actual;

select first_name, last_name, extract(years from age(current_date,hire_date))*12 + extract(month from age(current_date, hire_date))as Meses_trabajados
from employees;

--Dos maneras de concatenar dentro de las tablas
--select first_name ||' earns '||salary ||' ' ||'monthy and wants '|| salary*3 as Dream_Salary
select concat(first_name,' earns ',salary, ' monthy and wants ',salary*3) as Dream_Salary
from employees;

select  last_name,hire_date
from employees;

--Agregar contenido,los contenidos deben de ser del mismo tipo --> lpad o rpad
select lpad(cast(salary as text),15,'$') as SALARY
from employees;

/*Ejericio 5
Mostrar apellido y la fecha de contratacion y el dia de semana que comienza el empleado. Etiquitar
  la columna como DAY, ordenar los empleados por dia de la semana.
*/
select last_name, to_char(hire_date,'DAY') as DAY
from employees
order by to_char(hire_date,'ID') asc ;

/* 6)Consulta que mostri el cognom i les comissions dels empleats. Si un empleat no paga comissió, s’ha de posar “No Commission”.
   Recorda que has de tenir en compte el tipus de dada del camp, si commission_pct és numèric i “No commission” és alfanumèric,
   hauries de fer conversió (::text o ::int)
*/
select last_name, commission_pct
from employees
where commission_pct is null;

select last_name, coalesce(cast(commission_pct as text),'No Comisión') as Comision
from employees
order by last_name asc ;

/*Consulta que mostri el cognom dels empleats i que indiqui les quantitats dels seus salaris anuals amb asteriscs.
  Cada asterisc significa mil dòlars.  Ordenar les dades per salari en ordre descendent. Etiqueta la columna com a
  EMPLOYEES_AND_THEIR_SALARIES.*/

select last_name,replace(cast(salary as text),cast(salary as text),repeat('*', cast((salary/1000) as int))) as EMPLOYESS_AND_THEIR_SALARIES, round(salary/1000)
    from employees;

select to_char(salary,repeat('*',cast(salary/1000 as int))) from employees;



select to_char(salary)*'s' as signos from employees;
select  substring(last_name from '..$'), last_name from employees;

select trunc((salary *1.21+0.123213132),0)
from employees;
/*Mostra el nom i el sou dels empleats. Arrodoneix el salari a milers.*/
select round(salary),scale(salary)
from employees;


/*Mostra els empleats que vàrem ser contractats durant el mes de Maig.*/

select * from employees
where to_char(hire_date,'mont') = 'mayt' ;
select to_char(hire_date,'mont') from employees;

/*Mostra el nom i la data del primer salari dels empleats. Si un empleat va ser contractat el dia 15/01/2022 el
  seu primer salari serà l’últim dia del mes en el qual va ser contractat 31/01/2022.*/



/*Mostrar el nom i l'experiència (anys) dels empleats*/
select first_name, extract(years from age(hire_date)) + extract(month from age(hire_date))/12 as EXperience_in_Years from employees;


select  age(hire_date) from employees;
/*Mostra el nom dels empleats que vam ser contractats durant el 2001.*/

/*Mostra el nom i cognom dels empleats de tots els empleats. S'ha de mostrar amb la primera lletra en majúscules i
la resta en minúscules.*/
select first_name, last_name from employees;
select  concat(initcap(first_name),' ' ,lower(last_name)) as Nombres from employees;
/*Mostra la primera paraula de Job_title*/

select split_part(job_title,' ',1) from jobs;

/*Mostra la longitud del nom pels empleats que el seu cognom contingui un caràcter 'b' després de la tercera posició.*/
select length(first_name) as Longitud, first_name from employees
--where first_name like '___b%';
where position(first_name,'b') >3;
/*Mostra el nom en majúscules i adreça de correu electrònic en minúscules per als empleats on el nom i l'adreça de correu
  electrònic són iguals.*/
select upper(first_name), lower(email) from employees
where first_name = substr(email,1,position('@' in email));
select lower(email), lower(first_name), lower(last_name) from employees;

/*Mostra els empleats que han sigut contractats durant l'any actual*/
/*Mostra el nombre de dies entre la data del sistema i l'1 de gener de 2011.*/
select  extract(days from (current_date - timestamp'2011-01-01')) as Fecha_Actual;
select  extract(days from (current_date - timestamp'2011-01-01')) as Fecha_Actual;

/*Mostra el nombre d'empleats que han sigut contractats després del 15 de cada mes.*/
select first_name, hire_date from employees
where cast(to_char(hire_date,'DD')as int)>15;

select to_char(hire_date,'DD') from employees;
/*Mostra els empleats que han sigut contractats (hire_date) durant el mes de maig.
*/

/*Calcula la quantitat d'oficis (job_title) que hi ha a la taula employees.
*/
select  count(distinct job_title) from employees e, jobs j;
--where e.job_id = j.job_id;
/*Obté el cognom dels empleats de la taula EMPLOYEES de la següent manera: “El cognom és: last_name.” Per a això necessitem
  concatenar la cadena 'El cognom és: ' amb la columna COGNOM de la taula EMPLOYEES.
*/

select concat('El apellido es: ',last_name) as APELLIDO from employees;

/*Obté de la taula EMPLOYEES l'últim dia del mes per a cadascuna de les dates d'alta dels empleats del departament 10.*/
select to_char(hire_date,'month') from employees
where department_id = 10;

select department_id from employees
order by department_id asc;

/*A partir de la taula EMPLOYEES, obté la data d'alta (columna HIRE_DATA) formatada, de manera que aparegui el nom del mes
  amb totes les seves lletres (month), el nombre de dia de mes (dd) i l'any (yyyy), per a aquells empleats del departament 10.*/
select to_char(hire_date,'month')||'-'||to_char(hire_date,'dd')||'-'|| to_char(hire_date,'YYYY') from employees
where department_id=10;

