-- Read-only queries

-- Who  has not responded to the invitation?
SELECT c.contact_id, c.f_name, c.l_name
FROM Contacts c
JOIN Invitations i ON c.contact_id = i.contact_id
WHERE UPPER(i.response) = UPPER('pending');

-- Who has accepted the invitation but not completed registration for the conference?
SELECT c.contact_id, c.f_name, c.l_name
FROM Contacts c
JOIN Invitations i ON c.contact_id = i.contact_id
LEFT JOIN Registration r ON c.contact_id = r.contact_id
WHERE UPPER(i.response) = UPPER('accepted') 
AND (r.registration_id IS NULL OR r.form_completed = 0);


-- How much have you spent on hotel, charges, and flights?
SELECT 
    SUM(hb.cost) AS "Hotel Costs",
    SUM(hb.charges) AS "Hotel Charges",
    SUM(fb.cost) AS "Flight Costs",
    SUM(hb.cost + hb.charges + NVL(fb.cost, 0)) AS "Total Costs"
FROM Hotel_Bookings hb
LEFT JOIN Flights fb ON hb.contact_id = fb.contact_id; 

-- UPDATE Jenna Ray just accepted her invitation
UPDATE Invitations i
SET i.response = 'Pending'
WHERE i.contact_id IN (
    SELECT c.contact_id 
    FROM Contacts c 
    WHERE UPPER(c.l_name) = UPPER('Ray')
);


-- DELETE contact 'test-delete'
DELETE FROM Contacts
WHERE UPPER(f_name) = UPPER('test_delete');


-- Add, Delete, and other sample statements:

-- Dummy Data

