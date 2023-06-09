from cmath import sqrt
from math import pi
class Shapes:
    def __init__(self, length, width) -> None:
        self.length = length
        self.width = width

    def triangle(self,height):
        area = self.length * height
        return area

    def circle(self, radius):
        area = pi*radius**2
        return area

    def square(self):
        area = self.length**2
        return area
        
shape = Shapes(length=10, width=5)

print(f"The area of triagle is:{round(shape.triangle(height=10), 2)} sq m")
print(f"The area of triagle is:{round(shape.circle(radius=10),2)} sq m")
print(f"The area of triagle is:{round(shape.square(),2)} sq m")


class Quadratic:
    def __init__(self, A,B,C) -> None:
        self.A = A
        self.B = B
        self.C  = C

    def discrminant(self):
        dis = pow(self.B,2)  - 4*self.A*self.C
        disc = f"The discriminant value is: {dis}"
        return disc

    def root(self):
        dis = pow(self.B,2)  - 4*self.A*self.C
        if dis < 0:
            equation_root_x1 = (-self.B + sqrt(dis)) / 2*self.A   
            equation_root_x2 = (-self.B - sqrt(dis)) / 2*self.A

            print(f"The root of quadratic equation X1 = {complex(equation_root_x1)}")
            print(f"The root of quadratic equation X1 = {complex(equation_root_x2)}")
        else:
            equation_root_x11 = (-self.B + sqrt(dis)) / 2*self.A   
            equation_root_x22 = (-self.B - sqrt(dis)) / 2*self.A

            print(f"The root of quadratic equation X1 = {equation_root_x11}")
            print(f"The root of quadratic equation X1 = {equation_root_x22}")

qu = Quadratic(1,5,6)
print(qu.discrminant())
print(qu.root())