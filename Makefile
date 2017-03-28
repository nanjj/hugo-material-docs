all: build

build: config.toml themes
	mkdir -p static content
	hugo
	git add .

clean:
	rm -rf fonts images javascripts stylesheets index.html index.xml
	find . -type f -name index.html -exec dirname {} \; | cut -d/ -f2 | sort -u| grep -v '\.' | grep -v "themes" | xargs rm -rf

migrate:
	find content -type f -name index.md | while read line; do mv $$line $$(dirname $$line)/_index.md; done

config.toml:
	cp themes/hugo-material-docs/exampleSite/config.toml config.toml

themes:
	git remote | grep nanjj || git remote add nanjj "https://github.ibm.com/nanjj/hugo-material-docs"
	git fetch nanjj master
	git checkout nanjj/master -- themes Makefile hugo.bats .travis.yml content/sitemap.md

check:
	bash ./check.bash
