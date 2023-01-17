/* Operadors de comparació*/

Select employee_id, last_name
from employees 
where salary < 10000;

Select employee_id, last_name
from employees 
where job_id= 'IT_PROG';


Select employee_id, last_name
from employees 
where last_name !='Smith';

/*Predicats de comparació*/
--Between

Select employee_id, last_name
from employees 
where salary between 10000 and 24000;

Select employee_id, last_name
from employees 
where salary  10000 is distinct 24000; /*no és igual, es tracta nul com un valor ordinari*/

Select employee_id, last_name, commission_pct
from employees 
where  commission_pct is null;

/*Funcions i operadors matemàtics*/
Select salary + 1000 as "salary+1k"
from employees;

Select salary *1.10 as "salary+10%"
from employees;

select salary as "parell"
from employees
where salary%2=0;

Select !!5 as "Factorial 5" and 5! as "Factorial 5";

/*Funcions matemàtiques*/

select abs(salary*-1) from employees;
Select cbrt(27.0) as "potència de 3";
Select ceil(-42.8);  --> return -42
select ceil (42.8); --> return 43
ceiling(-95.3)s
select degrees(0.5); --> radianes a grados
select div(9,4); --> divisió entera
select exp(1.0) --> Exponencial
select factorial(5); --> Factorial
select floor(-42.8); --> return - 43
select floor(42.8); --> return - 42
select ln(2.0) --> Logaritme neperia
select log(100.0); --> Logatitme base 10
select log10(100.0); --> Logaritme base 10
select log(2.0, 64.0); --> Logaritme a base

Select select salary as "parell"
from employees
where mod(salary,2)=0;

select pi(); 
Select power(9.0, 3.0)--> Potència
Select radians(45.0) --> Càlcul radians

select round (salary*1.21,2), salary*1.21+0.126763 
from employees;

select round (salary*1.21,2),scale(salary*1.21+0.126763), salary*1.21+0.126763 
from employees; --> Scale mostra la quantitat de digits decimals

select sign(-8.4); --> -1
Select sqrt(2.0); --> potència de 2
select trunc(42.8); --> retorna 42

select round (salary+0.8976,2), trunc((salary*1.21+0.126763),2)
from employees;

/*Funcions de cadenes*/

select employee_id||last_name from employees;
select employee_id||'*'||last_name from employees;
select concat(first_name,concat('*', last_name)) from employees;
select bit_length (last_name), char_lenght (last_name), octet_length(last_name) from employees;
select lower(last_name), upper (last_name), initcap(last_name), last_name from employees;
select overlay(last_name placing '****' from 2 for 4), last_name from employees;
Select position('a' in last_name), last_name from employees;
/*Position ens diu en quina posició és troba el caràcter. Si es repeteix el caràcter a la cadena, ens dona la posició de la primera.
Exemple */
Select position('a' in 'Pragma') el resultat serà 3
select substring(last_name from 2 for 3), last_name from employees;
/*Substring i substr és el mateix, però són maneres diferents de representar-les*/
select substr(last_name, 2,2), last_name from employees; /* extreu una cadena de last_name. Posició 2, 2 caràcters. 
Exemple substr('pere', 2, 2) extreu er; 
substr('matematiques', 3, 4) extreu tema;*/
select substring(last_name from '..$'), last_name from employees;
select substring(last_name from '%#"o_i#"%' for '#'), substring(last_name from '#"o_i#"%' for '#'),last_name from employees;
select trim(last_name from '%#"o_i#"%' for '#'), substring(last_name from '#"o_i#"%' for '#'),last_name from employees;
select trim(both 'ytn' from last_name), last_name from employees;
select lenght (last_name), last_name from employees;
select left(last_name, 2), right(last_name, 2), last_name from employees;
select lpad(last_name, 12, '*'), rpad(last_name, 12, '*'), last_name from employees;
select translate(last_name, 'a', '*'), last_name from employees;

/*format %[position][flags][width]type*/


SELECT format('|%10s|', last_name), last_name from employees;
SELECT format('|%-10s|', last_name), last_name from employees;
SELECT format('|%*s|', 10, last_name), last_name from employees;
SELECT format('|%*s|', -10, last_name), last_name from employees;
SELECT format('|%-*s|', 10, last_name), last_name from employees;
SELECT format('|%-*s|', -10, last_name), last_name from employees;


SELECT
    FORMAT('%s, %s',last_name, first_name) full_name
FROM
    employees
ORDER BY
    full_name;
	
	SELECT
    FORMAT('%10s, %-10s',last_name, first_name) full_name
FROM
    employees
ORDER BY
    full_name;
	
SELECT
    FORMAT('%1$s cognom, %2$s nom', last_name, first_name) from employees;

/*Patrons de cerques*/
select last_name 
from employees
Where last_name like 'Ab';

select last_name 
from employees
Where last_name like 'A%';


select last_name 
from employees
Where last_name like '_b_';

/*SIMILAR*/
/*L´operador SIMILAR TO torna cert si el seu patró coincideix amb la cadena donada, altrament retorna fals. 
És similar a l´operador LIKE, excepte que interpreta el patró utilitzant la definició de l´estàndard SQL d´una expressió regular*/

