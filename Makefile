.PHONY: resume clean docker-build docker-resume

CC = xelatex
RESUME_SRCS = $(shell find resume -name '*.tex')

DOCKER_IMAGE = awesome-cv-builder
DOCKER_RUN = docker run --rm --user $$(id -u):$$(id -g) -v "$$(pwd)":/doc $(DOCKER_IMAGE)

# Build resume PDF via Docker (default target)
# Does NOT rebuild the Docker image each time — run `make docker-build` after Dockerfile changes
resume: resume.tex $(RESUME_SRCS)
	$(DOCKER_RUN) $(CC) resume.tex

# Build the Docker image (only needs to run once, or after Dockerfile changes)
docker-build:
	docker build -t $(DOCKER_IMAGE) .

# Build resume PDF locally (requires local lualatex installation)
local-resume: resume.tex $(RESUME_SRCS)
	$(CC) resume.tex

clean:
	rm -f resume.pdf resume.aux resume.log resume.out
