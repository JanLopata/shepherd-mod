# Makefile for compiling the mod

# Variables
VINTAGE_STORY_PATH := /home/hanz/ApplicationData/vintagestory
LIB_PATH := $(VINTAGE_STORY_PATH)/Lib
DEPLOYMENT_PATH := $(VINTAGE_STORY_PATH)/Mods
ASSETS_DIR := assets
DISTRIBUTE_DIR := distribute
ZIP_FILE := shepherd_mod.zip
DLL_NAME := shepherdmod.dll
REFERENCES := -r:$(LIB_PATH)/../VintagestoryLib.dll \
	      -r:$(LIB_PATH)/../VintagestoryAPI.dll \
	      -r:$(LIB_PATH)/Newtonsoft.Json.dll \
	      -r:$(LIB_PATH)/cairo-sharp.dll

SRC_FILES := src/ShepherdMod.cs

# Build target
build:
	mcs ${REFERENCES} \
	    -target:library \
	    -out:$(DLL_NAME) $(SRC_FILES)

# Deploy target
deploy: build
	@echo "Creating distribution directory..."
	mkdir -p $(DISTRIBUTE_DIR)
	@echo "Copying assets..."
	cp -r $(ASSETS_DIR) $(DISTRIBUTE_DIR)
	@echo "Copying DLL file..."
	cp $(DLL_NAME) $(DISTRIBUTE_DIR)
	@echo "Copying modinfo.json"
	cp modinfo.json $(DISTRIBUTE_DIR)
	@echo "Zipping the distribution directory..."
	cd $(DISTRIBUTE_DIR) && zip -r ../$(ZIP_FILE) .
	@echo "Copying the zip file"
	cp $(ZIP_FILE) $(DEPLOYMENT_PATH)
	@echo "Deployment completed."


# Clean target
clean:
	rm -f $(DLL_FILE)
	rm -rf $(DISTRIBUTE_DIR)
	rm -f $(ZIP_FILE)


