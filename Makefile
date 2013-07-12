VALAC_FLAGS = --pkg gtk+-3.0 --pkg gdk-3.0

all:	shooter

shooter:
	valac ${VALAC_FLAGS} shooter.vala -o shooter

clean:
	rm -f shooter