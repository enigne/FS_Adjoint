
all: cleanAll Reference post

Reference: Reference.sif
	@echo Reference.sif > ELMERSOLVER_STARTINFO
	ElmerSolver
post:
	@python3 extractSurf.py
	@python3 extractGL.py
	mv UGL.dat ../Data/
	mv VGL.dat ../Data/
	mv UDEM.dat ../Data/
	mv zsDEM.dat ../Data/
	mv zbDEM.dat ../Data/
	mv Calving.dat ../Data/
	
	mkdir -p bcData/
	cp reference.dat* bcData/
	@python3 extractBeta.py
	mv beta.dat ../Data/
clean:
	rm -f *~

cleanAll: clean
	rm -f *.out
	rm -f *.in
	rm -f *.xy
	rm -f *.dat
	rm -f *.names
	rm -f */*.vtu
	rm -f bcData/*
