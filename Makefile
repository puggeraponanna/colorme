.PHONY: all build venv apply clean

VENV = venv
PYTHON = $(VENV)/bin/python3
PIP = $(VENV)/bin/pip

all: build

$(VENV)/bin/activate:
	python3 -m venv $(VENV)
	$(PIP) install PyYAML

venv: $(VENV)/bin/activate

build: venv
	$(PYTHON) builder.py

apply: build
	@chmod +x apply.sh
	./apply.sh $(scheme)

clean:
	rm -rf output/
	rm -rf __pycache__/
