# IMPORTING NECESSARY LIBRARIES
import pandas as pd
import numpy as np
import os, glob, shutil

# FILE PATH AND DIRECTORIES
print(f"THE FILES IN PWD IS:,'\n',{os.listdir()}")
print(f"THE FILES IN PWD IS:,'\n',{os.getcwd()}")


# ASSIGNMENT FILE PATHS
csv_file_path = "/home/chuxian/DaaS/PYTHON-CLASS/CSV_FILES"
excel_file_path = "/home/chuxian/DaaS/PYTHON-CLASS/EXCEL_FILES"

def test_fun(csv_file_path, excel_file_path):
    # READ ALL CSV FILES
    account = pd.read_csv(csv_file_path + "/Accountancy Result.csv")
    english = pd.read_csv(csv_file_path+"/English.csv")
    maths = pd.read_csv(csv_file_path+"/Maths.csv")
    economics = pd.read_csv(csv_file_path+"/Economics.csv")
    business = pd.read_csv(csv_file_path+"/Business Studies.csv")


    # VIEW SUMMARY OF THE VARIOUS CSV FILES
    print("==========ACCOUNTANCY STUDENTS RECORD==========,'\n'")
    print(account.head(),'\n')
    print("==========ECONOMICS STUDENTS RECORD=========='\n'")
    print(economics.head(),'\n')

    print("==========ENGLISH LANGUAGE STUDENTS RECORD=========='\n'")
    print(english.head(),'\n')

    print("==========BUSINESS STUDIES RECORD=========='\n'")
    print(business.head(),'\n')

    print("==========MATHEMATICS STUDIES RECORD=========='\n'")
    print(maths.head(),'\n')


    # SAVE THE CSV FILE TO EXCEL
    with pd.ExcelWriter(excel_file_path+"/Python_Assignment_Team-K8S.xlsx") as writer:
        account.to_excel(writer, sheet_name="Grade", index=False)
        economics.to_excel(writer, sheet_name="Grade", index=False)
        english.to_excel(writer, sheet_name="Grade", index=False)
        maths.to_excel(writer, sheet_name="Grade", index=False)
        business.to_excel(writer, sheet_name="Grade", index=False)


    # CREATING NEW COLUMN FOR SUBJECT
    account["Subject"] = "Accountancy"
    economics["Subject"] = "Economics"
    english["Subject"] = "English"
    business["Subject"] = "Business Studies"
    maths["Subject"] = "Mathematics"

    # CONCATENATE ALL DATAFRAME INTO ON DATAFRAME BY THE ROW
    con_file = [account, economics,english,business,maths]
    Grade = pd.concat(con_file, axis = 0)
    print("=======================================================,'\n'")
    print("=====TOP 10 RESULT OF CONCATENATED DATAFRAME IS BELOW=====,'\n'")
    print(Grade.head(n=10))
    print("=======================================================,'\n'")

    # TAIL
    print("=======================================================,'\n'")
    print("=====BUTTOM 10 RESULT OF CONCATENATED DATAFRAME IS BELOW=====,'\n'")
    print(Grade.tail(n=10))
    print("=======================================================,'\n'")


    # SHAPE OF THE CONCATENATED DATAFRAM
    print(f"THE NUMBER OF ROWS IN CONCATENATED DF IS: {Grade.shape[0]} WHILE THE COLUMNS IS: {Grade.shape[1]}",'\n',Grade.shape)


    # SAVE THE GRADE SUMMARY SHEET
    with pd.ExcelWriter(excel_file_path+"/Python_Assignment_Team-K8S.xlsx") as writer:
        Grade.to_excel(writer, sheet_name="Summary", index=False)
        #Grade.to_excel("Grade_sheet.xlsx", sheet_name = "Grade", index = False)

    # READ THE UPDATE EXCEL WORKBOOK SUMMARY SHEET
    Grade_summary_sheet = pd.read_excel(excel_file_path + "/Python_Assignment_Team-K8S.xlsx", sheet_name="Summary")
    print("=========================================================================,'\n'")
    print("=====TOP 10 RESULT OF SUMMARY SHEET OF EXCEL GRADE WORKBOOK IS BELOW=====,'\n'")
    print(Grade_summary_sheet.head(n=10))
    print("=========================================================================,'\n'")

    # CREATING PIVOT OF THE GRADE DATAFRAME
    tb_pivot1 = Grade_summary_sheet.pivot(index="Name", columns="Subject", values="Mark")
    tb_pivot = tb_pivot1.reset_index()#.melt(id_vars=['Name'])
    print("===================================================================,'\n'")
    print("=====TOP 10 RESULT OF SUMMARY SHEET OF GRADE WORKBOOK IS BELOW=====,'\n'")
    print(tb_pivot.head(n=10))
    print("===================================================================,'\n'")


    # CREATING THE TOTAL AND AVERAGE COLUMNS OF STUDENTS SCORE
    tb_pivot["Total"] = tb_pivot['Accountancy']+tb_pivot['Business Studies']+tb_pivot['Economics']+tb_pivot['English']+tb_pivot['Mathematics']
    tb_pivot["Average"] = round((tb_pivot['Accountancy']+tb_pivot['Business Studies']+tb_pivot['Economics']+tb_pivot['English']+tb_pivot['Mathematics'])/4)
    print("===================================================================,'\n'")
    print("=====TOP 10 RESULT OF SUMMARY SHEET OF GRADE WORKBOOK IS BELOW=====,'\n'")
    print(tb_pivot.head(n=10).sort_values(by = "Name"))
    print("===================================================================,'\n'")


    # BUTTOM TEN OF THE STUDENT GRADE SUMMARY SHEET
    print("======================================================================,'\n'")
    print("=====BUTTOM 10 RESULT OF SUMMARY SHEET OF GRADE WORKBOOK IS BELOW=====,'\n'")
    print(tb_pivot.tail(n=10).sort_values(by = "Name"))
    print("======================================================================,'\n'")

    final_table = tb_pivot
    # SAVE THE FINAL WORKBOOK
    # SAVE THE GRADE SUMMARY SHEET
    with pd.ExcelWriter(excel_file_path+"/Python_Assignment_Team-K8S.xlsx") as writer:
        final_table.to_excel(writer, sheet_name="Summary", index=False)
    
    
    return final_table #.to_excel("Python_Assignment_Team-K8S.xlsx", sheet_name="Summary",index = False)


if __name__ == "__main__":
    print(test_fun(csv_file_path=csv_file_path, excel_file_path=excel_file_path))