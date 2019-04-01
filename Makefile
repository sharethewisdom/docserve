.PHONY: install

install:
	@install -Dm755 libalpm/scripts/docserve_update.sh $(DESTDIR)/usr/share/libalpm/scripts/docserve_update.sh
	@install -Dm644 libalpm/hooks/docserve.hook $(DESTDIR)/usr/share/libalpm/hooks/docserve.hook
	@install -Dm644 nginx/nginx-doc.conf $(DESTDIR)/usr/share/doc/docserve/nginx-doc.conf
	# @install -Dm644 LICENSE       $(DESTDIR)/usr/share/licenses/$(PROGNM)
