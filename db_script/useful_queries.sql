use db_DRIFT;
SELECT 	prd.title,
		prd.order_no,
		rev.status, 
		rev.submit_date, 
		rev.accept_date
FROM tbl_product prd
INNER JOIN tbl_review rev
WHERE prd.id = rev.product_id
AND rev.status IN ('ACCEPT', 'SUBMIT')
AND prd.order_no IN ('303-4793280-0329901', '303-7931036-4377940', '303-0343009-3419573');

SELECT count(rev.id)
FROM tbl_review rev
WHERE rev.accept_date IS NOT NULL;

-- SELECT prd.id
SELECT prd.*
FROM tbl_product prd
WHERE prd.order_no = '303-9501192-0574703'
AND LOWER(prd.title) LIKE '%plant stand%';

SELECT ser.id
FROM tbl_service ser
WHERE LOWER(ser.provider) LIKE '%nassimnis%'
AND LOWER(ser.title) LIKE '%Cast the strongest custom spell using arabic triple djinns%';

SELECT prd.id, prd.title, prd.order_no
FROM tbl_product prd
WHERE LOWER(prd.title) LIKE CONCAT('%', LOWER('pump'), '%');