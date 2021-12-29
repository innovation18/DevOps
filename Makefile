setup:
	python3 -m venv ~/.devops
	
lint:
	pylint --load-plugins pylint_flask --disable=R,C flask_app/*.py nlib

lint-circleci:                                                              
	pylint --output-format=parseable --load-plugins pylint_flask --disable=R,C flask_app/*.py nlib

test:
	@cd tests; pytest -vv --cov-report term-missing --cov=web --cov=nlib test_*.py

install:
	pip install -r requirements.txt

start-api:
	#sets PYTHONPATH to directory above, would do differently in production
	cd flask_app && PYTHONPATH=".." python web.py

create-docker-image:
	docker build --tag=api .

run-container:
	docker run -p 8000:5001 api

all: install lint test create-docker-image run-container
