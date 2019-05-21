

SrcDir=../../src
ExeDir=../Executables


_SOURCES=AdvReaction.f90
SOURCES = $(patsubst %,$(SrcDir)/%,$(_SOURCES))

PLATFORM := $(shell uname -s)
ifeq  ('$(PLATFORM)', 'Darwin')
   _SOLVERS=$(_SOURCES:.f90=.dylib)
else
   _SOLVERS=$(_SOURCES:.f90=.so)
endif
SOLVERS=$(patsubst %,$(ExeDir)/%,$(_SOLVERS))


$(ExeDir)/%.dylib: $(SrcDir)/%.f90
	elmerf90 $< -o $@
	
$(ExeDir)/%.so: $(SrcDir)/%.f90
	elmerf90 $< -o $@



all: cleanAll grid Test

serial: cleanAll serialGrid serialTest

Test: $(SOLVERS)
	@echo Sensitivity_Beta.sif > ELMERSOLVER_STARTINFO
	mpirun -np 2 ElmerSolver_mpi
grid: 
	ElmerGrid 1 2 mesh2d.grd -partition 2 1 0 2

serialTest: $(SOLVERS)
	@echo Sensitivity_Beta.sif > ELMERSOLVER_STARTINFO
	ElmerSolver
serialGrid: 
	ElmerGrid 1 2 mesh2d.grd
clean:
	rm -f *~

cleanAll:
	rm -f $(ExeDir)/*
	rm -f *~
	rm -f *.dat*
	rm -f *.out
	rm -f *.in
	rm -f mesh2d/*.vtu
	rm -f mesh2d/*.pvtu
