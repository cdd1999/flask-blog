import csv

with open('feedback.csv', '', newline='') as file:
    fieldnames = ['username', 'feedback','sentiment']
    writer = csv.DictWriter(file, fieldnames=fieldnames)

    writer.writeheader()
    #writer.writerow({'username': 'Magnus Carlsen', 'feedback': 2870,'sentiment':'Negative'})
    