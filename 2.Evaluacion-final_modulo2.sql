# EVALUACIÓN FINAL: BBDD SAKILA 
-- Comenzamos utilizando USE para usar la BBDD Sakila

USE `sakila`; 

-- 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.
-- Utilizamos DISTINCT para que nos devuelva valores únicos, SIN DUPLICADOS.
SELECT DISTINCT `title` AS `Título`
	FROM `film`
	; 
-- Sacamos la opción asociándolo a film_id
SELECT DISTINCT `title`, `film_id`
	FROM `film`
	;     
    
-- 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".
-- Establecemos una condición con WHERE para que nos devuelva solo aquellas con esta condición. Usamos rating(clasificacion) donde sea igual a PG-13. 
SELECT `title` AS `Título`
	FROM `film`
	WHERE `rating` = 'PG-13'
	; 
        
-- 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.
-- Establecemos la condición con LIKE donde buscamos que nos devuelvan aquellas películas que cumplan la condición siguiendo este patrón. Usamos LIKE %amazing% donde buscamos que la descripcion de la pelicula contenga amazing, puede estar en cualquier parte de la descripcion.
SELECT `title` AS `Título`, `description` AS `Descripción`
	FROM `film`
	WHERE `description` LIKE '%amazing%'
	; 

-- Comprobamos que el resultado de la consulta es correcto sacando de esta vez también la descripción de las películas y comprobar el resultado. 
SELECT `film_id`,`title`, `description`
	FROM `film`
	WHERE `description` LIKE '%amazing%'
	; 
        
-- 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.
-- Establecemos condición para que nos devuelva los datos que cumplen la misma. En este caso en la condición WHERE utilizamos la columna `lenght` que es la duración de las mismas donde deberá sacarnos como resultado aquellas mayores de 120. 
SELECT `title` AS `Título`
	FROM `film`
	WHERE `length` > 120
	; 
    
-- 5. Recupera los nombres de todos los actores.
-- Una consulta simple, especificamos en el SELECT lo que queremos que nos devuelva en este caso 'first_name' al cual le ponemos el alias `Nombres`.
SELECT `first_name` AS `Nombres`
	FROM `actor`
    ;
-- Si quisiéramos que nos devolviera nombre y apellidos sería como ocurre en la siguiente consulta. 
SELECT `first_name`, `last_name`
	FROM `actor`
    ; 
    
-- 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.
-- Utilizamos Like para que la consulta nos devuelva nombre y apellidos que cumplan la condición.
-- Especificamos el patrón en el declaramos que CONTENGA en el apellido 'Gibson', no es irrelevante la posición en este caso. Debemos tener en cuenta que no se tiene en cuenta si comienza mayúsculas o minúsculas por lo que este detalle no repercute en el resultado. 
SELECT `first_name` AS `Nombre`, `last_name` AS `Apellido`
	FROM `actor`
		WHERE `last_name` LIKE '%Gibson%'
        ; 

-- Con esta query nos ayudamos para comparar y comprobar que la consulta anterior se realizó de forma correcta. 
SELECT `first_name` AS `nombre`, `last_name` AS `apellido`
	FROM `actor`
    ; 

-- 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.
-- Utilizamos en la condición WHERE: Between para que nos devuelvan los id's de actores que se encuentren 'entre' (between) 10 y (AND) 20. 
SELECT `first_name` AS `Nombre`
	FROM `actor`
	WHERE `actor_id` BETWEEN 10 AND 20
	; 

-- Comprobamos que la consulta anterior es correcta utilizando actor_id en esta query para ver si corresponde
SELECT `first_name` AS `Nombre`, `actor_id`
	FROM `actor`
	WHERE `actor_id` BETWEEN 10 AND 20
	; 

-- 8. Encuentra el título de las películas en la tabla `film` que no sean ni "R" ni "PG-13" en cuanto a su clasificación.
-- Establecemos condicion en WHERE con NOT IN para filtrar las filas de rating en función de que los valores especificados dentro del paréntesis no estén presentes en el resultado de la query.
SELECT `title` AS `Título`
	FROM `film`
		WHERE `rating` NOT IN ('R' AND 'PG-13')
