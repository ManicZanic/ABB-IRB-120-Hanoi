fileString = malloc(20)
strncpy(fileString,"/ram0/servo.cmd",20)
taskSpawn "roottask",100,0x1000000,30000,root_entry,fileString