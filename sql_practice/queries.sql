-- Задача 1 (COUNT и SUM): Посчитать, сколько всего завершённых покупок (WHERE status = 'completed') и на какую общую сумму (SUM(price_paid)) сделано в магазине. Задать псевдонимы total_purchases и total_revenue.
SELECT COUNT(*) AS total_purchases, SUM(price_paid) AS total_revenue
FROM purchases p
WHERE p.status = 'completed';

-- Задача 2 (JOIN + GROUP BY + ORDER BY): Для каждого игрока посчитать количество завершённых покупок (p.status = 'completed') и общее время в играх (SUM(p.playtime_minutes)). Вывести pl.username, purchases_count, total_minutes, отсортировать по убыванию total_minutes.
SELECT pl.username, SUM(p.playtime_minutes) AS total_minutes, COUNT(*) AS purchases_count 
FROM purchases p
JOIN players pl ON p.player_id = pl.id
WHERE p.status = 'completed'
GROUP BY pl.username
ORDER BY total_minutes DESC;

-- Задача 3 (JOIN + GROUP BY + HAVING): Найти игроков, у которых больше 1 достижения в таблице achievements. Вывести pl.username и achievements_count.
SELECT pl.username, COUNT(a.player_id) AS achievements_count
FROM achievements a
JOIN players pl ON a.player_id = pl.id
GROUP BY pl.username
HAVING COUNT(a.player_id) > 1;