import csv
import os.path

while True:
    if os.path.isfile('user_data.csv'):
        pass
    else:
        create_file = open('user_data.csv', 'w', encoding='utf-8')
        create_file.writelines('HOST, NAME, PASSWORD')
        create_file.close()

    hostname = str(input('Enter a hostname please: '))
    username = str(input('Enter a name please: '))
    password = str(input('Enter a password please: '))


    def write_to_file(host='undefined', username='undefined', password='undefined'):
        with open('user_data.csv', 'a',encoding='utf-8') as file:
            file.write('\n' + host + ',')
            file.write(username + ',')
            file.write(password)

    def read_data(file_name):
        with open (file_name, encoding="utf8") as r_file:
            file_reader = csv.reader(r_file, delimiter=',')
            for row in file_reader:
                print(row)

    write_to_file(hostname, username, password)

    question1 = input('Do you need to add one more user? (press y to add or any botton to read the file) ')
    if question1.lower() == 'y':
        pass
    else:
        read_data('user_data.csv')
        break