;
-- Con esta query comprobamos que la consulta es correcta comprobando que la clasificacion (rating) sea según se especifica en la condición. 
SELECT `title` AS `Título`, `rating`
	FROM `film`
	WHERE `rating` NOT IN ('R','PG-13')
	;

-- 9. Encuentra la cantidad total de películas en cada clasificación de la tabla `film` y muestra la clasificación junto con el recuento.
-- Para lograr la cantidad total de películas según cada clasificación (rating) utilizaremos COUNT, gracias a este último la consulta nos devolverá el número de filas total de la columna rating
SELECT COUNT(`rating`) AS `Total_peliculas`, `rating` AS `Clasificación`
	FROM `film`
	GROUP BY `rating`
	;
    
-- 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
-- Especificamos en el select lo que queremos que nos devuelva la consulta y añadimos sus respectivos alias para mejor entendimiento al realizar el ejercicios y mayor claridad al ver el resultado de la consulta. 
-- Utilizamos INNER JOIN para unir las tablas 'customer' y 'rental'. Al realizar un JOIN debemos hacer con ON igualar la columna en común de las respectivas tablas para poder asociarlas. 
-- Como en el SELECT estamos haciendo un COUNT (explicado en el ejercicio anterior) debemos siempre añadir un GROUP BY. Con él especificamos cómo queremos que se agrupen los resultados de la query. 
SELECT `c`.`customer_id` AS `ID_cliente`, `c`.`first_name` AS `Nombre`, `c`.`last_name` AS `Apellido`, COUNT(`inventory_id`) AS `Peliculas_alquiladas`
	FROM `customer` AS `c`
		INNER JOIN `rental` AS `r`
        ON `c`.`customer_id` = `r`.`customer_id`
        GROUP BY `c`.`customer_id`
		;
		
-- 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
-- En este ejercicio utilizamos INNER JOIN para asociar las tablas 'film', 'inventory', 'rental', 'film_category' y 'category' para lograr que la query nos devuelva el nombre de la categoría y el total de peliculas alquiladas usando en esta ultiuma situacion un COUNT. 
SELECT `c`.`name` AS `Nombre_categoría`, COUNT(`r`.`inventory_id`) AS `Peliculas_alquiladas`
	FROM `film` as `f`
		INNER JOIN `inventory` AS `i` 
		ON `f`.`film_id` = `i`.`film_id`
        
			INNER JOIN `rental` AS `r`
			ON `i`.`inventory_id` = `r`.`inventory_id`
			
				INNER JOIN `film_category` AS `fc`
				ON `f`.`film_id` = `fc`.`film_id` 
                        
					INNER JOIN `category` AS `c` 
					ON `fc`.`category_id` = `c`.`category_id`
					GROUP BY `c`.`name`
					; 
-- En el group by se agruparán los resultados acordes al nombre de la clasificación procedente de la tabla 'category'. 

-- 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla `film` y muestra la clasificación junto con el promedio de duración.
-- La duración promedio la conseguiremos con AVERAGE (AVG) que nos dará la media de 'length' (duracion de las peliculas). Como especificamos anteriormente SIEMPRE utilizamos GROUP BY en queries avanzadas. Agrupamos por rating(clasificacion)
SELECT `rating` AS `Clasificación`, AVG(`length`) AS `Duración_promedio`
	FROM `film`
    GROUP BY `rating`
	; 

-- 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".
-- En el select especificamos que es lo que queremos que nos devuelva la consulta. Conectamos las tablas ACTOR, FILM_ACTOR y ACTOR para lograr extraer los datos concretos que necesitamos con INNER JOIN
-- Además de esto establecemos la condición con 'title' que corresponde a la tabla 'film'. La consulta nos devolverá solo aquellas que cumplan la condición. 
SELECT `first_name` AS `Nombre`, `last_name` AS `Apellido`
	FROM `actor` AS `a`
    INNER JOIN `film_actor` AS `fa`
		ON `a`.`actor_id` = `fa`.`actor_id`
			INNER JOIN `film` AS `f`
				ON `f`.`film_id` = `fa`.`film_id`
				WHERE `title` = 'Indian Love'
				;

