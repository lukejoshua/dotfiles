class Charge:
    """A charged particle"""

    def __init__(self, q, x, y):
        """
        :param q: charge of particle in Coulombs.
        :param x: x coordinate of particle.
        :param y: y coordinate of particle.
        """
        self.q, self.x, self.y = q, x, y

    def __str__(self):
        """Returns a string of the form "q @ (x, y)"""
        return "{} @ ({}, {})".format(q, x, y)

    def __repr__(self):
        return str(self)

    def potential_at(self, x, y):
        """
        According to Coulomb's law, the electric potential at a point
        due to a charge is given by

        V = kq/r

        where q is the charge value, r is the distance of the point to
        the charge, and k = 8.99 x (10^9) N(m^2)/(C^2)

        - All distances are assumed to be meters
        """
        dx = self.x - x
        dy = self.y - y
        if dx == 0 and dy == 0:
            raise ValueError("Evaluating potential at zero distance") 
        return 8.99e9 * self.q / ((dx**2 + dy**2) ** 2)

    def __eq__(self, charge):
        return self.q == charge.q

    def __ne__(self, charge):
        return self.q != charge

    def __ge__(self, charge):
        return self.q >= charge.q

    def __lt__(self, charge):
        return self.q < charge.q

    def __gt__(self, charge):
        return self.q > charge.q

    def __le__(self, charge):
        return self.q <= charge.q

if __name__ == "__main__":
    C = Charge(1, 0, 0)
    print(C.potential_at(1, 1))