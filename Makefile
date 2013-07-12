BINDIR = bin
SRCDIR = src
VALAC = valac
VALAC_FLAGS = --pkg gtk+-3.0 --pkg gdk-3.0

all:	shooter

shooter:
	${VALAC} ${VALAC_FLAGS} ${SRCDIR}/shooter.vala -o ${BINDIR}/shooter

clean:
	rm -f ${BINDIR}/shooter

