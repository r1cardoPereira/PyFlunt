TEST_TARGET=teste.py
POETRY = poetry run
FLAKE8_FLAGS = --ignore=W503,E501
ISORT_FLAGS = --profile=black --lines-after-import=2


## @ instalacao
.PHONY: instalar
instalar: ## instala programa usando poetry, poetry precisa estar instalado
	poetry install

## @ programa
.PHONY: rodar
rodar: ## roda programa
	${POETRY}  sample

## @ testes
.PHONY: teste cobertura
teste: ## Roda teste
	${POETRY} pytest
cobertura: ##roda cobertura de testes
	${POETRY} pytest --cov=. --cov-report=html

## @ analise
.PHONY: lint_black flake mypy lint_isort analise
lint_black:
	${POETRY} black --check flunt
flake:
	${POETRY} flake8 ${FLAKE8_FLAGS} flunt
mypy:
	${POETRY} mypy flunt
lint_isort:
	${POETRY} isort ${ISORT_FLAGS} --check flunt
analise: lint_black flake mypy lint_isort ## roda analise estatica: black, flake, mypy e isort

## @ formatacao
.PHONY: black isort formatar
black:
	${POETRY} black flunt
isort:
	${POETRY} isort ${ISORT_FLAGS} flunt
dockstyle:
	${POETRY} pydocstyle flunt
formatar: isort black dockstyle ## roda formatacao nos arquivos da pasta usando black e isort

.PHONY: ajuda
ajuda:
	@${POETRY} python help.py