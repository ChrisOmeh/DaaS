import os
from math import pi
print(os.listdir())
print(os.getcwd())

class Shape:
    def __init__(self, length, width):
        self.length = length
        self.width = width


    def areaCircle(self, radius):
        area = round(pi* pow(radius,2),)
        return area

    def areaSquare(self):
        area = round(self.length * self.length,2)
        return area

    def areaRect(self):
        area = round(self.length * self.width,2)
        return area

    def areaTriangle(self, base_length, height):
        area = round(0.5 * base_length * height,2)
        return area

area = Shape(length=10, width=5)
print(f"The area of Circle is: {area.areaCircle(5)} sq. m")    
print(f"The area of Square is: {area.areaSquare()} sq. m")
print(f"The area of Rectangle is: {area.areaRect()} sq. m")   
print(f"The area of the Traingle is: {area.areaTriangle(10,5)} sq. m") 

with open("file_text.txt", 'a') as file:
    file.write("\n"+"The area of Circle is:"+  str(area.areaCircle(10)) +" sq. m" + '\n')
    file.write("The area of Square is:"+  str(area.areaSquare()) +" sq. m" + '\n')
    file.write("The area of Rectangle is:"+  str(area.areaRect()) +" sq. m" + '\n')
    file.write("The area of Triangle is:"+  str(area.areaTriangle(10,5)) +" sq. m" + '\n')
    pass
