def odd_fibonacci(m):
    l = []
    if m <=0:
        pass
    else:
        current = 0
        nex = 1
        l.append(1)
        while len(l)<m:
            val = current + nex
            if val%2 != 0:
                l.append(val)
            current = nex
            nex = val
    return l
