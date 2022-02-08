###Initilization
import tellurium as te
import csv
from matplotlib import pyplot as plt



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
 
   A = 5; B = 5; C = 5; D = 5;
           
   at(time > 10) : A = 10;
   
'''

ini2='''

   kfAB=5; kbAB=2;
   kfAC=1; kbAC=2;
   kfBD=5; kbBD=3;
   kfCD=3; kbCD=1;
   kfBC=10;kbBC=10;
   
'''

###Simulation

r = te.loada(ini1+ini2)
result = r.simulate (0,20,10000)
r.plot() #Just to have the general idea

###Output the plot, results, and the setup info.
plt.savefig("concentrations_vs_time.png")

with open('simulation_result.csv', 'w') as csvfile:
  writer = csv.writer(csvfile)
  [writer.writerow(r) for r in result]

f=open("simulation_setup.txt","w")
f.write(ini2)
f.close()
