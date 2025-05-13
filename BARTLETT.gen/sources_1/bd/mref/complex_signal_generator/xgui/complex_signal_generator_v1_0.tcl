# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "FFT_Size" -parent ${Page_0}
  ipgui::add_param $IPINST -name "FUNC_TYPE" -parent ${Page_0}


}

proc update_PARAM_VALUE.FFT_Size { PARAM_VALUE.FFT_Size } {
	# Procedure called to update FFT_Size when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FFT_Size { PARAM_VALUE.FFT_Size } {
	# Procedure called to validate FFT_Size
	return true
}

proc update_PARAM_VALUE.FUNC_TYPE { PARAM_VALUE.FUNC_TYPE } {
	# Procedure called to update FUNC_TYPE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FUNC_TYPE { PARAM_VALUE.FUNC_TYPE } {
	# Procedure called to validate FUNC_TYPE
	return true
}


proc update_MODELPARAM_VALUE.FFT_Size { MODELPARAM_VALUE.FFT_Size PARAM_VALUE.FFT_Size } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FFT_Size}] ${MODELPARAM_VALUE.FFT_Size}
}

proc update_MODELPARAM_VALUE.FUNC_TYPE { MODELPARAM_VALUE.FUNC_TYPE PARAM_VALUE.FUNC_TYPE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FUNC_TYPE}] ${MODELPARAM_VALUE.FUNC_TYPE}
}

