.PHONY: install

install:
	@install -Dm755 libalpm/scripts/docserve_update.sh $(DESTDIR)/usr/share/libalpm/scripts/docserve_update.sh
	@install -Dm644 libalpm/hooks/docserve.hook $(DESTDIR)/usr/share/libalpm/hooks/docserve.hook
	@install -Dm644 systemd/docserve.service    $(DESTDIR)/usr/lib/systemd/system/docserve.service
	@install -Dm644 nginx/docserve.conf         $(DESTDIR)/usr/share/docserve/docserve.conf
	@install -Dm644 docserve/main.css           $(DESTDIR)/usr/share/docserve/main.css
	@install -Dm644 docserve/keynav.js          $(DESTDIR)/usr/share/docserve/keynav.js
	@install -Dm644 README.md                   $(DESTDIR)/usr/share/docserve/README.md
	@install -Dm644 LICENSE              $(DESTDIR)/usr/share/licenses/docserve
