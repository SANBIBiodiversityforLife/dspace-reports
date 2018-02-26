/*
This SQL is used to populate a Jasper Reports Dataset called 'PublicationMetaData' in two reports for SANBI's DSpace implementation.
*/

/*
metadata_field_ids:
date_published 	15
article_title 	64
edition 		155
city 			168
publisher		109
volume			142
page			144
url				32
doi				147
conference_name	163
journal_name	178
?? 				164 
series_title	160
web_title		180
chapter_title	158
*/

SELECT * FROM (
	SELECT * FROM (
		SELECT DISTINCT concat(
			(SELECT * FROM buildauthormetadata(dspace_object_id)), '. ',
			(SELECT EXTRACT(YEAR FROM to_date((SELECT * FROM get_metadata_field(dspace_object_id, 15)), 'YYYY'))), '. ',
			(SELECT * FROM get_metadata_field(dspace_object_id, 64)), ' ',
			(SELECT * FROM get_metadata_field(dspace_object_id, 155)), '. ',
			(SELECT * FROM get_metadata_field(dspace_object_id, 168)), ': ',
			(SELECT * FROM get_metadata_field(dspace_object_id, 109)), '. ',
			(SELECT * FROM get_metadata_field(dspace_object_id, 142)), ': ',
			(SELECT * FROM get_metadata_field(dspace_object_id, 144))
		) AS reference_string,
		(SELECT * FROM get_metadata_field(dspace_object_id, 15)) AS date_published,
		(SELECT text_value FROM metadatavalue t2 WHERE t2.dspace_object_id = collection2item.collection_id AND t2.metadata_field_id = 64)  as collection_name 
		FROM metadatavalue INNER JOIN collection2item ON collection2item.item_id = metadatavalue.dspace_object_id) AS results
	WHERE collection_name = 'Books' OR collection_name = 'Booklet/leaflet' OR collection_name = 'Chapters in books'

	UNION ALL /* Conference abstract or conference proceeding */
	SELECT * FROM (
		SELECT DISTINCT concat(
			(SELECT * FROM buildauthormetadata(dspace_object_id)), '. ',
			(SELECT EXTRACT(YEAR FROM to_date((SELECT * FROM get_metadata_field(dspace_object_id, 15)), 'YYYY'))), '. ',
			(SELECT * FROM get_metadata_field(dspace_object_id, 64)), ' Presented at ',
			(SELECT * FROM get_metadata_field(dspace_object_id, 163)), ', ',
			(SELECT * FROM get_metadata_field(dspace_object_id, 168)), ': ',
			(SELECT * FROM get_metadata_field(dspace_object_id, 142)), ': ',
			(SELECT * FROM get_metadata_field(dspace_object_id, 144))
		) AS reference_string,
		(SELECT * FROM get_metadata_field(dspace_object_id, 15)) AS date_published,
		(SELECT text_value FROM metadatavalue t2 WHERE t2.dspace_object_id = collection2item.collection_id AND t2.metadata_field_id = 64)  as collection_name 
		FROM metadatavalue INNER JOIN collection2item ON collection2item.item_id = metadatavalue.dspace_object_id) AS results
	WHERE collection_name = 'Conference abstract' OR collection_name = 'Conference proceedings'

	UNION ALL /* Dataset */
	SELECT * FROM (
		SELECT DISTINCT concat(
			(SELECT * FROM buildauthormetadata(dspace_object_id)), '. ',
			(SELECT EXTRACT(YEAR FROM to_date((SELECT * FROM get_metadata_field(dspace_object_id, 15)), 'YYYY'))), '. ',
			(SELECT * FROM get_metadata_field(dspace_object_id, 64)), ' [dataset]. ',
			(SELECT * FROM get_metadata_field(dspace_object_id, 147)), '. Available: ',
			(SELECT * FROM get_metadata_field(dspace_object_id, 32))
		) AS reference_string,
		(SELECT * FROM get_metadata_field(dspace_object_id, 15)) AS date_published,
		(SELECT text_value FROM metadatavalue t2 WHERE t2.dspace_object_id = collection2item.collection_id AND t2.metadata_field_id = 64)  as collection_name 
		FROM metadatavalue INNER JOIN collection2item ON collection2item.item_id = metadatavalue.dspace_object_id) AS results
	WHERE collection_name = 'Dataset'

	UNION ALL /* Images */
	SELECT * FROM (
		SELECT DISTINCT concat(
			(SELECT * FROM buildauthormetadata(dspace_object_id)), '. ',
			(SELECT EXTRACT(YEAR FROM to_date((SELECT * FROM get_metadata_field(dspace_object_id, 15)), 'YYYY'))), '. ',
			(SELECT * FROM get_metadata_field(dspace_object_id, 64)), ' [Image available at: ',
			(SELECT * FROM get_metadata_field(dspace_object_id, 32))
		) AS reference_string,
		(SELECT * FROM get_metadata_field(dspace_object_id, 15)) AS date_published,
		(SELECT text_value FROM metadatavalue t2 WHERE t2.dspace_object_id = collection2item.collection_id AND t2.metadata_field_id = 64)  as collection_name 
		FROM metadatavalue INNER JOIN collection2item ON collection2item.item_id = metadatavalue.dspace_object_id) AS results
	WHERE collection_name = 'Journal Articles (peer reviewed)'

	UNION ALL /* Journal articles */
	SELECT * FROM (
		SELECT DISTINCT concat(
			(SELECT * FROM buildauthormetadata(dspace_object_id)), '. ',
			(SELECT EXTRACT(YEAR FROM to_date((SELECT * FROM get_metadata_field(dspace_object_id, 15)), 'YYYY'))), '. ',
			(SELECT * FROM get_metadata_field(dspace_object_id, 64)), ' ',
			(SELECT * FROM get_metadata_field(dspace_object_id, 178)), '. ',
			(SELECT * FROM get_metadata_field(dspace_object_id, 142)), ': ',
			(SELECT * FROM get_metadata_field(dspace_object_id, 144)), '. ',
			(SELECT * FROM get_metadata_field(dspace_object_id, 147))
		) AS reference_string,
		(SELECT * FROM get_metadata_field(dspace_object_id, 15)) AS date_published,
		(SELECT text_value FROM metadatavalue t2 WHERE t2.dspace_object_id = collection2item.collection_id AND t2.metadata_field_id = 64)  as collection_name 
		FROM metadatavalue INNER JOIN collection2item ON collection2item.item_id = metadatavalue.dspace_object_id) AS results
	WHERE collection_name = 'Journal Articles (peer reviewed)'

	UNION ALL /* Popular lit */
	SELECT * FROM (
		SELECT DISTINCT concat(
			(SELECT * FROM buildauthormetadata(dspace_object_id)), '. ',
			(SELECT EXTRACT(YEAR FROM to_date((SELECT * FROM get_metadata_field(dspace_object_id, 15)), 'YYYY'))), '. ',
			(SELECT * FROM get_metadata_field(dspace_object_id, 64)), '. [online] ',
			(SELECT * FROM get_metadata_field(dspace_object_id, 160)), ' ',
			(SELECT * FROM get_metadata_field(dspace_object_id, 15)), '. Available ',
			(SELECT * FROM get_metadata_field(dspace_object_id, 32))
		) AS reference_string,
		(SELECT * FROM get_metadata_field(dspace_object_id, 15)) AS date_published,
		(SELECT text_value FROM metadatavalue t2 WHERE t2.dspace_object_id = collection2item.collection_id AND t2.metadata_field_id = 64)  as collection_name 
		FROM metadatavalue INNER JOIN collection2item ON collection2item.item_id = metadatavalue.dspace_object_id) AS results
	WHERE collection_name = 'Popular literature (not peer reviewed)'

	UNION ALL /* Technical reports */
	SELECT * FROM (
		SELECT DISTINCT concat(
			(SELECT * FROM buildauthormetadata(dspace_object_id)), '. ',
			(SELECT EXTRACT(YEAR FROM to_date((SELECT * FROM get_metadata_field(dspace_object_id, 15)), 'YYYY'))), '. ',
			(SELECT * FROM get_metadata_field(dspace_object_id, 64)), ' ',
			(SELECT * FROM get_metadata_field(dspace_object_id, 168)), ' ',
			(SELECT * FROM get_metadata_field(dspace_object_id, 109)), '. Available at: ',
			(SELECT * FROM get_metadata_field(dspace_object_id, 32))
		) AS reference_string,
		(SELECT * FROM get_metadata_field(dspace_object_id, 15)) AS date_published,
		(SELECT text_value FROM metadatavalue t2 WHERE t2.dspace_object_id = collection2item.collection_id AND t2.metadata_field_id = 64)  as collection_name 
		FROM metadatavalue INNER JOIN collection2item ON collection2item.item_id = metadatavalue.dspace_object_id) AS results
	WHERE collection_name = 'Technical reports'

	UNION ALL /* Redlist review & websites */
	SELECT * FROM (
		SELECT DISTINCT concat(
			(SELECT * FROM buildauthormetadata(dspace_object_id)), '. ',
			(SELECT EXTRACT(YEAR FROM to_date((SELECT * FROM get_metadata_field(dspace_object_id, 15)), 'YYYY'))), '. ',
			(SELECT * FROM get_metadata_field(dspace_object_id, 64)), '. [online] ',
			(SELECT * FROM get_metadata_field(dspace_object_id, 180)), '. Available at: ',
			(SELECT * FROM get_metadata_field(dspace_object_id, 32))
		) AS reference_string,
		(SELECT * FROM get_metadata_field(dspace_object_id, 15)) AS date_published,
		(SELECT text_value FROM metadatavalue t2 WHERE t2.dspace_object_id = collection2item.collection_id AND t2.metadata_field_id = 64)  as collection_name 
		FROM metadatavalue INNER JOIN collection2item ON collection2item.item_id = metadatavalue.dspace_object_id) AS results
	WHERE collection_name = 'Redlist review' OR collection_name = 'Internet articles'

	UNION ALL /* Newsletter */
	SELECT * FROM (
		SELECT DISTINCT concat(
			(SELECT * FROM buildauthormetadata(dspace_object_id)), '. ',
			(SELECT EXTRACT(YEAR FROM to_date((SELECT * FROM get_metadata_field(dspace_object_id, 15)), 'YYYY'))), '. ',
			(SELECT * FROM get_metadata_field(dspace_object_id, 64)), '. [online] ',
			(SELECT * FROM get_metadata_field(dspace_object_id, 32))
		) AS reference_string,
		(SELECT * FROM get_metadata_field(dspace_object_id, 15)) AS date_published,
		(SELECT text_value FROM metadatavalue t2 WHERE t2.dspace_object_id = collection2item.collection_id AND t2.metadata_field_id = 64)  as collection_name 
		FROM metadatavalue INNER JOIN collection2item ON collection2item.item_id = metadatavalue.dspace_object_id) AS results
	WHERE collection_name = 'Newsletter'

	UNION ALL /* Thesis */
	SELECT * FROM (
		SELECT DISTINCT concat(
			(SELECT * FROM buildauthormetadata(dspace_object_id)), '. ',
			(SELECT EXTRACT(YEAR FROM to_date((SELECT * FROM get_metadata_field(dspace_object_id, 15)), 'YYYY'))), '. ',
			(SELECT * FROM get_metadata_field(dspace_object_id, 64)), ' ',
			(SELECT * FROM get_metadata_field(dspace_object_id, 160)), ' ',
			(SELECT * FROM get_metadata_field(dspace_object_id, 15)), '. Available: ',
			(SELECT * FROM get_metadata_field(dspace_object_id, 32))
		) AS reference_string,
		(SELECT * FROM get_metadata_field(dspace_object_id, 15)) AS date_published,
		(SELECT text_value FROM metadatavalue t2 WHERE t2.dspace_object_id = collection2item.collection_id AND t2.metadata_field_id = 64)  as collection_name 
		FROM metadatavalue INNER JOIN collection2item ON collection2item.item_id = metadatavalue.dspace_object_id) AS results
	WHERE collection_name = 'Thesis'
) AS final_results
WHERE date_published BETWEEN TO_CHAR($P{Q1a}::date, 'YYYY-MM-DD') AND TO_CHAR($P{Q4b}::date, 'YYYY-MM-DD') /* Swap with datestart + dateend here for other report*/
ORDER BY collection_name, reference_string