/*L'operador SIMILAR TO només té èxit si el seu patró coincideix amb tota la cadena; això és diferent del comportament habitual d'expressions regulars on el patró pot coincidir amb qualsevol part de la cadena. 
	Utilitza _ i % com a caràcters comodí que denota qualsevol caràcter únic i qualsevol cadena. 
	SIMILAR TO suporta metacaràcters de coincidència de patrons d'expressions regulars: 
		| denota alternança (una de dues alternatives). 
		* denota la repetició de l'element anterior zero o més vegades. 
		+ indica la repetició de l'ítem anterior una o més vegades. 
		? denota la repetició de l'element anterior zero o una vegada. 
		{m} indica la repetició de l'element anterior exactament m vegades. 
		{m,} indica la repetició de l'ítem anterior m o més vegades. 
		{m,n} denota la repetició de l'ítem anterior com a mínim m i no més de n vegades. 
 		Els parèntesis () es poden utilitzar per agrupar elements en un únic element lògic.
		Una expressió de claudàtor [...] especifica una classe de caràcter, com en les expressions regulars POSIX.*/
		
/*	'xyz' SIMILAR TO 'xyz'      true
	'xyz' SIMILAR TO 'x'        false
	'xyz' SIMILAR TO '%(y|a)%'  true
	'xyz' SIMILAR TO '(y|z)%'   false*/

SELECT country_name
FROM countries
WHERE country_name SIMILAR TO 'M%'='t';

SELECT country_name
FROM countries
WHERE country_name SIMILAR TO 'Italy'='t';

/*Si volem extreure les files que contenen el nom_país acabant amb la lletra "y" o "l" de la taula de països, es pot utilitzar la següent declaració.*/
SELECT country_name
FROM countries
WHERE country_name SIMILAR TO '%(y|l)'='t';

/*Si volem extreure les files que contenen el nom_país amb la lletra 'k' o 'y' en qualsevol posició de la taula de països , es pot utilitzar la següent declaració.*/

SELECT country_name
FROM countries
WHERE country_name SIMILAR TO '%(k|y)%'='t';


select last_name 
from employees
Where last_name similar to 'A';

select last_name 
from employees
Where last_name similar to '%(c|a)%';

select last_name 
from employees
Where last_name similar to '(c|a)%';

select last_name 
from employees
Where last_name similar to '(c|a)%';

SELECT regexp_match(last_name, '.*en'), last_name from employees;
SELECT regexp_match(last_name, '.*en.*'), last_name  from employees;
SELECT regexp_match(last_name, '.*en.*'), last_name from employees;
SELECT regexp_match(last_name, '^A.*'), last_name from employees;
SELECT regexp_match(last_name, 'an$'), last_name from employees;

/*Funcions format per dates*/
current_timestamp; current_date

select to_char (hire_date, 'HH12:MI:SS') as "12",  to_char (hire_date, 'HH24:MI:SS') as "24H", hire_date from employees;

Select to_char (hire_date, 'YYYY'), to_char (hire_date, 'YY') hire_date from employees;

Select to_char (hire_date, 'MONTH'),to_char (hire_date, 'Month'), to_char (hire_date, 'MON'),to_char (hire_date, 'Mon'),to_char (hire_date, 'MM'), hire_date from employees;

select to_char (hire_date, 'DAY') as "full upper case day name", to_char (hire_date, 'DY') as "abbreviated upper case day name",to_char (hire_date, 'DDD') as "day of year (001-366)" ,to_char (hire_date, 'DD') as "day of month (01-31)", to_char (hire_date, 'D') AS "day of the week, Sunday (1) to Saturday (7)", to_char (hire_date, 'ID') AS "day of the week, Monday (1) to Sunday (7)", hire_date from employees;

select to_char (hire_date, 'W') as "week of month (1-5)",to_char (hire_date, 'WW') as "week number of year (1-53)", to_char (hire_date, 'Q') as "Trimestre", hire_date from employees;

select to_char (hire_date, 'RM') as "month Roman numerals",to_char (hire_date, 'TZH') as "time-zone hours" ,to_char (hire_date, 'OF') as "time-zone offset from UTC", hire_date from employees;

select to_timestamp('05 Dec 2000', 'DD Mon YYYY');
select to_DATE ('05 Dec 2000', 'DD Mon YYYY');

/*conversió number to char*/
select lpad(cast (salary as text),15,'$') from employees;
select lpad(to_char(salary,'fm9999999.099'),15,'$') from employees;

/*Operadors de data i temps*/

select hire_date + 7, hire_date from employees;
select current_timestamp + '1 hour', current_timestamp;
select hire_date + time '03:00', hire_date from employees;

/*Funcions de temps*/

select age (timestamp '2001-04-10', timestamp '1974-08-01');
select age (current_timestamp, timestamp '1974-08-01');
select extract (year from hire_date), hire_date from employees;
select extract (century from hire_date) as "century", extract (day from hire_date) as "day", extract (decade from hire_date) as "decade",
extract (dow from hire_date) as "day of the week", extract (doy from hire_date) as "day of the year", extract (epoch from hire_date) as "Timestamp", extract (hour from hire_date) as "hour", extract (month from hire_date) as "month", extract (quarter from hire_date) as "timestre", hire_date from employees;

/*Conditional Expressions*/
--Case
select employee_id, 
case when employee_id=100 then (select last_name from employees where employee_id=100)
	 when employee_id=120 then (select last_name from employees where employee_id=120)
	 else 'other'
end
from employee;

--Coalesce

select coalesce(commission_pct, 0), commission_pct from employees;
















