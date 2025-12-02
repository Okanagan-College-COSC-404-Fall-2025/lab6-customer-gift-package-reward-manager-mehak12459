-- Part A: Create nested table type and GIFT_CATALOG table

-- 1. Create nested table type
CREATE OR REPLACE TYPE gift_list_t AS TABLE OF VARCHAR2(100);
/

-- 2. Create GIFT_CATALOG table with nested table column
CREATE TABLE gift_catalog (
    gift_id      NUMBER PRIMARY KEY,
    min_purchase NUMBER NOT NULL,
    gifts        gift_list_t
)
NESTED TABLE gifts STORE AS gift_items_nt;
/

-- 3. Insert sample gift packages
INSERT INTO gift_catalog VALUES (
    1,
    100,
    gift_list_t('Stickers', 'Pen Set')
);

INSERT INTO gift_catalog VALUES (
    2,
    1000,
    gift_list_t('Teddy Bear', 'Mug', 'Perfume Sample')
);

INSERT INTO gift_catalog VALUES (
    3,
    10000,
    gift_list_t('Backpack', 'Thermos Bottle', 'Chocolate Collection')
);

COMMIT;
/
