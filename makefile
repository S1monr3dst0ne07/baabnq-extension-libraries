
#config:
DEV_PATH := $(shell pwd)
WORK_PATH := /data/dev/ext-feature-prob/
TARGET := tests/testProb.baabnq

#these are in path:
COMPILER := c
VIRTMACH := v

#internal
OUT := /tmp/build.s1
TARGET_PATH := $(DEV_PATH)/$(TARGET)

lint-no-make-print:
	make -s -C $(DEV_PATH) lint

lint:
	find $(DEV_PATH) -type f -name "*.baabnq" | entr -c make -C $(DEV_PATH) run

run:
	echo "info"
	echo "	dev    path: $(DEV_PATH)"
	echo "	work   path: $(WORK_PATH)"
	echo "	target path: $(TARGET_PATH)"
	echo ""

	-test -f $(OUT) && rm $(OUT)
	echo ""
	make -C $(DEV_PATH) build
	echo ""
	-test -f $(OUT) && $(VIRTMACH) -f $(OUT) -u Test
	echo ""

debug: build
	$(VIRTMACH) -f $(OUT) -u Test -U


build: $(TARGET_PATH)
	cd $(WORK_PATH) && $(COMPILER) -i $(TARGET_PATH) -o $(OUT)


