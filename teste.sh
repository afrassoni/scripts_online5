#!/bin/sh
source /opt/modules/default/etc/modules.sh
module swap tupa aux
cat << EOF >> teste.lixo
echo JOAO
EOF

module list
