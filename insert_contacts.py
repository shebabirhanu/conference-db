import csv

with open('contacts.csv', 'r') as file:
    reader = csv.DictReader(file)
    for row in reader:
        print(f"INSERT INTO Contacts (f_name, l_name, organization, title, email, phone) "
              f"VALUES ('{row['f_name']}', '{row['l_name']}', '{row['organization']}', "
              f"'{row['title']}', '{row['email']}', '{row['phone']}');")
