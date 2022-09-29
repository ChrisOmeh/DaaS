# VIEW FILES IN EXCEL_FILE_PATH
files_in_pwd = os.listdir(excel_file_path)
print(files_in_pwd)
for i in files_in_pwd:
    print(f"File{i} is a {type(i)} file type")

files_folder = glob.glob("*.csv")
for csv_files in files_folder:
    dataset = pd.read_csv(str(csv_files))
    dataset.to_excel(str(csv_files) + ".xlsx", index=False)
pass

files_in_pwd = os.listdir(csv_file_path)
for files in files_in_pwd:
    print(f"==THE FILE IS {files}==")
    if files.endswith(".xlsx"):
        shutil.move(csv_file_path+str(files), excel_file_path)
        #dataset = pd.read_excel(str(files))
        #new_excel_file_array.append(dataset)
    else:
        print(f"==THE FILE {files} IS NOT AN EXCEL FILE==")

pass

# Grade = pd.concat(new_excel_file_array, axis=1, join="inner")
# #Rename the columns to students score and name
# new_column_name = dict(Name = "Students Name",
#                        Mark = "Students Score")

# Grade.rename(columns = new_column_name, inplace=True)
# print(Grade.head)