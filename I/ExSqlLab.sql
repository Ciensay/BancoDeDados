
--Q1
SELECT name, year
FROM movies
WHERE year BETWEEN 1960 AND 1969
ORDER BY year;

--Q2
SELECT a.first_name, a.last_name, r.role
FROM actors a, roles r
WHERE a.actor_id = r.actor_id AND a.gender = 'F'
ORDER BY a.first_name, a.last_name, r.role;

--Q3
SELECT m.name, a.first_name, a.last_name, r.role
FROM movies m, roles r, actors a
WHERE m.movie_id = r.movie_id AND r.actor_id = a.actor_id AND m.year > 2000
ORDER BY m.name;

--Q4
SELECT m.name AS titulo, g.name AS genero
FROM movies m, movies_genres mg, genres g
WHERE m.movie_id = mg.movie_id AND mg.genre_id = g.genre_id AND (g.name = 'Romance' or g.name = 'Comedy');

--Q5
SELECT m.name, m.rank, d.first_name, d.last_name
FROM movies m, movies_directors md, directors d
WHERE m.movie_id = md.movie_id AND md.director_id = d.director_id AND m.rank > 8
ORDER BY m.rank;

--Q6
SELECT a.first_name, a.last_name, a.gender
FROM actors a, roles r
WHERE a.actor_id = r.actor_id AND r.role LIKE '%Kid%';

--Q7
SELECT a1.first_name AS nome_ator1, a2.first_name AS nome_ator2, a1.last_name AS sobrenome
FROM actors a1, actors a2
WHERE a1.last_name = a2.last_name AND a1.actor_id < a2.actor_id;

--Q8
SELECT first_name, last_name
FROM actors
WHERE last_name LIKE 'M%';

--Q9
SELECT name
FROM actors a, movies m, roles r
WHERE a.actor_id = r.actor_id AND m.movie_id = r.movie_id AND r.role LIKE '%Narrator%';

--Q10
SELECT last_name, role
FROM actors a, roles r
WHERE a.actor_id = r.actor_id AND r.role LIKE '%SOLDIER%';

--Q11
SELECT a.first_name, a.last_name, r.role
FROM actors a, roles r, directors d, movies_directors md
WHERE d.last_name = 'Cameron' AND d.director_id = md.director_id AND md.movie_id = r.movie_id AND r.actor_id = a.actor_id;

--Q12
SELECT a.first_name, a.last_name, r.role, m.name, m.year, d.first_name, d.last_name, dg.prob
FROM actors a, roles r, movies m, directors d, directors_genres dg, movies_genres mg, genres g, movies_directors md
WHERE a.actor_id = r.actor_id 
  AND (r.role LIKE 'Himself%' OR r.role LIKE 'Herself%') 
  AND r.movie_id = m.movie_id 
  AND m.movie_id = mg.movie_id 
  AND mg.genre_id = g.genre_id
  AND g.name = 'Documentary' 
  AND m.movie_id = md.movie_id 
  AND md.director_id = d.director_id 
  AND d.director_id = dg.director_id 
  AND dg.genre_id = g.genre_id;