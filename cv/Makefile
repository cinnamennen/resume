.PHONY: resume coverletter clean docker-build local-resume local-coverletter

CC = xelatex
RESUME_SRCS = $(shell find resume -name '*.tex')

DOCKER_IMAGE = awesome-cv-builder
DOCKER_RUN = docker run --rm --user $$(id -u):$$(id -g) -v "$$(pwd)":/doc -e TEXINPUTS="./vendor/awesome-cv//:" $(DOCKER_IMAGE)

# Build resume PDF via Docker (default target)
# Does NOT rebuild the Docker image each time — run `make docker-build` after Dockerfile changes
resume: resume.tex $(RESUME_SRCS) vendor/awesome-cv/awesome-cv.cls
	$(DOCKER_RUN) $(CC) resume.tex

# Build cover letter PDF via Docker
coverletter: coverletter.tex $(RESUME_SRCS) vendor/awesome-cv/awesome-cv.cls
	$(DOCKER_RUN) $(CC) coverletter.tex

# Build the Docker image (only needs to run once, or after Dockerfile changes)
docker-build:
	docker build -t $(DOCKER_IMAGE) .

# Build resume PDF locally (requires local xelatex installation)
local-resume: resume.tex $(RESUME_SRCS) vendor/awesome-cv/awesome-cv.cls
	TEXINPUTS="./vendor/awesome-cv//:" $(CC) resume.tex

# Build cover letter PDF locally (requires local xelatex installation)
local-coverletter: coverletter.tex $(RESUME_SRCS) vendor/awesome-cv/awesome-cv.cls
	TEXINPUTS="./vendor/awesome-cv//:" $(CC) coverletter.tex

clean:
	rm -f resume.pdf resume.aux resume.log resume.out coverletter.pdf coverletter.aux coverletter.log coverletter.out