-- 14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.
-- Como hicimos en ejercicio 6 repetimos el mismo proceso donde le damos dos condiciones, no debe cumplir ambas al utilizar OR si quisiéramos que cumplieran ambas utilizariamos AND.
SELECT `title` AS `Título`
	FROM `film`
    WHERE `description` LIKE '%dog%' OR '%cat%'
	; 
-- Comprobamos que el resultado de la query es correcto comprobando la descripcion. 
SELECT `title` AS `Título`, `description`
	FROM `film`
    WHERE `description` LIKE '%dog%' OR '%cat%'
	; 

-- 15. Hay algún actor o actriz que no apareca en ninguna película en la tabla `film_actor`.
-- En esta consulta utilizamos NOT IN y realizamos una subconsulta. En la consulta principal logramos actor_id de la tabla ACTOR cuya condicion con NOT IN nos devolverá
-- como resultado de la subconsulta los registros (actor_id) que NO están presentes en la tabla film_actor. 
SELECT `actor_id`
	FROM `actor`
    WHERE `actor_id` NOT IN ( SELECT `actor_id`
								FROM `film_actor`)
	; 
-- Otra forma de realizar la consulta es unir la tabla ACTOR y FILM_ACTOR con LEFT JOIN cuyo elemento común que relaciona ambas tablas es actor_id.
-- Y añadimos la condición de que actor_id procedente de la tabla film_actor sea NULO, con ello queremos decir que no está presente de igual forma que hicimos antes con NOT IN. 
SELECT `a`.`actor_id`
	FROM `actor` AS `a`
		LEFT JOIN `film_actor` AS `fa`
		ON `a`.`actor_id` = `fa`.`actor_id`
		WHERE `fa`.`actor_id` IS NULL
		;

-- 16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.
-- En esta consulta se realiza de forma sencilla estableciendo la condición con WHERE 'release_year' y between para especificar la franca de años que queremos consultar. 
SELECT `title`
	FROM `film`
		WHERE `release_year` BETWEEN 2005 AND 2010
		;  

-- Comprobamos el resultado de la query: 
SELECT `title`, `release_year`
	FROM `film`
		WHERE `release_year` BETWEEN 2005 AND 2010
		;  

-- 17. Encuentra el título de todas las películas que son de la misma categoría que "Family".
-- Unimos tabla film, film_category y category con INNER JOIN. Debemos tener en cuenta que en algunos ejercicios como este, debemos conectar varias tablas unas a otras para acceder a los datos que necesitamos que nos devuelva la query.
-- La condición será segun el nombre de la clasificacion sea Family. 
SELECT `f`.`title`, `c`.`name`
	FROM `film` AS `f`
		INNER JOIN `film_category` AS `fc`
		ON `f`.`film_id` = `fc`.`film_id` 
			INNER JOIN `category` AS `c`
            ON `c`.`category_id` = `fc`.`category_id`
				WHERE `name` = 'Family' 
				; 
    
-- 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.
-- Utilizamos LEFT JOIN para unir la tabla actor y film_actor cuyo elemento común es actor_id. Utilizamos en el select un DISTINTC para evitar duplicados. 
-- Agrupamos con GROUP BY actor_id procedente de la tabla de actores y establecemos condicion. Al tener un GROUP BY, en vez de WHERE siempre usaremos HAVING (funciona igual que un WHERE).
SELECT DISTINCT `first_name` AS `Nombre`, `last_name` AS `Apellido`
	FROM `actor` AS `a`
		LEFT JOIN `film_actor` AS `fa`
		ON `a`.`actor_id` = `fa`.`actor_id`
        GROUP BY `a`.`actor_id`
		HAVING COUNT(`fa`.`film_id`) > 10
		;

-- 19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla `film`.
-- Ejercicio similar a realizados anteriormente, en este caso usamos AND es decir, nos devolverá los registros que cumplan AMBAS condiciones.  
SELECT `title` AS `Título`
	FROM `film` 
	WHERE `rating` = 'R' AND `length` > 120
	; 

