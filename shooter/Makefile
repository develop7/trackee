BINDIR = ../bin
SRCDIR = .
VALAC = valac
VALAC_FLAGS = --pkg=gtk+-3.0 --pkg=gdk-3.0 --thread

all:	shooter

shooter:
	${VALAC} ${VALAC_FLAGS} ${SRCDIR}/shooter.vala --output=${BINDIR}/shooter

clean:
	rm -f ${BINDIR}/shooter

