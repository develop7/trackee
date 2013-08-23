VALAC = valac
VALAC_FLAGS = --pkg=gtk+-3.0 --pkg=gdk-3.0 --thread
VALA_FILES = ScreensaverInfo.vala Shooter.vala Main.vala Server.vala
EXE = shooter

.PHONY: all clean

all:	${EXE}

${EXE}:	${VALA_FILES}
	${VALAC} ${VALAC_FLAGS} ${VALA_FILES} --output=${EXE}

clean:
	rm -f ${EXE}
