import numbers
from sre_constants import AT_UNI_BOUNDARY
from tkinter import E


class Maths:
  def __init__(self, number1, number2):
    self.number1 = number1
    self.number2 = number2

  def add(self):
    add = self.number1 + self.number2
    return add

  def sub(self):
    if self.number1 < self.number2:
      sub = self.number1 - self.number2
      print(f"The result of {self.number1} - {self.number2} is: {sub}")
    else:
      sub = self.number2-self.number1
      print(f"The result of {self.number2} - {self.number1} is: {sub}")

  def mul(self):
    mul =  self.number1 * self.number2
    return mul

  def divide(self):
    if self.number1 >= self.number2:
      divide = self.number1 / self.number2
      print(f"The result of the division is: {divide}")
    elif self.number2 >= self.number1:
      divide = self.number2 / self.number1
      print(f"The result of the division is: {divide}")
    else:
      raise ZeroDivisionError

maths = Maths(60,20)
print(f"The result of the addition is: {maths.add()}")
print(maths.sub())
print(f"The result of the multiplication is: {maths.mul()}")
print(maths.divide())


import pandas as pd
dic = dict(name = ['John', 'Chris'],
           Age= [12,45] )

df = pd.DataFrame.from_dict(dic)
print(df.head())