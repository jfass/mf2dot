
tmp1 : in.data  ## tool1a,1b
	touch tmp1

tmp2 : in.data  ## tool2
	touch tmp2

out : tmp1 tmp2  ## combinertool
	touch out


