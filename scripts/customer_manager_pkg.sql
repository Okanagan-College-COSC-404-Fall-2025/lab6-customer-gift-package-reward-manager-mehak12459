-- Package Specification for CUSTOMER_MANAGER

CREATE OR REPLACE PACKAGE customer_manager AS

    -- Public function: returns total purchase for a customer
    FUNCTION get_total_purchase(p_customer_id NUMBER) RETURN NUMBER;

    -- Public procedure: assigns gifts to all customers
    PROCEDURE assign_gifts_to_all;

END customer_manager;
/
