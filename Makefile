# Variables
BUILD_FOLDER = build
SJASMPLUS_BINARY = sjasmplus

# ifeq ($(SJASMPLUS_BINARY),)
# 	SJASMPLUS_BINARY = sjasmplus
# else
# 	SJASMPLUS_BINARY = $(SJASMPLUS_BINARY)
# endif

# OS Variables
ifeq ($(OS),Windows_NT)
	CLEAR = cls
	RM = del /Q
	MKDIR = mkdir
	MAKE = mingw32-make
	OS = Windows_NT

	ifeq ($(PROCESSOR_ARCHITECTURE),AMD64)
		TARGET_ARCH = x64
	else ifeq ($(PROCESSOR_ARCHITECTURE),x86)
		TARGET_ARCH = x86
	else
		TARGET_ARCH = unknown
	endif

	ifeq ($(EMULATOR_BINARY),)
		EMULATOR_BINARY = unreal
	endif
	ifeq ($(PROJECT_NAME),)
		PROJECT_NAME = $(shell basename $(OLDPWD))
	endif

else
	CLEAR = clear
	RM = rm -rf
	MKDIR = mkdir -p
	# OS
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Linux)
  		OS = Linux 
		ifeq ($(shell uname -m),aarch64)
			TARGET_ARCH = arm64
		else ifeq ($(shell uname -m),x86_64)
			TARGET_ARCH = x64
		else ifeq ($(shell uname -m),x86)
			TARGET_ARCH = x86
		else
			TARGET_ARCH = unknown
		endif
	endif

	ifeq ($(UNAME_S),Darwin)
 		OS = Darwin
		ifeq ($(shell uname -m),arm64)
			TARGET_ARCH = arm64
		else ifeq ($(shell uname -m),x86_64)
			TARGET_ARCH = x64
		else ifeq ($(shell uname -m),x86)
			TARGET_ARCH = x86
		else
			TARGET_ARCH = unknown
		endif
	endif

	ifeq ($(PROJECT_NAME),)
		PROJECT_NAME = $(shell basename $(PWD))
	endif
endif



# 
BUILD_FILENAME = ${BUILD_FOLDER}/${PROJECT_NAME}

# Targets
all: clean build run


build:
	@${MKDIR} ${BUILD_FOLDER}
	@${RM} ${BUILD_FOLDER}/*
	@${SJASMPLUS_BINARY} --fullpath \
		src/main.asm

run: build
	${EMULATOR_BINARY} -l ${BUILD_FOLDER}/user.l ${BUILD_FILENAME}.sna

clean:
	@${RM} ${BUILD_FOLDER}/

.PHONY: all build run clean
