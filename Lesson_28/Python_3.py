import csv
import os.path
# user_list = [['sector-1', 'Dick', 'Qwer1234'],
#              ['sector-2', 'Mary', 'Asdf1234'],
#              ['sector-3', 'Mike', 'Zxcv1234']
# ]


if os.path.isfile('user_data.csv'):
    pass
else:
    create_file = open('user_data.csv', 'w', encoding='utf-8')
    create_file.writelines('HOST, NAME, PASSWORD')
    create_file.close()


def write_to_file(host, username='undefined', password='undefined'):
    with open('user_data.csv', 'a',encoding='utf-8') as file:
        file.write('\n' + host + ',')
        file.write(username + ',')
        file.write(password)


write_to_file('Comp1', 'Sam', 'Fasx3f#1')

def read_data(file_name):
    with open (file_name, encoding="utf8") as r_file:
        file_reader = csv.reader(r_file, delimiter=',')
        for row in file_reader:
            print(row)


read_data('user_data.csv')