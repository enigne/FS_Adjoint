#!/bin/bash -l

# predefined variables
Nx=(1050)
#xWinL=(250 500 700 900)
#xWinR=(251 501 701 901)

xWinL=(250 500 600 700 800 850 900 925 950 975 1000 1010 1020)
xWinR=(251 501 601 701 801 851 901 926 951 976 1001 1011 1021)

#xWinL=(700)
#xWinR=(701)

DATE=`date +%Y%m%d`
dataPath="/home/chenggong/Uppsala/myResearch/pythonCodes/DATA/${DATE}"

# Loop to Submit jobs
for((i=0;i<${#Nx[@]};i++)) do
	for((j=0;j<${#xWinL[@]};j++)) do
		# Temp variables
		outFolder=u_S_response_nx${Nx[i]}_x${xWinL[j]}_${xWinR[j]}
		
		echo "prepare for ${outFolder}"
		# Create work folders
		mkdir -p ${outFolder}
		mkdir -p ${dataPath}/${outFolder}
		cd ${outFolder}
		
		# copy SIF and script files
		cp ../Scripts/Sensitivity_Beta.sif ./
		cp ../Scripts/Makefile ./
		cp ../Scripts/mesh2d.grd ./
		
		# Setup:
		# mesh2d.grd
		sed -i "s/#NX#/${Nx[i]}/" mesh2d.grd
		# Sensitivity_Beta.sif
		sed -i "s/#NX#/${Nx[i]}/" Sensitivity_Beta.sif
		sed -i "s/#XWINL#/${xWinL[j]}/" Sensitivity_Beta.sif
		sed -i "s/#XWINR#/${xWinR[j]}/" Sensitivity_Beta.sif

		echo "....job initialized  ${outFolder}"
		make
		echo "....job finished  ${outFolder}"
		cp u_respons* ${dataPath}/${outFolder}
		echo ".... copy data to ${dataPath}/${outFolder}"
		cd ..
	done
done


