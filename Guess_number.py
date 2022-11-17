import random
xp = random.randrange(1, 101)
tries = 0
print('Wellcome!')
print('This is a game "Guess a number"')
print('I have a number in mind. What is it?')

while True:
    tries += 1
    try:
        np = input()
        np = int(np)
    except ValueError:
        pass

    if type(np) == int:
        if np == xp:
            print('Congratulations! You have found it!')
            print(f'You have used {tries} tries')
            print('Do you want to play once more?' 'y/n')
            answ = input('')
            if answ.lower() == 'y':
                xp = random.randrange(1, 101)
                tries = 0
                print('And again, what number i have in mind')
            else:
                print('Very well, goodbye than :)')
                break
        elif np < xp:
            print('Wrong! The number is higher!')

        elif np > xp:
            print('Wrong! The number is lower')

    else:
        print('Please, type only numbers')