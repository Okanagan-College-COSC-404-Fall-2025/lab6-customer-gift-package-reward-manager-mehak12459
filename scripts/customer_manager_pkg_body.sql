CREATE OR REPLACE PACKAGE BODY customer_manager AS

    ------------------------------------------------------------------
    -- PRIVATE FUNCTION: Choose gift package based on purchase total
    ------------------------------------------------------------------
    FUNCTION choose_gift_package(p_total_purchase NUMBER)
        RETURN NUMBER
    IS
        v_gift_id gift_catalog.gift_id%TYPE;
    BEGIN
        SELECT gift_id
        INTO v_gift_id
        FROM gift_catalog
        WHERE min_purchase <= p_total_purchase
        ORDER BY min_purchase DESC
        FETCH FIRST 1 ROWS ONLY;

        RETURN v_gift_id;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
    END choose_gift_package;


    ------------------------------------------------------------------
    -- PUBLIC FUNCTION: Total purchase for given customer
    ------------------------------------------------------------------
    FUNCTION get_total_purchase(p_customer_id NUMBER)
        RETURN NUMBER
    IS
        v_total NUMBER := 0;
    BEGIN
        SELECT NVL(SUM(order_total), 0)
        INTO v_total
        FROM orders
        WHERE customer_id = p_customer_id;

        RETURN v_total;
    END get_total_purchase;


    ------------------------------------------------------------------
    -- PUBLIC PROCEDURE: Assign gifts to all customers
    ------------------------------------------------------------------
    PROCEDURE assign_gifts_to_all IS
        v_total_purchase NUMBER;
        v_gift_id        NUMBER;
        v_email          customers.email%TYPE;
        v_customer_id    customers.customer_id%TYPE;
    BEGIN
        FOR rec IN (SELECT customer_id, email FROM customers) LOOP

            v_email := rec.email;
            v_customer_id := rec.customer_id;

            -- 1. Total purchase
            v_total_purchase := get_total_purchase(v_customer_id);

            -- 2. Choose gift
            v_gift_id := choose_gift_package(v_total_purchase);

            -- 3. Insert reward if gift exists
            IF v_gift_id IS NOT NULL THEN
                INSERT INTO customer_rewards (customer_email, gift_id, reward_date)
                VALUES (v_email, v_gift_id, SYSDATE);
            END IF;

        END LOOP;

        COMMIT;

    END assign_gifts_to_all;

END customer_manager;
/
