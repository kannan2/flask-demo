<!-- Copilot instructions for the Flask demo app. Keep concise and actionable. -->
# Copilot guidance for this repository

This repo is a small single-service Flask demo that retrieves remote XML-based data and performs a bank login flow. Use these notes to make change suggestions, tests, and small refactors safely.

**Big Picture:**
- **Service type:** Single-process Flask web app implemented in `app.py` that serves HTML templates from `templates/` and static assets from `static/`.
- **Core flow:** HTTP handlers call helper functions `get_user_id()`, `get_user_profile()`, and `get_formcred()` in `app.py` which perform outbound `requests` calls to CWS and bank endpoints and parse XML responses.

**How to run (project-specific):**
- **Quick start:** Run the repo script: `bash flaskapp-run.sh` (creates `venv`, installs `requirements.txt`, sets `FLASK_APP=app.py`, then runs `flask run &`).
- **Manual:**
  - `python3 -m venv venv`
  - `source venv/bin/activate`
  - `pip install -r requirements.txt`
  - `export FLASK_APP=app.py`
  - `flask run`

**Key files & patterns to inspect when changing behavior:**
- `app.py` — single source of truth: routes, external URLs (CWS_HOST, BANK_AUTHEN_URL), XML templates and parsing. Example: `USR_GET_ID_REQ` and `USR_GET_PROFILE_REQ` string templates are used directly with `requests` and `xml.etree.ElementTree`.
- `flaskapp-run.sh` — project run/install script (creates venv and runs `flask run &`). Use this for local dev starting.
- `requirements.txt` — runtime deps: `requests`, `flask`, `certifi`.
- `templates/` — Jinja templates (`base.html`, `index.html`, `css-example.html`) use Bootstrap CDN and blocks for `login`, `userid`, `formcred`, and radio `env` selection.
- `static/css/style.css` — small CSS used by `css-example.html`.

**Project-specific conventions & gotchas (do not assume defaults):**
- The app frequently uses string-format templated endpoints: `CWS_HOST` is a template that is composed with an environment prefix (see `get_cws_host_for_env`). When changing hosts, update that template consistently.
- SSL verification is explicitly disabled in `get_formcred()` (`verify = False`) — any network tests or stubs should account for this.
- Default form values are embedded in handlers: `/formcred` uses `login_name = 'TW616500'` and `env = 'sit'` when not POSTed. Tests should override these explicitly.
- The code prints and logs but does not configure logging; be conservative when changing logging behavior to avoid noisy output during tests.
- Sensitive endpoints and credentials are hard-coded for demo purposes; avoid committing real secrets and prefer environment variables if adding secret management.

**When modifying network code (safe practices):**
- Add an abstraction or parameter to accept a `requests.Session` or a URL override so unit tests can inject a local test server or mocked responses.
- For XML parsing, tests should use minimal realistic XML payloads matching `USR_GET_ID_REQ` and `USR_GET_PROFILE_REQ` response shapes. The code expects tags like `UserId` and `ItemValue` in the `http://schemas.etrade.com/ETSVC` namespace.
- Avoid running live calls to `CWS_HOST`/bank endpoints during automated runs. Use recorded responses or local stubs.

**Example prompts for code changes:**
- "Refactor `get_user_id()` to accept a `session` parameter and add unit tests that mock the session.post response with a minimal XML body containing `UserId`."
- "Replace `verify=False` in `get_formcred()` with a configurable flag read from environment variables and add a short note in README explaining the implication."

**Where to look for follow-ups:**
- If modifying UI, inspect `templates/base.html` for form blocks named `login`, `userid`, `formcred` used by `index.html`.
- If changing dependency pinning or adding dev tools, update `flaskapp-run.sh` and `requirements.txt` together.

If any section is unclear or you want me to expand with examples or tests, tell me which part to elaborate on.
