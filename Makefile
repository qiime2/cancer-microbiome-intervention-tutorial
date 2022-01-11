default: serve

clean:
	jb clean book/ --all

build: clean
	jb build book/ --all

serve: build
	cd book/_build/html && python -m http.server && cd -
