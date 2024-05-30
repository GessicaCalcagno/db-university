---------- JOIN --------------------------------------------------------
-- 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
SELECT 
`students`.`id` AS`student_id`,
`students`.`degree_id` AS `degree_name`,
`degrees`.`name`
FROM `students` 
INNER JOIN `degrees`
    ON `students`.`degree_id` = `degrees`.`id`
WHERE `degrees`.`name` = "Corso di Laurea in Economia"

-- 2. Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze
 SELECT `courses`.*
 FROM `courses` 
 INNER JOIN `degrees`
    ON `courses`.`degree_id` = `degree_id` 
 INNER JOIN `departments` 
    ON `degrees`.`department_id` = `departments`.`id` 
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
SELECT 
`students`.`id`,
`students`.`name`,
`students`.`surname`,
`degrees`.`name` AS `name_degree`,
`departments`.`name` AS `name_diparment`
FROM `students`
INNER JOIN `degrees`
    ON `students`.`degree_id` = `degrees`.`id`
INNER JOIN `departments` 
    ON `degrees`.`department_id` = `departments`.`id`
ORDER BY `students`.`name`;

-- 5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti
SELECT 
`degrees`.`name` AS `name_degree`,
`courses`.`name` AS `name_course`,
`teachers`.`name` AS `teacher_name`,
`teachers`.`surname` AS `teacher_surname`
FROM `degrees`
INNER JOIN `courses`
    ON `degrees`.`id` = `courses`.`degree_id`
INNER JOIN `course_teacher`
    ON `courses`.`id` = `course_teacher`.`course_id`
INNER JOIN `teachers`
    ON `course_teacher`.`teacher_id` = `teachers`.`id`;


-- 6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)
SELECT DISTINCT `teachers`.*
FROM `teachers`
INNER JOIN `course_teacher` 
    ON `teachers`.`id` = `course_teacher`.`teacher_id`
INNER JOIN `courses` 
    ON `course_teacher`.`course_id` = `courses`.`id`
INNER JOIN `degrees` 
    ON `courses`.`degree_id` = `degrees`.`id`
INNER JOIN `departments` 
    ON `degrees`.`department_id` = `departments`.`id`
WHERE `departments`.`name` = 'Dipartimento di Matematica';

-- 7. BONUS: Selezionare per ogni studente quanti tentativi d’esame ha sostenuto per superare ciascuno dei suoi esami