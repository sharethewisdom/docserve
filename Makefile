.PHONY: install

install:
	@install -Dm755 libalpm/scripts/docserve_update.sh $(DESTDIR)/usr/share/libalpm/scripts/docserve_update.sh
	@install -Dm644 libalpm/hooks/docserve.hook $(DESTDIR)/usr/share/libalpm/hooks/docserve.hook
	@install -Dm644 nginx/nginx-doc.conf $(DESTDIR)/usr/share/docserve/nginx-doc.conf
	@install -Dm644 main.css             $(DESTDIR)/usr/share/docserve/main.css
	@install -Dm644 keyboard-nav.js      $(DESTDIR)/usr/share/docserve/keyboard-nav.js
	# @install -Dm644 LICENSE       $(DESTDIR)/usr/share/licenses/$(PROGNM)
