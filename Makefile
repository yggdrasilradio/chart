all: chart

chart: chart.bas
	lwasm -9 -f basic -o /tmp/data.bas chart.asm
	fgrep DATA /tmp/data.bas | sed -e 's/,-1,-1//' -e 's/^[^ ]*//' > chart.dat
	decbpp < chart.bas > /tmp/chart.bas
	decb copy -tr /tmp/chart.bas /media/share1/COCO/drive0.dsk,CHART.BAS
	mv /tmp/chart.bas redistribute/CHART.BAS
	rm -f /tmp/data.bas
