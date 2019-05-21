
all: cleanAll grid Reference

Reference: Reference.sif
	@echo Reference.sif > ELMERSOLVER_STARTINFO
	#mpirun -np 2 ElmerSolver_mpi
	ElmerSolver
grid: 
	ElmerGrid 1 2 mesh2d.grd 
	#ElmerGrid 1 2 mesh2d.grd -partition 2 1 0 0


clean:
	rm -f *~

cleanAll: clean
	rm -f *.out
	rm -f *.in
	rm -f *.xy
	rm -f *.dat
	rm -f *.names
	rm -f */*.vtu
