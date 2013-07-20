VALAC = valac
VALAC_FLAGS = --pkg=gtk+-3.0 --pkg=gdk-3.0 --thread
VALA_FILES = ScreensaverInfo.vala shooter.vala Main.vala

.PHONY: clean

all:	shooter

shooter:
	${VALAC} ${VALAC_FLAGS} ${VALA_FILES} --output=shooter

clean:
	rm -f shooter
