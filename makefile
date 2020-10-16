JEKYLL_VERSION=3.8

build:
	docker build . -t charliedalyio

serve: build
	docker run --rm \
	--volume="$(PWD):/app" \
	--workdir /app \
	-p 4000:4000 \
	-it charliedalyio \
	jekyll serve --drafts

# serve:
# 	docker run --rm \
# 	--volume="$(PWD):/srv/jekyll" \
# 	-p 4000:4000 \
# 	-it jekyll/jekyll:$(JEKYLL_VERSION) \
# 	jekyll serve --drafts

shell: build
	docker run --rm \
	--volume="$(PWD):/app" \
	-p 4000:4000 \
	-it charliedalyio bash

serve-no-drafts:
	docker run --rm \
	--volume="$(PWD):/srv/jekyll" \
	-p 4000:4000 \
	-it jekyll/jekyll:$(JEKYLL_VERSION) \
	jekyll serve

define CD_PREFIX
---
layout: none
title: Resume
permalink: /resume/
order: 0
---
endef

export CD_PREFIX

resume:
	cd jsonresume; npm run export; cd ../ && \
	cp ./jsonresume/resume.pdf ./assets/resume.pdf && \
	cp ./jsonresume/resume.html ./assets/resume.html && \
	cp ./jsonresume/resume.pdf ~/src/datadyneltd.github.io/assets/cv.pdf
