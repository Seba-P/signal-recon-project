
`ifndef _AVALON_ST_VIP_CONFIG_SVH_
`define _AVALON_ST_VIP_CONFIG_SVH_

class avalon_st_vip_config #(avalon_st_inst_spec_t INST_SPEC = '{ { 16, MODPORT_SINK }}) extends uvm_object;
  `uvm_object_params_utils(avalon_st_vip_config #(INST_SPEC))

  avalon_st_agent_config #(INST_SPEC) m_agent_config[$];
  int                                 m_agent_num = 0;

  // Standard UVM Methods:
  extern function new(string name = "avalon_st_vip_config");
endclass: avalon_st_vip_config

function avalon_st_vip_config::new(string name = "avalon_st_vip_config");
  super.new(name);
endfunction

`endif // _AVALON_ST_VIP_CONFIG_SVH_
