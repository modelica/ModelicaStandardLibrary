allClasses = dict([(c.strip(),0) for c in open("all.classes","r").readlines() if c.strip()])
for line in open("models.uses", "r").readlines():
  line = line.strip().strip('"')
  if "" == line:
    continue
  if line not in allClasses.keys():
    continue
  allClasses[line] += 1

for cl in sorted(allClasses.keys(), key = lambda cl: (allClasses[cl],cl)):
  print("%d %s" % (allClasses[cl],cl))
