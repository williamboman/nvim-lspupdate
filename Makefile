.DEFAULT_GOAL := test

test:
	@export tst=/tmp/lspupdate_test.txt && \
		nvim --headless +'luafile lua/test/util.lua' +q 2> $$tst && \
		[ ! -s $$tst ] && echo Tests passed\! || (cat $$tst; exit 101)

.PHONY: test
