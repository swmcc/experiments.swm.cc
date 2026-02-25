APP_NAME=experiments.swm.cc
CURRENT_BRANCH := `git branch --show-current`
TODAY := `date +%Y-%m-%d`

GREEN := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
RESET := $(shell tput -Txterm sgr0)

.DEFAULT_GOAL := help

# 🧩 Local Development

local.install: ## Install dependencies
	npm install

local.run: ## Start dev server
	npm run dev

local.build: ## Build the site
	npm run build

local.preview: ## Preview production build
	npm run preview

local.check: ## Run type checking
	npm run astro check

local.clean: ## Clean build artifacts
	rm -rf dist node_modules/.astro

# 📝 Content Creation

content.experiment: ## Create a new experiment
	@read -p "Enter experiment slug (e.g., my-experiment): " slug; \
	read -p "Enter title: " title; \
	read -p "Enter tagline (optional): " tagline; \
	read -p "Enter description: " desc; \
	read -p "Enter repo URL (optional): " repo; \
	read -p "Enter tags (comma-separated, e.g., python,graphs): " tags; \
	mkdir -p "src/content/experiments/$$slug"; \
	filename="src/content/experiments/$$slug/index.md"; \
	echo "---" > $$filename; \
	echo "title: \"$$title\"" >> $$filename; \
	if [ -n "$$tagline" ]; then echo "tagline: \"$$tagline\"" >> $$filename; fi; \
	echo "description: \"$$desc\"" >> $$filename; \
	echo "status: \"active\"" >> $$filename; \
	echo "started: $(TODAY)" >> $$filename; \
	if [ -n "$$repo" ]; then echo "repo: \"$$repo\"" >> $$filename; fi; \
	echo "tags: [\"$${tags//,/\", \"}\"]" >> $$filename; \
	echo "---" >> $$filename; \
	echo "" >> $$filename; \
	echo "Describe your experiment here..." >> $$filename; \
	echo "$(GREEN)Created $$filename$(RESET)"; \
	$$EDITOR $$filename || open $$filename

content.post: ## Add a post to an experiment
	@echo "$(YELLOW)Available experiments:$(RESET)"; \
	ls -1 src/content/experiments/; \
	echo ""; \
	read -p "Enter experiment slug: " exp; \
	if [ ! -d "src/content/experiments/$$exp" ]; then \
		echo "Experiment $$exp not found"; \
		exit 1; \
	fi; \
	last=$$(ls -1 src/content/experiments/$$exp/*.md 2>/dev/null | grep -v index.md | sort | tail -1 | sed 's/.*\///' | sed 's/-.*//' | sed 's/^0*//'); \
	if [ -z "$$last" ]; then next="001"; else next=$$(printf "%03d" $$((last + 1))); fi; \
	read -p "Enter post slug (e.g., implementing-feature): " slug; \
	read -p "Enter title: " title; \
	read -p "Enter PR URL (optional): " pr; \
	read -p "Enter tags (comma-separated, optional): " tags; \
	filename="src/content/experiments/$$exp/$$next-$$slug.md"; \
	echo "---" > $$filename; \
	echo "title: \"$$title\"" >> $$filename; \
	echo "pubDate: $(TODAY)" >> $$filename; \
	if [ -n "$$pr" ]; then echo "pr: \"$$pr\"" >> $$filename; fi; \
	if [ -n "$$tags" ]; then echo "tags: [\"$${tags//,/\", \"}\"]" >> $$filename; fi; \
	echo "---" >> $$filename; \
	echo "" >> $$filename; \
	echo "Write your post here..." >> $$filename; \
	echo "$(GREEN)Created $$filename$(RESET)"; \
	$$EDITOR $$filename || open $$filename

# 📦 Production

production.build: ## Build for production
	npm run build

production.deploy: ## Deploy to Vercel (via git push)
	git push origin main

production.logs: ## View recent GitHub Actions runs
	gh run list --limit 5

# 📖 Help

help: ## Show all available make targets
	@echo "$(GREEN)$(APP_NAME) - Available targets:$(RESET)"
	@grep -E '^[a-zA-Z0-9_.-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "  $(YELLOW)%-20s$(RESET) %s\n", $$1, $$2}'
