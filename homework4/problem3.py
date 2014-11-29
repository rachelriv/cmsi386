def find_minimum(minList, minNum=None):
    if len(minList) == 0:
        return minNum
    else:
        num = min(minNum, minList[0]) if minNum is not None else minList[0]
        return find_minimum(minList[1:], num)
