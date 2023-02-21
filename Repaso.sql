
/* Crea casos especiales para cada WHEN */
SELECT employee_id,
    CASE WHEN employee_id=100 then  (SELECT last_name from employees where employee_id=100)
         WHEN employee_id=120 then  (SELECT last_name from employees where employee_id=120)
        else 'other'
    END
FROM employees;

/* Cuando necesitamos informacion que esta en otra tabla, podemos usar subconsultas */
SELECT last_name FROM employees
WHERE job_id in (Select job_id from employees WHERE last_name like 'Smith')
order by last_name;


/* Se existe el registro muestra su nombre y su id del departamento que tengan asignado un empeado*/
SELECT department_name, department_id FROM departments
WHERE EXISTS( select * FROM employees
              where employees.department_id = departments.department_id)
order by department_id ;

SELECT * FROM employees WHERE  salary < all (select salary from employees where department_id=30);

/* Doble subconsultas */
SELECT last_name, first_name
FROM employees
WHERE department_id in (SELECT department_id
                        FROM departments
                        WHERE location_id IN (SELECT location_id
                                              FROM locations
                                              WHERE city IN ('Seattle','Roma')));

/* Combinación de tablas */
SELECT e.last_name, e.first_name, e.job_id, d.location_id FROM employees e, departments d
WHERE e.department_id=d.department_id;

/* Usando JOIN para combinar tablas */
SELECT e.employee_id, e.first_name, e.last_name, e.department_id, d.department_name
FROM employees e
JOIN departments d on d.department_id = e.department_id
WHERE lower(d.department_name) like 'i%' or lower(d.department_name) like 'sh%';

SELECT sum(salary) FROM employees;

/* Salario medio de cada departamento  de la tabala emplyee */
SELECT  d.department_name, e.department_id, round(avg(salary),2) AS "MEDIA SAlARY"
FROM employees e
JOIN departments d on d.department_id = e.department_id
GROUP BY e.department_id, d.department_id
ORDER BY e.department_id;
--WHERE d.department_id = e.department_id;
/* Agrupa los departamentos iguales con la funcion count */
SELECT department_id, count(*)
FROM employees
GROUP BY department_id
HAVING count(*) >4;

SELECT department_id, job_id, count(*)
FROM employees
GROUP BY department_id, job_id
