SELECT DISTINCT quantityOnHand
FROM item
WHERE itemDescription = 'bottle of antibiotics';

SELECT DISTINCT volunteerName
FROM volunteer
WHERE volunteerTelephone NOT LIKE '2%'
AND volunteerName NOT LIKE '%Jones'
OR volunteerTelephone IS NULL
AND volunteerName NOT LIKE '%Jones';

SELECT DISTINCT volunteerName
FROM volunteer
JOIN assignment 
ON volunteer.volunteerId = assignment.volunteerId 
JOIN task 
ON assignment.taskCode = task.taskCode
JOIN task_type ON task.taskTypeId = task_type.taskTypeID
WHERE taskDescription LIKE '%transport%';

SELECT taskDescription
FROM task
JOIN assignment 
ON task.taskCode = assignment.taskCode
WHERE assignment.startDateTime IS NULL;

SELECT DISTINCT packageTypeName
FROM package_type 
JOIN package 
ON package.packageTypeId = package_type.packageTypeId
JOIN package_contents
ON package.packageId = package_contents.packageId
JOIN item
ON package_contents.itemId = item. itemId
WHERE item.itemDescription LIKE '%bottle%';
 
SELECT DISTINCT itemDescription
FROM item
LEFT JOIN package_contents
ON package_contents.itemId = item.itemId
WHERE package_contents.itemId IS NULL;

SELECT taskDescription
FROM assignment
JOIN volunteer
ON volunteer.volunteerId = assignment.volunteerId
JOIN task
ON task.taskCode = assignment.taskCode
WHERE volunteer.volunteerAddress LIKE '%NJ%';

SELECT DISTINCT volunteerName
FROM volunteer
JOIN assignment 
ON volunteer.volunteerId = assignment.volunteerId
WHERE startDateTime >= '2021-01-01'
AND startDateTime <'2021-07-01';

SELECT DISTINCT volunteerName
FROM volunteer
JOIN assignment
ON volunteer.volunteerId = assignment.volunteerId
JOIN package
ON package.taskCode = assignment.taskCode
JOIN package_contents
ON package_contents.packageId = package.packageId
JOIN item
ON item.itemId = package_contents.itemId
WHERE itemDescription LIKE '%spam%';

SELECT DISTINCT itemDescription
FROM item
JOIN package_contents
ON package_contents.itemId = item.itemId
WHERE item.itemValue * package_contents.itemQuantity = 100;

SELECT DISTINCT taskStatusName, COUNT(assignment.volunteerId) AS volunteerCount
FROM task_status
JOIN task
ON task_status.taskStatusId = task.taskStatusId
LEFT JOIN assignment 
ON task.taskCode = assignment.taskCode
GROUP BY task_status.taskStatusId
ORDER BY volunteerCount DESC;

SELECT DISTINCT taskDescription, packageWeight
FROM package
JOIN  task
ON package.taskCode = task.taskCode
ORDER BY packageWeight DESC 
LIMIT 1;

SELECT COUNT(taskDescription)
FROM task
JOIN task_type
ON task.taskTypeID = task_type.taskTypeID
WHERE tasktypeName NOT IN ('packing');

SELECT DISTINCT itemDescription
FROM item
JOIN package_contents
ON item.itemId = package_contents.itemId
JOIN package
ON package_contents.packageID = package.packageID
JOIN assignment
ON assignment.taskCode = package.taskCode
GROUP BY item.itemDescription
HAVING COUNT(assignment.volunteerId) <3;

SELECT packageId, SUM(item.itemValue * package_contents.itemQuantity) AS packageValue
FROM package_contents
JOIN item
ON item.itemId = package_contents.itemId
GROUP BY package_contents.packageId
HAVING packageValue > 100
ORDER BY packageValue;
