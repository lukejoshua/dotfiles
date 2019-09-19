max_cardinality = 5

isSubset = lambda X,Y: (X | Y) == Y

for cardinality in range(1,max_cardinality + 1):
    for subset in range(2**(2**cardinality)): # each subset of the powerset of {x_1, x_2, ... , x_n}
        # if a bit in subset is set, the corresponding subsubset is included in subset
        if subset ^ 1: continue # stop if the 0-th bit is not set (subset contains emptyset)
        #  now get every set bit of subset
        subset_cardinality = 2 ** cardinality
        for subsubset1 in range(subset_cardinality):
            if not (subset & (1 << subsubset1)): continue # if not a subset, don't care
            for subsubset2 in range(subset_cardinality):
                if not (subset & (1 << subsubset2)): continue# if not subset don't care
                intersection = subsubset1 & subsubset2
                if not (subset & (1 << intersection)): continue # if their intersection isnt in filter, don't care
        # for each 