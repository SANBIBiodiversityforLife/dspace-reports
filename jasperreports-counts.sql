/*
This SQL is used to populate a Jasper Reports Dataset called 'Dataset2' in two reports for SANBI's DSpace implementation.
*/

SELECT categories.text_value,
(
	SELECT COUNT(collection2item.item_id) FROM collection2item
	INNER JOIN metadatavalue date ON collection2item.item_id = date.dspace_object_id AND date.metadata_field_id = 15
	WHERE date.text_value >= TO_CHAR($P{Q1a}::date, 'YYYY-MM-DD')
	AND date.text_value <= TO_CHAR($P{Q1b}::date, 'YYYY-MM-DD')
	AND collection2item.collection_id = collection.uuid
) AS Q1,
(
	SELECT COUNT(collection2item.item_id) FROM collection2item
	INNER JOIN metadatavalue date ON collection2item.item_id = date.dspace_object_id AND date.metadata_field_id = 15
	WHERE date.text_value >= TO_CHAR($P{Q2a}::date, 'YYYY-MM-DD')
	AND date.text_value <= TO_CHAR($P{Q2b}::date, 'YYYY-MM-DD')
	AND collection2item.collection_id = collection.uuid
) AS Q2,
(
	SELECT COUNT(collection2item.item_id) FROM collection2item
	INNER JOIN metadatavalue date ON collection2item.item_id = date.dspace_object_id AND date.metadata_field_id = 15
	WHERE date.text_value >= TO_CHAR($P{Q3a}::date, 'YYYY-MM-DD') 
	AND date.text_value <= TO_CHAR($P{Q3b}::date, 'YYYY-MM-DD') 
	AND collection2item.collection_id = collection.uuid
) AS Q3,
(
	SELECT COUNT(collection2item.item_id) FROM collection2item
	INNER JOIN metadatavalue date ON collection2item.item_id = date.dspace_object_id AND date.metadata_field_id = 15
	WHERE date.text_value >= TO_CHAR($P{Q4a}::date, 'YYYY-MM-DD')
	AND date.text_value <= TO_CHAR($P{Q4b}::date, 'YYYY-MM-DD')
	AND collection2item.collection_id = collection.uuid
) AS Q4
FROM collection 
LEFT JOIN metadatavalue categories ON collection.uuid = categories.dspace_object_id AND categories.metadata_field_id = 64
WHERE collection.collection_id IS NOT NULL
AND categories.text_value IS NOT NULL
ORDER BY categories.text_value

/* For the other report, substitute the four quarters with one allitems result between DateStart and DateEnd */