/*
-- CSV TO SQL - Generated using insert_contacts.py
INSERT INTO Contacts (f_name, l_name, organization, title, email, phone) VALUES ('Alice', 'Green', 'Tech Solutions', 'Developer', 'alice.green@example.com', '555-0011');
INSERT INTO Contacts (f_name, l_name, organization, title, email, phone) VALUES ('Bob', 'White', 'Health Services', 'Nurse', 'bob.white@example.com', '555-0022');
INSERT INTO Contacts (f_name, l_name, organization, title, email, phone) VALUES ('Charlie', 'Black', 'Finance Group', 'Accountant', 'charlie.black@example.com', '555-0033');
INSERT INTO Contacts (f_name, l_name, organization, title, email, phone) VALUES ('Diana', 'Blue', 'Education Center', 'Instructor', 'diana.blue@example.com', '555-0044');
INSERT INTO Contacts (f_name, l_name, organization, title, email, phone) VALUES ('Evan', 'Red', 'Construction Co.', 'Foreman', 'evan.red@example.com', '555-0055');
INSERT INTO Contacts (f_name, l_name, organization, title, email, phone) VALUES ('test_delete', 'test_delete', 'test_delete', 'test_delete', 'test_delete', 'test_delete');
INSERT INTO Contacts (f_name, l_name, organization, title, email, phone) VALUES ('Jenna', 'Ray', 'Test', 'test_delete', 'test_delete', 'test_delete');

-- Invitations
INSERT INTO Invitations (contact_id, date_sent, response) 
VALUES (1, SYSDATE, 'Rejected');

INSERT INTO Invitations (contact_id, date_sent, response) 
VALUES (2, SYSDATE, 'Pending');

INSERT INTO Invitations (contact_id, date_sent, response) 
VALUES (3, SYSDATE, 'Pending');

INSERT INTO Invitations (contact_id, date_sent, response) 
VALUES (4, SYSDATE, 'Accepted');

INSERT INTO Invitations (contact_id, date_sent, response) 
VALUES (5, SYSDATE, 'Declined');

INSERT INTO Invitations (contact_id, date_sent, response) 
VALUES (6, SYSDATE, 'Accepted');

INSERT INTO Invitations (contact_id, date_sent, response) 
VALUES (7, SYSDATE, 'Pending');

INSERT INTO Invitations (contact_id, date_sent, response) 
VALUES (8, SYSDATE, 'Pending');


-- Delete specific contact
DELETE FROM Contacts
WHERE contact_id = 6;

-- Registration updates
INSERT INTO Registration (contact_id, date_link_sent, form_completed) 
VALUES (4, TO_DATE('2024-09-06', 'YYYY-MM-DD'), 1);

INSERT INTO Registration (contact_id, date_link_sent, form_completed) 
VALUES (5, TO_DATE('2024-09-07', 'YYYY-MM-DD'), 0);

INSERT INTO Registration (contact_id, date_link_sent, form_completed) 
VALUES (6, TO_DATE('2024-09-08', 'YYYY-MM-DD'), 1);

INSERT INTO Registration (contact_id, date_link_sent, form_completed) 
VALUES (7, TO_DATE('2024-09-09', 'YYYY-MM-DD'), 0);

INSERT INTO Registration (contact_id, date_link_sent, form_completed) 
VALUES (8, TO_DATE('2024-09-10', 'YYYY-MM-DD'), 1);

-- Hotel Bookings
INSERT INTO Hotel_Bookings (contact_id, date_link_sent, form_completed, hotel_name, check_in, check_out, cost, charges) 
VALUES (4, TO_DATE('2024-09-07', 'YYYY-MM-DD'), 1, 'Hilton Hotel', TO_DATE('2024-09-25', 'YYYY-MM-DD'), TO_DATE('2024-09-29', 'YYYY-MM-DD'), 800.00, 120.00);

INSERT INTO Hotel_Bookings (contact_id, date_link_sent, form_completed, hotel_name, check_in, check_out, cost, charges) 
VALUES (5, TO_DATE('2024-09-08', 'YYYY-MM-DD'), 1, 'Holiday Inn', TO_DATE('2024-09-26', 'YYYY-MM-DD'), TO_DATE('2024-09-30', 'YYYY-MM-DD'), 750.00, 100.00);

INSERT INTO Hotel_Bookings (contact_id, date_link_sent, form_completed, hotel_name, check_in, check_out, cost, charges) 
VALUES (6, TO_DATE('2024-09-09', 'YYYY-MM-DD'), 0, 'Marriott', TO_DATE('2024-09-27', 'YYYY-MM-DD'), TO_DATE('2024-10-01', 'YYYY-MM-DD'), 950.00, 150.00);

INSERT INTO Hotel_Bookings (contact_id, date_link_sent, form_completed, hotel_name, check_in, check_out, cost, charges) 
VALUES (7, TO_DATE('2024-09-10', 'YYYY-MM-DD'), 1, 'Hyatt Regency', TO_DATE('2024-09-28', 'YYYY-MM-DD'), TO_DATE('2024-10-02', 'YYYY-MM-DD'), 890.00, 130.00);

INSERT INTO Hotel_Bookings (contact_id, date_link_sent, form_completed, hotel_name, check_in, check_out, cost, charges) 
VALUES (8, TO_DATE('2024-09-11', 'YYYY-MM-DD'), 1, 'Sheraton', TO_DATE('2024-09-29', 'YYYY-MM-DD'), TO_DATE('2024-10-03', 'YYYY-MM-DD'), 940.00, 160.00);

-- Flights
INSERT INTO Flights (contact_id, date_link_sent, form_completed, flight_num, arrival_date, departure_date, cost) 
VALUES (4, TO_DATE('2024-09-07', 'YYYY-MM-DD'), 1, 'BA001', TO_DATE('2024-09-25', 'YYYY-MM-DD'), TO_DATE('2024-09-29', 'YYYY-MM-DD'), 450.00);

INSERT INTO Flights (contact_id, date_link_sent, form_completed, flight_num, arrival_date, departure_date, cost) 
VALUES (5, TO_DATE('2024-09-08', 'YYYY-MM-DD'), 1, 'LH123', TO_DATE('2024-09-26', 'YYYY-MM-DD'), TO_DATE('2024-09-30', 'YYYY-MM-DD'), 500.00);

INSERT INTO Flights (contact_id, date_link_sent, form_completed, flight_num, arrival_date, departure_date, cost) 
VALUES (6, TO_DATE('2024-09-09', 'YYYY-MM-DD'), 0, 'AF456', TO_DATE('2024-09-27', 'YYYY-MM-DD'), TO_DATE('2024-10-01', 'YYYY-MM-DD'), 550.00);

INSERT INTO Flights (contact_id, date_link_sent, form_completed, flight_num, arrival_date, departure_date, cost) 
VALUES (7, TO_DATE('2024-09-10', 'YYYY-MM-DD'), 1, 'KL789', TO_DATE('2024-09-28', 'YYYY-MM-DD'), TO_DATE('2024-10-02', 'YYYY-MM-DD'), 600.00);

INSERT INTO Flights (contact_id, date_link_sent, form_completed, flight_num, arrival_date, departure_date, cost) 
VALUES (8, TO_DATE('2024-09-11', 'YYYY-MM-DD'), 1, 'AA987', TO_DATE('2024-09-29', 'YYYY-MM-DD'), TO_DATE('2024-10-03', 'YYYY-MM-DD'), 650.00);

-- Session Attendance 
INSERT INTO Session_Attendance (contact_id, attended_status) 
VALUES (4, 'Attended');

INSERT INTO Session_Attendance (contact_id, attended_status) 
VALUES (5, 'Not Attended');

INSERT INTO Session_Attendance (contact_id, attended_status) 
VALUES (6, 'Attended');

INSERT INTO Session_Attendance (contact_id, attended_status) 
VALUES (7, 'Not Attended');

INSERT INTO Session_Attendance (contact_id, attended_status) 
VALUES (8, 'Attended');



*/