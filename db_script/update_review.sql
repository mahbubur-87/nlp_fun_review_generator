use db_DRIFT;

UPDATE	tbl_review rev
SET 	rev.status = 'ACCEPT',
		rev.accept_date = '2021-05-19 07:45:00'
WHERE 	rev.product_id = (
	SELECT	prd.id
	FROM 	tbl_product prd
	WHERE 	prd.order_no = '303-9501192-0574703'
	AND 	LOWER(prd.title) LIKE '%plant stand%');

UPDATE	tbl_review rev
SET 	rev.status = 'GET_PAID'
WHERE 	rev.product_id = (
	SELECT	prd.id
	FROM 	tbl_product prd
	WHERE 	prd.order_no = '303-9501192-0574703'
	AND 	LOWER(prd.title) LIKE '%plant stand%');

 