fileString = malloc(10)
strncpy(fileString,"axc.cmd",10)
taskSpawn "roottask",100,0x1c,30000,root_entry,fileString