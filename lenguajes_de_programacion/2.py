
#it returns a list with the sums of the rows
def row_sum(a):
    results = []
    for i in range(len(a)):
        results.append(sum(a[i][j] for j in range(len(a[i]))))
    return results



#takes a list the list given by row_sum and sums its elements
def els_sum(a):
    return sum(row_sum(a))



def diag_subs(a):
    n = len(a)
    diagonal = sum(a[i][i] for i in range(n))
    diagonal_inv = sum(a[i][n-i-1] for i in range(n))
    return diagonal - diagonal_inv



#Producer of the odd elements.
def odd_mul(a):
    n = len(a)
    acc = 1
    for i in a:
        for j in i:
            if (j%2)!=0:
                acc*=j
    return acc
