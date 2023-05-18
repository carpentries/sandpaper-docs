.PHONY : serve
HOST ?= 127.0.0.1
PORT ?= 3435

serve :
	R -e 'sandpaper::serve(quiet = FALSE, host = "$(HOST)", port = "$(PORT)")'
