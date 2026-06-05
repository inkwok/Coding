#!/usr/bin/python3

import random
import sys

def load_money():
    try:
        file = open("money.txt", "r")
        money = int(file.read())
        file.close()
        return money
    except:
        return 100

def save_money(money):
    file = open("money.txt", "w")
    file.write(str(money))
    file.close()

def get_payout_multiplier(a, b, c):
    if a == b == c:
        return 10
    if a == b or b == c or a == c:
        return 5
    return 0

def generate_symbols():
    a = random.randint(1, 4)
    b = random.randint(1, 4)
    c = random.randint(1, 4)
    return a, b, c

def main():
    money = load_money()
    
    while money > 0:
        print("Money:", money)
        bet = int(input("How much to bet?\n"))

        if bet > money:
            print("Not enough money.")
            continue
        
        money = money - bet

        a, b, c = generate_symbols()
        m = get_payout_multiplier(a, b, c)
        winnings = bet * m

        money = money + winnings

        
        print("Spun numbers:", a, b, c)
        print("Multiplier:", m)
        print("Winnings:", winnings)
        print("Play again? [Y/n]")
        choice = sys.stdin.read(1)
        if choice == 'y' or choice == '\n':
            continue
        else:
            break

    save_money(money)



if __name__ == "__main__":
    main()
