import sys
import os
result_dir = './result/';
submit_dir = './submit/';
path = '/afs/cs.stanford.edu/group/brain/scratch9/cgzhu/Whiten/whiten_tie/';
servers = [3,16,6,1,5,9,12,2];
counter = 0;

for winsize in [7,9,11]:
  command = 'whiten';
  prefix = command + '_win_' + str(winsize) + '.sh'
  outputfile = result_dir + prefix+'.output'
  errorfile = result_dir + prefix+'.err'
              
  filename = submit_dir + prefix
  file = open(filename, 'w')
  file.write('#!/bin/bash\n');
  file.write('cd '+path+'\n')
  file.write('uname -a 1> ' + outputfile  + ' 2>'+ errorfile +'\n')
  file.write('matlab -nojvm -nodisplay 1>>' + outputfile + ' 2>>' + errorfile + ' << EOF\n')
  file.write(command+'(\'o\','+str(winsize)+','+'100)\n')
  file.write('exit\n')
  file.write('EOF\n')
  os.system('chmod +x '+filename)
  
  
  print 'qsub -q gorgon -l nodes=gorgon'+str(servers[counter])+'.stanford.edu ' + filename
  counter = counter + 1
  if counter > len(servers)-1:
    counter = 0;
    
