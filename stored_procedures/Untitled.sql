DROP PROCEDURE IF EXISTS get_clients;

use sql_store;

DELIMITER $$

CREATE PROCEDURE get_clients()

BEGIN

	SELECT * FROM clients;

END$$



DELIMITER ;