
`ifndef _AVALON_ST_VIP_SVH_
`define _AVALON_ST_VIP_SVH_

class avalon_st_vip #(avalon_st_inst_spec_t INST_SPEC = '{ { 16, MODPORT_SINK }}) extends uvm_env;
  `uvm_component_params_utils(avalon_st_vip #(INST_SPEC))

  avalon_st_vip_config #(INST_SPEC) m_config;
  avalon_st_agent #(INST_SPEC)      m_agent[string];

  // Standard UVM Methods:
  extern function new(string name = "avalon_st_vip", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
endclass: avalon_st_vip

function avalon_st_vip::new(string name = "avalon_st_vip", uvm_component parent = null);
  super.new(name, parent);
endfunction

// Only required if you have sub-components
function void avalon_st_vip::build_phase(uvm_phase phase);
  avalon_st_agent_config #(INST_SPEC) agent_cfg;
  int i;

  super.build_phase(phase);

  if (!uvm_config_db#(avalon_st_vip_config #(INST_SPEC))::get(this, "", "m_config", m_config))
    `uvm_fatal("CONFIG", "Cannot get() configuration 'm_config' from uvm_config_db. Have you set() it?");

  for (i = 0; i < AVALON_ST_AGENTS_NUM; i++)
  begin
    agent_cfg = m_config.m_agent_config.pop_front();
    m_agent[agent_cfg.agent_name] = avalon_st_agent#(INST_SPEC)::type_id::create("m_avalon_st_agent", this); // fixed!

    uvm_config_db#(avalon_st_agent_config #(INST_SPEC))::set(this, $sformatf("m_agent[%s]*", agent_cfg.agent_name), "m_config", agent_cfg);
  end

  /* Make a copy of agent's configs */
  foreach (m_agent[s])
    m_config.m_agent_config.push_back(m_agent[s].m_config);
endfunction: build_phase

`endif // _AVALON_ST_VIP_SVH_
