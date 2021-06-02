use db_DRIFT;
UPDATE	tbl_review rev
SET 	rev.status = 'ACCEPT',
		rev.accept_date = '2021-05-24 04:21:00'
WHERE 	rev.product_id = (
	SELECT	prd.id
	FROM 	tbl_product prd
	WHERE 	prd.order_no = '303-7749026-5836301'
	AND 	LOWER(prd.title) LIKE '%Aroma Diffuser MadxfroG 200 ml%');

use db_DRIFT;
UPDATE	tbl_review rev
SET 	rev.status = 'GET_PAID'
WHERE 	rev.product_id = (
	SELECT	prd.id
	FROM 	tbl_product prd
	WHERE 	prd.order_no = '303-7749026-5836301'
	AND 	LOWER(prd.title) LIKE LOWER('%Aroma Diffuser MadxfroG 200 ml%'));

 