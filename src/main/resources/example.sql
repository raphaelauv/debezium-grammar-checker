CREATE DEFINER=`ci`@`%` PROCEDURE `toto`.`21`(IN p_platform_id CHAR(2), IN p_sleep INT)
BEGIN
    declare cnt integer default 0; 
    DECLARE finished INTEGER DEFAULT 0;
    DECLARE tataId int(11);
    DECLARE curTransaction
        CURSOR FOR 
        SELECT cto.id 
        FROM toto_tata_order cto
        JOIN toto_tata ct 
          ON cto.tata_id = ct.id
        JOIN titi_orders xo 
          ON xo.order_cart_id = ct.cart_id
        WHERE ct.platform_id = p_platform_id
          AND cto.shipping_price_vat_rate = 0
          AND xo.is_mmf = 1;
    DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET finished = 1;
    OPEN curTransaction;
    START TRANSACTION;
    getTransaction: LOOP
        FETCH curTransaction INTO tataId;
        IF finished = 1 THEN 
            LEAVE getTransaction;
        END IF;
        SET cnt = cnt + 1;
        UPDATE toto_tata_order
        SET shipping_price_vat_rate = 21
        WHERE id = tataId;
        if mod(cnt,25000) = 0
            then commit; 
                select cnt, now();
                select sleep(p_sleep);
                START TRANSACTION; 
        end if;
    END LOOP getTransaction;
    CLOSE curTransaction;
    commit; 
END