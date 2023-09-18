
# update the following if you're planning to update to a new version
# make sure to also update the version variable
CCF_UI_ZIP_LINK=https://github.com/hubmapconsortium/ccf-ui/archive/refs/tags/3.7.2.zip
CCF_UI_VERSION=3.7.2

HRA_INSTALL_DIR=/var/wwww/html/apps/hra

# the list of files that will be deployed
RSYNC_FILE_LIST=ccf-ui \
	rui.html

# the downloaded version of CCF_UI
CCF_UI_DOWNLOADED_VERSION=$(shell [ -f .make-ccf-ui-version ] && cat .make-ccf-ui-version )

# a function used for creating the rsync list file
define add_array_to_file
	for folder in $(1); do \
		echo "$$folder" >> $(2); \
	done
endef

$(CCF_UI_VERSION):

.make-ccf-ui-version: $(CCF_UI_VERSION)
	@> .make-ccf-ui-version
	@echo "${CCF_UI_VERSION}" >> .make-ccf-ui-version

.make-rsync-list: $(CCF_UI_VERSION)
	@> .make-rsync-list
	@$(call add_array_to_file,$(RSYNC_FILE_LIST),.make-rsync-list)

clean:
	@rm -rf .make-*
	@rm -rf ccf-ui

# download the dependencies and build the packages if needed
.PHONY: dist
dist: .make-ccf-ui-version
ifeq ($(CCF_UI_DOWNLOADED_VERSION), $(CCF_UI_VERSION))
	$(info ccf-ui ${CCF_UI_VERSION} is already downloaded.)
else
	$(info - downloading ccf-ui ${CCF_UI_VERSION} from ${CCF_UI_ZIP_LINK})
	@curl -L -o ccf-ui.zip "${CCF_UI_ZIP_LINK}"
	@unzip -n -qq ccf-ui.zip
	@rm -rf ccf-ui
	@mv ccf-ui-* ccf-ui
	@rm ccf-ui.zip
endif

# deploy to the given location
.PHONY: deploy
deploy: .make-rsync-list
	$(info - deploying to ${HRA_INSTALL_DIR})
	@rsync -ravz --files-from=.make-rsync-list . $(HRA_INSTALL_DIR)

.PHONY: help usage
help: usage
usage:
	@echo "Usage: make [target]"
	@echo "Available targets:"
	@echo "  dist                   make sure the dependencies are avaibale (might trigger a download)"
	@echo "  deploy                 deploy the files to the given location"
