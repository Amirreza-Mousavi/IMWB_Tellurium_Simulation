import tellurium as te
import csv
ini1 = '''
 A -> B; kfAB*A;
   B -> A; kbAB*B;
   
   A -> C; kfAC*A;
   C -> A; kbAC*C;
   
   B -> D; kfBD*B;
   D -> B; kbBD*D;
   
   C -> D; kfCD*C;
   D -> C; kbCD*D;
   
   B -> C; kfBC*B;
   C -> B; kbBC*C; 
'''

ini2 = '''
kfAB = 0.5; kbAB = 1;

kfCD = 1; kbCD = 1; 
kfAC = 1; kfBD = 1;

kfBC = 1;kbBC = 1;

kbAC = (kbAB * kbBC * kfAC)/(kfAB * kfBC)
kbBD = (kbBC * kbCD * kfBD)/(kfBC * kfCD)
'''

ini3 = '''
 
   A = 5; B = 5; C = 5; D = 5;
           
   at(time > 10) : A = 10;
   
'''
   

r = te.loada(ini1+ini2+ini3)
r.simulate(0,5,10000)
r.resetAll()
result = r.simulate (0,20,10000)
r.plot()


with open('Desktop/a.csv', 'w') as csvfile:
  writer = csv.writer(csvfile)
  [writer.writerow(r) for r in result]

f=open("Desktop/setup.txt","w")
f.write(ini2)
f.close()
