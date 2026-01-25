VENV=.venv
PY=python
PIP=pip
PYTEST=pytest
UVICORN=uvicorn

# Choose a python executable. Prefer python3.11 if present, else fall back to python3.
PYTHON ?= python3.11

init:
	@echo "==> Removing existing venv"
	@rm -rf $(VENV)
	@echo "==> Creating venv with: $(PYTHON)"
	$(PYTHON) -m venv $(VENV) && source $(VENV)/bin/activate
	@echo "==> Upgrading pip tooling"
	$(PY) -m pip install -U pip setuptools wheel
	@echo "==> Purging pip cache (avoids stale/broken wheel paths on macOS)"
	$(PY) -m pip cache purge || true
	@echo "==> Installing requirements (no cache)"
	$(PY) -m pip install --no-cache-dir -r requirements.txt
	@echo "==> Done. Using: $$($(PY) -V)"

test:
	.venv/bin/python -m unittest discover -s app/tests

run:
	$(UVICORN) app.main:app --reload

resetdb:
	rm -f app.db
	$(PY) -m app.db.init_db

clean:
	rm -rf $(VENV) app.db .pytest_cache __pycache__