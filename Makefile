SUBDIRS = shooter

.PHONY: subdirs $(SUBDIRS)

subdirs: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@

clean:
	-for d in $(SUBDIRS); do $(MAKE) --directory=$$d clean; done
