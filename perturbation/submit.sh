#!/bin/bash -l

# predefined variables
Nx=(800)
x0=(95)
w=(10)
dbeta=(1)

DATE=`date +%Y%m%d`
dataPath="/home/chenggong/Uppsala/myResearch/pythonCodes/DATA/${DATE}"

# Loop to Submit jobs
for((i=0;i<${#Nx[@]};i++)) do
	for((j=0;j<${#x0[@]};j++)) do
		# Temp variables
		tag=`printf x%03d_w%03d_d%03d ${x0[j]} ${w[j]} ${dbeta[j]}`
		outFolder=perturbation
		echo "prepare for ${outFolder}"
			
		# Create work folders
		mkdir -p ${outFolder}
		mkdir -p ${dataPath}/${outFolder}
		cd ${outFolder}
		
		# copy SIF and script files
		cp ../Scripts/Reference.sif ./
		cp ../Scripts/Makefile ./
		cp ../Scripts/mesh2d.grd ./
		cp ../Scripts/perturb.py ./
		
		# Generate perturbation
		sed -i "s/#X0#/${x0[j]}/" perturb.py
		sed -i "s/#W#/${w[j]}/" perturb.py
		sed -i "s/#DBETA#/${dbeta[j]}/" perturb.py
		python perturb.py
		# Setup:
		# mesh2d.grd
		sed -i "s/#NX#/${Nx[i]}/" mesh2d.grd
		# Reference.sif
		#sed -i "s/#NX#/${Nx[i]}/" Reference.sif
		sed -i "s/#TAG#/${tag}/" Reference.sif

		echo "....job initialized  ${outFolder}"
		make		
		echo "....job finished  ${outFolder}"
		cp perturbation* ${dataPath}/${outFolder}
		echo ".... copy data to ${dataPath}/${outFolder}"
		cd ..
	done
done


