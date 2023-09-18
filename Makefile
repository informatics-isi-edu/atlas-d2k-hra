
# update the following if you're planning to update to a new version
# make sure the code is referring to the same folder name
RELEASE_LINK=https://github.com/hubmapconsortium/ccf-ui/archive/refs/tags/3.7.2.zip
CCF_UI_FOLDER=ccf-ui-3.7.2

HRA_INSTALL_DIR=/var/wwww/html/apps/hra

# the list of files that will be deployed
RSYNC_FILE_LIST=${CCF_UI_FOLDER} \
	rui.html

# check if the folder exists or not
CCF_UI_FOLDER_EXISTS=$(shell [ -d "./${CCF_UI_FOLDER}" ] && echo 1 || echo 0)

# a function used for creating the rsync list file
define add_array_to_file
	for folder in $(1); do \
		echo "$$folder" >> $(2); \
	done
endef

.make-rsync-list:
	$(info - creating .make-rsync-list)
	@> .make-rsync-list
	@$(call add_array_to_file,$(RSYNC_FILE_LIST),.make-rsync-list)


# download the dependencies and build the packages if needed
.PHONY: dist
dist:
ifeq ($(CCF_UI_FOLDER_EXISTS), 1)
	$(info - ${CCF_UI_FOLDER} already download.)
else
	$(info - downloading ${CCF_UI_FOLDER})
	@curl -L -o ${CCF_UI_FOLDER}.zip "${RELEASE_LINK}"
	@unzip -n -qq ${CCF_UI_FOLDER}.zip
	@rm ${CCF_UI_FOLDER}.zip
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
