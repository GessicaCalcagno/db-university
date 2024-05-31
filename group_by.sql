-------------- GROUP BY -------------------
-- 1. Contare quanti iscritti ci sono stati ogni anno (4 anni 2018 al 2021)
SELECT 
COUNT(id) AS `num_students`, 
YEAR(`students`.`enrolment_date`) AS `year`
FROM `students`
GROUP BY YEAR(`enrolment_date`);

-- 2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio (24)
SELECT 
COUNT(`id`) AS `teachers_on_the_same_addresss`, 
`teachers`.`office_address` AS `address`
FROM `teachers` 
GROUP BY `teachers`.`office_address`
HAVING COUNT(*) > 1;

-- 3. Calcolare la media dei voti di ogni appello d'esame
SELECT 
`exams`.`id` AS `id_exam`, 
`exams`.`date` AS `date_exam`, 
AVG(`exam_student`.`vote`) AS `media_vote`
FROM `exam_student`
INNER JOIN `exams` 
    ON `exam_student`.`exam_id` = `exams`.`id`
GROUP BY 
`exams`.`id`, 
`exams`.`date`;

-- 4. Contare quanti corsi di laurea ci sono per ogni dipartimento
SELECT 
`departments`.`id`    AS `id_dipartimento`, 
`departments`.`name`  AS `nome_dipartimento`, 
COUNT(`degrees`.`id`) AS `numero_corsi_di_laurea`
FROM 
`degrees`
INNER JOIN 
`departments` 
    ON `degrees`.`department_id` = `departments`.`id`
GROUP BY 
`departments`.`id`, 
`departments`.`name`
ORDER BY 
`departments`.`name`;