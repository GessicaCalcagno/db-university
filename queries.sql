-- 1. Selezionare tutti gli studenti nati nel 1990 (160)
SELECT * 
FROM `students`
WHERE YEAR (`date_of_birth`) = 1990;

-- 2. Selezionare tutti i corsi che valgono più di 10 crediti (479)
SELECT * 
FROM `courses`
WHERE `cfu` > 10;

-- 3. Selezionare tutti gli studenti che hanno più di 30 anni
SELECT * 
FROM `students` 
WHERE TIMESTAMPDIFF (YEAR, date_of_birth, CURDATE()) >= 30;

-- 4. Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di laurea (286)
SELECT * 
FROM `courses` 
WHERE `period` = "I semestre"
AND `year` = 1;

-- 5. Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del 20/06/2020 (21)
SELECT * 
FROM `exams` 
WHERE `hour` >= "14:00:00"
AND `date` = "2020-06-20";

-- 6. Selezionare tutti i corsi di laurea magistrale (38)
SELECT * 
FROM `degrees` 
WHERE `level` = "magistrale";

-- 7. Da quanti dipartimenti è composta l'università? (12)
SELECT COUNT(`id`) AS `num_dipartiments`
FROM `departments`;

-- 8. Quanti sono gli insegnanti che non hanno un numero di telefono? (50)
SELECT * 
FROM `teachers` 
WHERE `phone` IS NULL;

-- 9. Inserire nella tabella degli studenti un nuovo record con i propri dati (per il campo degree_id, inserire un valore casuale)
INSERT INTO `students` ( `degree_id`, `name`, `surname`, `date_of_birth`, `fiscal_code`, `enrolment_date`, `registration_number`, `email`)
VALUES ("67","Gessica","Calchi", "2000-08-31", "Q10VYW51Z02T871B", "2019-02-21", "620058", "disperazioneoliosutela@gmail.com");

-- 10. Cambiare il numero dell’ufficio del professor Artemide Rizzi in 126
UPDATE `teachers`
SET `office_number` = 126
WHERE `id` = 1;
-- OPPURE : Pietro Rizzo
UPDATE `teachers`
SET `office_number` = 126
WHERE `name`= "Pietro" AND `surname` = "Rizzo";

-- 11. Eliminare dalla tabella studenti il record creato precedentemente al punto 9
DELETE FROM `students` 
WHERE `email`= "disperazioneoliosutela@gmail.com";
-- OPPURE
DELETE FROM `students` 
WHERE `id`= "5001";


--- esempio 1: voglio sapere quanti studenti ci sono nei diversi corsi di laurea, ed avremo 2 tabelle (degree_id e count(id)).
 SELECT `degree_id`, COUNT(`id`)
FROM `students` 
GROUP BY `degree_id`;

---------- JOIN --------------------------------------------------------
-- 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
SELECT `students`.`id` AS`student_id`,`students`.`degree_id` AS `degree_name`, `degrees`.`name`
FROM `students` 
INNER JOIN `degrees`
ON `students`.`degree_id` = `degrees`.`id`
WHERE `degrees`.`name` = "Corso di Laurea in Economia"

-- 2. Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze
 SELECT `courses`.*
 FROM `courses` 
 INNER JOIN `degrees`
 ON `courses`.`degree_id` = `degree_id` 
 INNER JOIN `departments` ON `degrees`.`department_id` = `departments`.`id` 
 WHERE `degrees`.`level` = "magistrale" 
 AND `departments`.`name` = "Dipartimento di Neuroscienze";

-- 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
SELECT *
FROM `teachers` 
INNER JOIN `course_teacher`
ON `teachers`.`id` = `course_teacher`.`teacher_id`
INNER JOIN `courses`
ON `course_teacher`.`teacher_id` = `courses`.`id`
WHERE `teachers`.`id` = 44;

-- 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome
SELECT `students`.`id`, `students`.`name`, `students`.`surname`, `degrees`.`name` AS `name_degree`, `departments`.`name` AS `name_diparment`
FROM `students`
INNER JOIN `degrees`
ON `students`.`degree_id` = `degrees`.`id`
INNER JOIN `departments` 
ON `degrees`.`department_id` = `departments`.`id`
ORDER BY `students`.`name`;

-- 5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti
SELECT `degrees`.`name` AS `name_degree`, `courses`.`name` AS `name_course`, `teachers`.`name` AS `teacher_name`, `teachers`.`surname` AS `teacher_surname`
FROM `degrees`
INNER JOIN `courses`
ON `degrees`.`id` = `courses`.`degree_id`
INNER JOIN `course_teacher`
ON `courses`.`id` = `course_teacher`.`course_id`
INNER JOIN `teachers`
ON `course_teacher`.`teacher_id` = `teachers`.`id`;


-- 6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)
-- 7. BONUS: Selezionare per ogni studente quanti tentativi d’esame ha sostenuto per superare ciascuno dei suoi esami

-------------- GROUP BY -------------------
-- 1. Contare quanti iscritti ci sono stati ogni anno
-- 2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio
-- 3. Calcolare la media dei voti di ogni appello d'esame
-- 4. Contare quanti corsi di laurea ci sono per ogni dipartimento