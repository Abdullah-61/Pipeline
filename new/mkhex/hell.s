    li x8, 10
    li x9, 100
    
gcd:   beq x8, x9, stop 
       blt x8, x9, less 
       sub x8, x8, x9 

less: 
       sub x9, x9, x8 
       j gcd        

stop:  sw x8,8(x0) 

end:   lw x10,8(x0) 
       j end      