-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración.
-- Queremos extraer con la consulta el promedio de duracion  de las películas, utilizaremos nuevamente AVERAGE. Debemos relacionar las tablas film, film_category(funciona como un puente para conectar con la tabla category)
-- Una vez conectadas las tablas relacionando con sus respectivos elementos comunes, debes agrupar con GROUP BY con el nombre de la categoría procedente de la tabla category. 
-- Establecemos condicion con HAVING ya que tenemos un GROUP BY, por eso no usaremos un WHERE. 
SELECT `c`.`name` AS `Nombre_categoría`, AVG(`length`) AS `Duración_promedio`
	FROM `film` AS `f`
		INNER JOIN `film_category` AS `fc`
		ON `f`.`film_id` = `fc`.`film_id` 
			INNER JOIN `category` AS `c`
            ON `c`.`category_id` = `fc`.`category_id`
			GROUP BY `c`.`name`
            HAVING AVG(`length`) > 120 
			; 


-- 21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas en las que han actuado.
-- Seleccionamos los nombres (first_name) de los actores y contamos con COUNT el número de películas en las que han actuado.
--  Agrupamos los resultados por el actor_id para contar el número de películas en las que ha actuado cada actor y con HAVING filtramos los resultados para incluir solo aquellos actores que han actuado en al menos 5 películas.
SELECT `first_name` AS `Nombre`, COUNT(`fa`.`film_id`) AS `Cantidad_peliculas`
	FROM `actor` AS `a`
		INNER JOIN `film_actor` AS `fa`
			ON `a`.`actor_id` = `fa`.`actor_id`
            GROUP BY `a`.`actor_id`
			HAVING COUNT(`fa`.`film_id`) >= 5
			; 

-- 22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes.
-- Seleccionamos el título de las películas y filtramos las películas que tienen un film_id que está presente en la subconsulta.
-- Con el operador IN comparamos el film_id de la tabla film con los film_id que nos devuelve la subconsulta.
-- La subconsulta nos devuelve los film_id de la tabla inventory cuya duración del alquiler (rental_duration) es mayor que 5.
-- Unimos las tablas rental e inventory para obtener los alquileres y los inventarios y también unimos las tablas inventory y film para obtener los detalles de las películas.
-- Utilizamos DISTINCT para asegurarnos de que no haya duplicados en los film_id.

SELECT `title` AS `Título`
	FROM `film` AS `f`
    WHERE `film_id` IN(	SELECT DISTINCT `i`.`film_id`
						FROM `rental` AS `r`
							INNER JOIN `inventory` AS `i`
							ON `i`.`inventory_id` = `r`.`inventory_id`
								INNER JOIN `film` AS `F`
								ON `F`.`film_id` = `i`.`film_id`
								WHERE `rental_duration` > 5)
								; 
                                
-- Comprobamos que lo hemos realizado correctamente añadiendo en esta consulta de comprobacion rental_duration para comprobar que cumplen las condiciones establecidas:
SELECT `title` AS `Título`, `rental_duration`
	FROM `film` AS `f`
    WHERE `film_id` IN(	SELECT DISTINCT `i`.`film_id`
									FROM `rental` AS `r`
										INNER JOIN `inventory` AS `i`
										ON `i`.`inventory_id` = `r`.`inventory_id`
											INNER JOIN `film` AS `F`
                                            ON `F`.`film_id` = `i`.`film_id`
											WHERE `rental_duration` > 5)
											; 

-- 23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego exclúyelos de la lista de actores.
-- Seleccionamos los nombres y apellidos de los actores de forma única y usamos DISTINCT para eliminar duplicados.
-- Con NOT IN en la condición WHERE seleccionamos los actores cuyos actor_id NO están presentes en la subconsulta.
-- En la subconsulta nos devolverá los actor_id de la tabla film_actor para los cuales las películas están asociadas con la categoría "Horror".
-- Se unen las tablas film_actor, film, film_category, y category con INNER JOIN para obtener los actores que han actuado en películas de la categoría "Horror".

