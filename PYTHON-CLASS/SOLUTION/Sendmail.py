from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from dotenv import load_dotenv
from email import encoders
import smtplib
import ssl, os
load_dotenv()

try:
    # Define the transport variables
    ctx = ssl.create_default_context()
    password = os.getenv("password")    # Your app password goes here
    sender = "chrismekus94@gmail.com"    # Your e-mail address
    receiver = ["emmymary11@gmail.com", "benedictwisdom3@gmail.com"]#,"ritaify25@gmail.com"]  # Recipient's address

    # Create the message
    message = MIMEMultipart("alternative")
    message["Subject"] = "TEAM KUBERNETES PYTHON CLASS ASSIGNMENT SOLUTION!"
    message["From"] = sender
    message["To"] = ",".join(receiver)

    attach_file_name = 'Python_Assignment_Team-K8S.xlsx'
    attach_file = open("/home/chuxian/DaaS/PYTHON-CLASS/EXCEL_FILES/Python_Assignment_Team-K8S.xlsx", 'rb') # Open the file as binary mode
    payload = MIMEBase('application', 'octate-stream')
    payload.set_payload((attach_file).read())
    encoders.encode_base64(payload) #encode the attachment
    
    #add payload header with filename
    payload.add_header('Content-Decomposition', 'attachment', filename=attach_file_name)
    message.attach(payload)
    # HTML version
    html = """\
    <!DOCTYPE html>
    <html>
        <head>
            <style>
                th, td{text-decoration-color: black;
                border: 1px solid black;
                }
                body {background-color: aquamarine;}
            </style>
    </head>

    <body>
        <p>  
        I trust this mail finds you well and you are having a nice time. 
        With regard to the Python Class Assignment, this mail is to respond to the assignment.<br><br>

        As a team(Team-K8S), we used various tools to solve this assignment.<br><br>

        <bold>TOOLS USED</bold> <br>
        <i>
        * Python<br>
        * Pandas Library<br>
        * Numpy Library<br>
        * Python OS Module<br>
        * SMTPLIB Library<br>
        * Python Email Module<br>
        * Python shutil module<br>
        * Glob Library<br>
        </i>
        <br><br>

        Our final result of the assignment is attached in this mail. It is an
        Excel Workbook containing various students <b>Total Scores from various
        Subjects.</b> <br><br>
        <i>
        * Accountancy<br>
        * Mathematics<br>
        * Business Studies<br>
        * Economics<br>
        * English Language<br>
        </i>
        <br><br>

        We also use this medium to appreciate the DaaS ng team for their benorvelence.<br>
        God Bless You all. <br><br>

        <br>
        </p>
        <bold>TEAM MEMBERS DETAILS</bold>
        <br><br>
        <table>
            <tr>
                <th>NAME</th>
                <th>TEAM</th>
                <th>STATUS</th>
            </tr>
            <tr>
                <td>Jemimah Sanu</td>
                <td>K8S</td>
                <td>TEAM REP</td>
            </tr>
            <tr>
                <td>Omeh, Chukwuemeka</td>
                <td>K8S</td>
                <td>ACTIVE MEMBER</td>
            </tr>

            <tr>
                <td>Victor Adewoye</td>
                <td>K8S</td>
                <td>ACTIVE MEMBER</td>
            </tr>

            <tr>
                <td>Kenechukwu Nzute</td>
                <td>K8S</td>
                <td>ACTIVE MEMBER</td>
            </tr>

            <tr>
                <td>Luke Ihuoma</td>
                <td>K8S</td>
                <td>ACTIVE MEMBER</td>
            </tr>

            <tr>
                <td>Daniel Taiwo</td>
                <td>K8S</td>
                <td>ACTIVE MEMBER</td>
            </tr>

            <tr>
                <td>David Emmanuel</td>
                <td>K8S</td>
                <td>ACTIVE MEMBER</td>
            </tr>

            <tr>
                <td>Bamidele Idowu</td>
                <td>K8S</td>
                <td>ACTIVE MEMBER</td>
            </tr>

            <tr>
                <td>Udemezue Uchegbu</td>
                <td>K8S</td>
                <td>ACTIVE MEMBER</td>
            </tr>
    </table> 
    <br><br>
    Best regards<br>
    Chukwuemeka<br>
    Team Member
    <br><br>
    </body>
    </html>
    """

    # Plain text alternative version
    plain = """\
    Hello from Chris. The DBA and Data Engineering is Great
    Try out the APIs at Abstract API.
    """

    # Add the different alternative parts in order of increasing complexity
    # starting with the simplest first, i.e. the plain text version first.
    message.attach(MIMEText(plain, "plain"))
    message.attach(MIMEText(html, "html"))

    # Connect with server and send the message
    with smtplib.SMTP_SSL("smtp.gmail.com", port=465, context=ctx) as server:
        server.set_debuglevel(0)
        server.login(sender, password)
        server.sendmail(sender, receiver, message.as_string())

except Exception as e:
    print(f"Error was encountered with following details: {e}")

finally:
    print("==================MAIL SENT SUCCESSFULLY==================")