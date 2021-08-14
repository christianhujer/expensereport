export PATH:=./venv/bin/:$(PATH)

.PHONY: all
all: verify

.PHONY: verify
verify: lint test

.PHONY: pipeline
pipeline: pip-install verify

.PHONY: pip-install
pip-install:
	pip install -r requirements.txt

.PHONY: test
test: .coverage

.PHONY: lint
lint:
	mypy *.py
	prospector *.py

coverage-reports/unit-test.coverage:
	COVERAGE_FILE=$@ coverage run --omit "venv/*" -m unittest discover

coverage-reports/acceptance-test.coverage:
	COVERAGE_FILE=$@ coverage run --omit "venv/*" -m behave

.coverage: coverage-reports/acceptance-test.coverage coverage-reports/unit-test.coverage
	coverage combine coverage-reports/*.coverage
	coverage report --fail-under 100.0

coverage-reports/coverage-.xml: .coverage
	coverage xml -o coverage-reports/coverage-.xml

.PHONY: sonarqube
sonarqube: coverage-reports/coverage-.xml
	docker run --network host --rm -v "$$(pwd):/usr/src" sonarsource/sonar-scanner-cli -Dsonar.projectKey=gameoflife-python

.PHONY: sonard
## Runs a Sonar server locally.
sonard:
	docker start sonarqube || docker run -d --name sonarqube sonarqube

.PHONY: checkUpdates
checkUpdates:
	pip list --outdated

.PHONY: clean
clean::
	coverage erase
clean::
	$(RM) -r coverage-reports
