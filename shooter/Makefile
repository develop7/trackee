VALAC = valac
VALAC_FLAGS = --pkg=gtk+-3.0 --pkg=gdk-3.0 --thread

.PHONY: clean

all:	shooter

shooter:
	${VALAC} ${VALAC_FLAGS} *.vala --output=shooter

clean:
	rm -f shooter
