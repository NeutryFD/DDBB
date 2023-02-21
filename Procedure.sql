DO $$
    DECLARE
    name varchar ;
    BEGIN
        FOR name IN SELECT first_name FROM employees LOOP
        RAISE NOTICE  'EL nombres es: %',upper(name);
        END LOOP;
    END $$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE rang_1(v_max numeric) LANGUAGE plpgsql AS $$
        BEGIN
            IF v_max < 0 THEN
            RAISE NOTICE 'ERROR';
            ELSE
                FOR i IN 1..v_max LOOP
                    RAISE NOTICE '%',i;
                END LOOP;
            END IF;
        END$$;

CALL rang_1(:h);

CREATE OR REPLACE FUNCTION duplicar_cantidad ( v INTEGER) RETURNS INTEGER AS $$
    DECLARE
        v_result INTEGER;
        BEGIN
           v_result = v*2;
        RETURN (v_result);
        END $$ LANGUAGE plpgsql;

DO $$
    BEGIN
        RAISE NOTICE '%',duplicar_cantidad(:cantidad);
    END $$;

CREATE OR REPLACE PROCEDURE IMPRIMIR(mn numeric,mx numeric, salto numeric) LANGUAGE plpgsql AS $$
    BEGIN
        WHILE mn <= mx LOOP
            mn = mn + salto;
            RAISE NOTICE '%',mn;
        END LOOP;
    END $$;

CREATE  OR REPLACE FUNCTION COMPROVAR_NEGATIVO(n1 numeric ,n2 numeric ,n3 numeric) RETURNS NUMERIC AS $$
    BEGIN
    IF n1 > 0 AND  n2 > 0 AND n3 > 0 THEN
        IF n1 < n2 THEN
            RETURN 0;
        END IF;
    END IF;
    RETURN 1;
    END $$ LANGUAGE plpgsql;

DO $$
    BEGIN
        IF COMPROVAR_NEGATIVO(:n1,:n2,:n3) = 0 THEN
            CALL IMPRIMIR(:n1,:n2,:n3);
        ELSE
            RAISE NOTICE 'ERROR';
        END IF;
    END $$ LANGUAGE plpgsql;


DO $$
    DECLARE
    e_id varchar;
    BEGIN
    SELECT first_name FROM employees ;


    END $$ LANGUAGE plpgsql;

SELECT * FROM employees;