all: chart

chart: chart.bas
	lwasm -9 -f basic -o /tmp/data.bas chart.asm
	fgrep DATA /tmp/data.bas | sed -e 's/,-1,-1//' -e 's/^[^ ]*//' > chart.dat
	rm -f /tmp/data.bas
	decbpp < chart.bas | tee redistribute/CHART.BAS
	decb copy -tr redistribute/CHART.BAS /media/share1/COCO/drive0.dsk,CHART.BAS
