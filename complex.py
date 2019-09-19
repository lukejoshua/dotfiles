class Complex:
    """Complex class, not compatible with python's builtin complex numbers"""
    def __init__(self, a, b):
        self.a, self.b = a, b

    def __hash__(self):
        """hash(self)"""
        return hash((self.a, self.b))

    def __abs__(self):
        """|self|"""
        return (self.a ** 2 + self.b ** 2) ** 0.5

    def __add__(self, z):
        """self + z"""
        try: # in the case of complex + comlplex
            return Complex(self.a + z.a, self.b + z.b)
        except:
            try: # in the case of complex + number
                return Complex(self.a + z, self.b)
            except:
                raise ValueError("Could not add value")
    
    def __radd__(self,z):
        """z + self"""
        return self + z

    def __mul__(self,z):
        """self * z"""
        try: # in the case of complex * complex
            return Complex(self.a * z.a - self.b * z.b, self.b * z.a + self.a * z.b)
        except:
            try: # in the case of complex * x
                return Complex(self.a * z, self.b * z)
            except:
                raise ValueError("Could not multiply value")

    def __rmul__(self, z):
        """z * self"""
        return self * z

    def __str__(self):
        """str(self)"""
        if self.b < 0:
            operator = ""
        else:
            operator = "+"
        return "({:6f}{}{:6f}i)".format(self.a, operator, self.b)

    def __repr__(self):
        return str(self)

    def __eq__(self, z):
        """self == z"""
        try:
            return self.a == z.a and self.b == z.b
        except:
            try:
                return self.a == z and self.b == 0
            except:
                raise ValueError("Could not compare value")

    def re(self):
        """Real component"""
        return self.a

    def im(self):
        """Imaginary component"""
        return self.b
