#!/bin/bash

#############################################################################
# send_cmd_to_pdu_ex pduNo outlet cmd
#############################################################################
send_cmd_to_pdu_ex()
{
	pdu_on=1
	pdu_off=2
	pdu_reset=3
	
	pdu_no=$1
	outlet=$2
	pdu_op=$3
	pdu_ip=$(grep -P "^(PDU$pdu_no).*" $OPENLAB_CONF_DIR/$PDU_INFO_FILE | grep -Po "(?<=ip=)([^,]*)")
	eval op=\$pdu_$pdu_op
	exec ap7921-control $pdu_ip $outlet $op
}

#############################################################################
# pdu_on pduNo outlet
#############################################################################
pdu_on()
{
	(send_cmd_to_pdu_ex $@ on)
}

#############################################################################
# pdu_off pduNo outlet
#############################################################################
pdu_off()
{
	(send_cmd_to_pdu_ex $@ off)
}

#############################################################################
# pdu_reset pdu outlet
#############################################################################
pdu_reset()
{
	(send_cmd_to_pdu_ex $@ reset)
}

#############################################################################
# pdu_power pduNo outlet op(on/off/reset)
#############################################################################
pdu_power()
{
	(send_cmd_to_pdu_ex $@)
}
