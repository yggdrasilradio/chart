all: chart

chart: chart.bas
	lwasm -9 -f basic -o /tmp/data.bas chart.asm
	fgrep DATA /tmp/data.bas | sed -e 's/,-1,-1//' -e 's/^[^ ]*//' > chart.dat
	decbpp < chart.bas > /tmp/chart.bas
	decb copy -tr /tmp/chart.bas /media/share1/COCO/drive0.dsk,CHART.BAS
	cat /tmp/chart.bas
	rm -f /tmp/chart.bas data.bas
