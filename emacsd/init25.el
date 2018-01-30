;; PROXY
(setq url-proxy-services
      '(("no_proxy" . "^\\(localhost\\|10.*\\)")
	("http" . "www-proxy.statoil.no:80")
	("https" . "www-proxy.statoil.no:80")))


;; ===================================MELPA===================================
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
