with open('all_4.txt', 'a') as save_file:
    for rows in range(0, 41):
        res = str(rows) + " & "
        for files in range(1, 8):
            with open(str(files)+'.csv', 'r') as file:
                lines = file.readlines()
                line = lines[rows].strip()
            if files != 7:
                res = res + line + " & "
            else:
                res = res + line
        res = res + "\\\\\n\\hline\n"
        save_file.write(res)

