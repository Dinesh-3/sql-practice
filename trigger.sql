USE sql_invoicing;

DELIMITER $$

CREATE TRIGGER payments_after_insert
	AFTER INSERT ON payments -- AFTER -> NEW, BEFORE -> OLD, DELETE -> OLD, UPDATE
    FOR EACH ROW
BEGIN
	UPDATE invoices
    SET payment_total = payment_total + NEW.amount
    WHERE invoice_id = NEW.invoice_id;
END $$

DELIMITER ;

USE sql_invoicing;

DELIMITER $$

DROP TRIGGER IF EXISTS payments_after_delete $$
CREATE TRIGGER payments_after_delete
	AFTER DELETE ON payments
    FOR EACH ROW
BEGIN
	UPDATE invoices
    SET payment_total = payment_total - OLD.amount
    WHERE invoice_id = OLD.invoice_id;
END $$

DELIMITER ;