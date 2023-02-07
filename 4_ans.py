import itertools
for i in list(itertools.permutations(["ab", "cd", "ef"])):
    print(''.join(i))