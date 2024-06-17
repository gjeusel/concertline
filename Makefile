.DEFAULT_GOAL := all

.PHONY: install
install:
	@which uv > /dev/null 2>&1 || (echo "Installing uv..." && curl -LsSf https://astral.sh/uv/install.sh | sh)
	uv pip install -e .[all]
	pre-commit install -t pre-push

.PHONY: format
format:
	ruff check --fix concertline tests/
	ruff format concertline tests/

.PHONY: lint
lint:
	ruff check concertline tests/
	ruff format --check concertline tests/

.PHONY: mypy
mypy:
	mypy concertline

.PHONY: test
test:
	pytest

.PHONY: all
all: lint mypy test

.PHONY: cruft
cruft:
	cruft update --skip-apply-ask --allow-untracked-files --project-dir .

.PHONY: doc
doc:
	mkdocs serve --watch .

.PHONY: clean
clean:
	rm -rf `find . -name __pycache__`
	rm -f `find . -type f -name '*.py[co]' `
	rm -f `find . -type f -name '*.orig' `
	rm -f `find . -type f -name '*~' `
	rm -f `find . -type f -name '.*~' `
	rm -f `find . -type f -name '.*DS_Store'`
	rm -rf .cache
	rm -rf .*_cache
	rm -rf .ropeproject
	rm -rf htmlcov
	rm -rf *.egg-info
	rm -rf .eggs
	rm -f .coverage
	rm -f .coverage.*
	rm -rf build
	rm -rf public
	rm -rf .hypothesis
	rm -rf .profiling
