
-- район с наибольшим количеством объявлений.
SELECT neighbourhood, COUNT(*) as listings
FROM airbnb

-- Выведи топ-5 районов с наивысшей средней ценой.

SELECT neighbourhood, AVG(price) as avg_price
FROM airbnb
GROUP BY neighbourhood
ORDER BY avg_price DESC
LIMIT 5;

-- Сколько объектов доступно в каждом neighbourhood_group?
SELECT room_type, availability_365;
FROM airbnb;
WHERE availability_365 > 0;

-- Сколько объявлений имеют цену больше 300$?
SELECT neighbourhood_group, COUNT(*) as available_listings
FROM airbnb
WHERE availability_365 > 0
GROUP BY neighbourhood_group;

-- Какая минимальная и максимальная цена для каждого типа жилья?
SELECT room_type, 
       MIN(price) as min_price, 
       MAX(price) as max_price
FROM airbnb
GROUP BY room_type;

-- Найди топ-10 самых дорогих объектов с указанием name, neighbourhood, price.
SELECT name, neighbourhood, price
FROM airbnb
ORDER BY price DESC
LIMIT 10;

-- Сколько объектов каждого типа жилья есть в базе?

SELECT room_type , COUNT(*) as count
FROM airbnb
GROUP BY room_type;


-- Средняя цена по типу жилья в районе “Brooklyn”.

SELECT room_type, AVG(price) as avg_price
FROM airbnb
WHERE neighbourhood_group = 'Brooklyn'

-- Для каждого типа жилья: выведи среднюю цену и общее количество объектов.

SELECT room_type, AVG(price) as avg_price, COUNT(*) as count
FROM airbnb
GROUP BY room_type;

-- Найди все объекты, у которых больше 50 отзывов и цена меньше 100.

SELECT * 
FROM airbnb
WHERE number_of_reviews > 50 AND price < 100;


-- Сколько объектов имеют пустое значение в last_review?

SELECT COUNT(*) as empty_last_review_count
FROM airbnb
WHERE last_review IS NULL;

-- Найди объявления, размещённые после 1 января 2019 года и имеющие хотя бы 1 отзыв.

SELECT * 
FROM airbnb
WHERE last_review > '2019-01-01' AND number_of_reviews > 0;

-- Для каждого neighbourhood_group выведи:
-- количество объектов
-- среднюю цену
-- среднее количество отзывов

SELECT neighbourhood_group,
       COUNT(*) as listings_count, 
       ROUND(AVG(price), 2) as avg_price,
       ROUND(AVG(number_of_reviews), 2) as avg_reviews

FROM airbnb
GROUP BY neighbourhood_group;


-- Для каждой комбинации neighbourhood_group и room_type выведи количество объявлений.

SELECT neighbourhood_group, room_type, COUNT(*) as listings_count
FROM airbnb


-- Добавь к каждому объявлению его “ранг” по цене в пределах района.

SELECT id, neighbourhood_group, price,
       RANK() OVER (
        PARTITION BY neighbourhood_group 
        ORDER BY price) as price_rank
FROM airbnb


-- Для каждой записи — средняя цена среди 5 ближайших (по price) объектов в том же районе.

SELECT id, neighbourhood_group, price,
       AVG(price) OVER (
        PARTITION BY neighbourhood_group 
        ORDER BY price 
        ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING) as avg_nearby_price
FROM airbnb