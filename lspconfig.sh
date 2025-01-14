#!/bin/bash

LSPCONFIG=${LSPCONFIG:-~/.config/nvim/pack/plugins/opt/nvim-lspconfig}
NEWCFG=$(comm -3 <(grep -o -P '^- \[(\K.*)\]\(.*\)$' ${LSPCONFIG}/CONFIG.md |cut -f1 -d]|sort) \
        <(sed -n '/local config/,/})$/p' fnl/lspupdate/config.fnl|cut -f8 -d" "|grep ^:|cut -f2 -d:|sort))

[ -z "${NEWCFG}" ] && echo All good, we''re up to date\! || \
       echo -e "New LSP configs:\n${NEWCFG}"
