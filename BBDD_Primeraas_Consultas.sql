select employee_id, last_name, first_name
from employees
where first_name like '%a';

/* Cambia el nombre de la columna salary por "sal" */
SELECT last_name, job_id, salary AS sal
FROM employees;

/* la tabla de job_grades*/
SELECT *
FROM job_grades;

/*1--> Falta el comando AS para ANNUAL_SALARY y no debe de tener espacios
  2--> Para la operacin de multiplicar se usa el *
  3-->  La columna Sal no existe
  4--> Las comulumnas deben de separarse por una ,*/
SELECT employee_id, last_name,
Salary * 12 AS ANNUAL_SALARY
FROM employees;
/*Ejercicio 4*/
select  employee_id AS NumeroEmpleado, last_name, job_id, hire_date
from  employees;

/*Usamos el where para imprimir un rango*/
select employee_id
from employees
where employee_id between 150 and 160;
/*Muesta las coincidencias exactas que estan  dentro del  parentesis  */
select  employee_id
from employees
where employee_id in (150,160);

select *
from employees
where  employee_id in (150,160);

/*Mostra el cognom, salari, la comissió i la data de contractació dels
  empleats que tenen un salari inferior a 1000*/
/*Ningún empleado de la base cumple las condiciones*/
select last_name, salary, commission_pct, hire_date
from employees
where salary < 1000;

/*Mostrar per cada lloc de treball (job_title) la diferencia entre el salari màxim
i el salari mínim en una nova columna que s’esmenti “DIFFERENCE”, d’aquells pels qual
  el seu salari màxim estigui entre el rang 10000 a 20.000. Aquesta informació la pots
  trobar a la taula JOBS.*/
select job_title, (max_salary-min_salary) as Diference
from jobs
where  max_salary between 10000 and 20000;

/*Mostra la informació de la taula JOBS ordenada de manera descendent per títol.*/
select  *
from jobs
order by job_title desc;

/*Mostra els empleats els quals el seu nom o cognom comença per S*/
select *
from employees
where last_name like 'S%'; /* Es case sensitive*/

/*Mostra tota la informació de la taula empleats pels quals el percentatge de comissió és nul,
  el seu salari està entre 5000 i 10000 i el pertanyen al departament 30.*/
select *
from employees
where commission_pct is null and (salary between 5000 and 10000);

/*Per a cada empleat, visualitzar el seu número, cognom, salari i salari incrementat en el 15%*/
select employee_id, last_name, (salary*0.15) as "Incrementado 15%"
from employees;

/*Modifica la consulta de l’exercici anterior per afegir una columna que resti el salari antic del nou.
Etiquetar la columna com a Increase*/
select employee_id, last_name, (salary-(salary*0.15)) as "Incremento"
from employees;

/*Consulta que mostri els cognoms dels empleats amb la primera lletra en majúscules i totes la
resta en minúscules, així com la longitud del camp nom, per a tots els empleats on el nom
comença per J, A o M. Etiquetar les columnes com a Name i com a Length respectivament.
 */
select last_name from employees
where last_name like 'At%';


select first_name, salary from employees;

select first_name from employees
where commission_pct is null ;

select first_name, salary  from employees;

select * from jobs
where min_salary > 10000;

select first_name, hire_date from employees
where hire_date in (2002,2005);

select  hire_date from employees
order by hire_date desc ;

select department_name, first_name, hire_date
from departments c,employees e
where e.department_id = c.department_id and c.department_id in (80,60);

select department_name, first_name, hire_date
from  departments c join employees e on c.department_id = e.department_id
where c.department_id in (80,60);

select * from employees
where employee_id in (150,160);