SELECT DISTINCT `first_name`AS `Nombre`, `last_name` AS `Apellido`
		FROM `actor` AS `a`
		WHERE `a`.`actor_id` NOT IN ( SELECT `fa`.`actor_id`
										FROM `film_actor` AS `fa`
											INNER JOIN `film` AS `f`
                                            ON `fa`.`film_id` = `f`.`film_id`
												INNER JOIN `film_category` AS `fc`
												ON `f`.`film_id` = `fc`.`film_id` 
													INNER JOIN `category` AS `c`
													ON `c`.`category_id` = `fc`.`category_id`
													WHERE `c`.`name` = 'Horror'
													); 

## BONUS
-- 24. BONUS: Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla `film`.
-- Este ejercicio se puede realizar de dos maneras: La primera es más sencilla uniendo las tablas film_category y category con INNER JOIN. Establecemos la condición este caso usamos AND ya que debe cumplir DOS CONDICIONES. 
SELECT `f`.`title`
	FROM `film` AS `f`
		INNER JOIN `film_category` AS `fc`
		ON `f`.`film_id` = `fc`.`film_id` 
			INNER JOIN `category` AS `c`
			ON `c`.`category_id` = `fc`.`category_id`
			WHERE `c`.`name` = 'comedy' AND `f`.`length` > 180 
			; 
-- En este caso lo logramos haciendo una subconsulta:
-- La consulta principal es seleccionando el titulo procedente de la tabla film. En la subconsulta extraemos film_id cuyo nombre cumppla con las condiciones del where son dos, por ello usamos AND como en el ejercicio anterior. 
-- La conusulta nos devolverá aquellos titulos de peliculas cuyo film_id esté en lo que nos devuelva la subconsulta. 
SELECT `title`
	FROM `film` AS `f`
    WHERE `f`.`film_id` IN ( SELECT `fc`.`film_id`
							FROM `film_category` AS `fc`
								INNER JOIN `category` AS `c`
								ON `c`.`category_id` = `fc`.`category_id`
								WHERE `c`.`name` = 'comedy' AND `f`.`length` > 180); 
                                
-- 25. BONUS: Encuentra todos los actores que han actuado juntos en al menos una película. La consulta debe mostrar el nombre y apellido de los actores y el número de películas en las que han actuado juntos.
SELECT *
FROM `actor`; 
-- En esta consulta seleccionamos resultados datos combinando columnas. Queremos ver que actor1 y actor2 que hayan coincidido en al menos una pelicula y cuantas. 
-- a1 y a2 son alias para la tabla actor y fa1 y fa2 son alias para la tabla film_actor, que representan dos instancias de la misma tabla. 
-- Usamos INNER JOIN para combinar las tablas actor, film_actor y film. Con ON especificamos las condiciones que relacionan las tablas.
-- Establecemos con WHERE la condición para incluir solo aquellos en los que el actor_id de a1 es menor que el actor_id de a2, asegurando que no se cuenten las mismas combinaciones de actores más de una vez.
-- Agrupa los resultados por los actor_id de a1 y a2 con GROUP BY. 
-- También hemos usado COUNT(*) para extraer el numero de filas para cada grupo, lo que indica cuántas películas han compartido los actores.

SELECT DISTINCT `a1`.`first_name` AS `Nombre1`, `a1`.`last_name` AS `Apellido1`, `a2`.`first_name` AS `Nombre2`, `a2`.`last_name` AS `Apellido2`, COUNT(*) AS `Peliculas_comunes`
	FROM `actor` AS `a1`
		INNER JOIN `film_actor` AS `fa1`
		ON `a1`.`actor_id` = `fa1`.`actor_id`
        
			INNER JOIN `film` AS `f`
			ON `fa1`.`film_id` = `f`.`film_id`
            
				INNER JOIN `film_actor` AS `fa2`
				ON `fa2`.`film_id` = `f`.`film_id`
				
					INNER JOIN `actor` AS `a2`
					ON `a2`.`actor_id` = `fa2`.`actor_id`
				
					WHERE `a1`.`actor_id` < `a2`.`actor_id`
					GROUP BY `a1`.`actor_id`, `a2`.`actor_id`
                    ;
				


