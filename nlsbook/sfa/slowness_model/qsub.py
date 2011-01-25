import sys
import os
result_dir = './result/';
submit_dir = './submit/';
cdpath = '/afs/cs.stanford.edu/u/qiaozhao/work/qsubtest';
finpath = './';
fin = '1u.avi';
#finpath = '/afs/cs.stanford.edu/group/brain/scratch4/Hollywood2/AVIClips/';
#fin = 'actioncliptest00001.avi'
foutpath = './48row/';
fout = '1.avi'
servers = [2,3,4];
counter = 0;

for winsize in [1]:
  command = 'resizevideo(\''+finpath+fin+'\','+str(48)+',\''+foutpath+fout+'\')';
  prefix = str(winsize) + '.sh'
  outputfile = result_dir + prefix+'.output'
  errorfile = result_dir + prefix+'.err'
              
  filename = submit_dir + prefix
  file = open(filename, 'w')
  file.write('#!/bin/bash\n');
  file.write('cd '+cdpath+'\n')
  file.write('uname -a 1> ' + outputfile  + ' 2>'+ errorfile +'\n')
  file.write('matlab -nojvm -nodisplay 1>>' + outputfile + ' 2>>' + errorfile + ' << EOF\n')
  file.write(command+'\n')
  file.write('exit\n')
  file.write('EOF\n')
  os.system('chmod +x '+filename)
  
  
  print 'qsub -q yggdrasil -l nodes=yggdrasil'+str(servers[counter])+'.stanford.edu ' + filename
  counter = counter + 1
  if counter > len(servers)-1:
    counter = 0;
    
