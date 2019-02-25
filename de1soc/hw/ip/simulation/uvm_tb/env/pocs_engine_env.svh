
`ifndef _POCS_ENGINE_ENV_SVH_
`define _POCS_ENGINE_ENV_SVH_

class pocs_engine_env extends uvm_env;
  `uvm_component_utils(pocs_engine_env)

  pocs_engine_env_config m_config;

  avalon_mm_agent #(avalon_mm_inst_specs[CSR])    m_csr_agent;
  avalon_st_agent #(avalon_st_inst_specs[MM2ST])  m_mm2st_agent;
  avalon_st_agent #(avalon_st_inst_specs[ST2MM])  m_st2mm_agent;
  register_model                                  m_reg_model;

  pocs_engine_scoreboard                        m_scoreboard;

  // Standard UVM Methods:
  extern function new(string name = "pocs_engine_env", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
endclass : pocs_engine_env

function pocs_engine_env::new(string name = "pocs_engine_env", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

function void pocs_engine_env::build_phase(uvm_phase phase);
  if (!uvm_config_db#(pocs_engine_env_config)::get(this, "", "m_config", m_config))
    `uvm_fatal("CONFIG", "Cannot get() 'm_config' from uvm_config_db. Have you set() it?")

  m_csr_agent   = avalon_mm_agent#(avalon_mm_inst_specs[CSR])::type_id::create("m_csr_agent", this);
  m_mm2st_agent = avalon_st_agent#(avalon_st_inst_specs[MM2ST])::type_id::create("m_mm2st_agent", this);
  m_st2mm_agent = avalon_st_agent#(avalon_st_inst_specs[ST2MM])::type_id::create("m_st2mm_agent", this);

  if (m_config.use_register_model)
  begin
    m_reg_model = register_model::type_id::create("m_reg_model", this);
    uvm_config_db#(register_model_config)::set(this, "m_reg_model*", "m_config", m_config.reg_model_config);
  end

  if (m_config.enable_scoreboard)
  begin
    m_scoreboard = pocs_engine_scoreboard::type_id::create("m_scoreboard", this);
    uvm_config_db#(csr_reg_block_config)::set(this, "m_scoreboard*", "m_csr_config", m_config.csr_config);
  end

  uvm_config_db#(avalon_mm_agent_config #(avalon_mm_inst_specs[CSR]))::set(this, "m_csr_agent*", "m_config", m_config.csr_agent_config);
  uvm_config_db#(avalon_st_agent_config #(avalon_st_inst_specs[MM2ST]))::set(this, "m_mm2st_agent*", "m_config", m_config.mm2st_agent_config);
  uvm_config_db#(avalon_st_agent_config #(avalon_st_inst_specs[ST2MM]))::set(this, "m_st2mm_agent*", "m_config", m_config.st2mm_agent_config);
endfunction : build_phase

function void pocs_engine_env::connect_phase(uvm_phase phase);
  super.connect_phase(phase);

  if (m_config.enable_scoreboard)
  begin
    m_mm2st_agent.m_ap.connect(m_scoreboard.m_mm2st_ap);
    m_st2mm_agent.m_ap.connect(m_scoreboard.m_st2mm_ap);
  end

  if (m_config.use_register_model)
  begin
    m_reg_model.m_reg_block.default_map.set_sequencer(m_config.csr_agent_config.sequencer, m_reg_model.m_adapter);
    m_csr_agent.m_ap.connect(m_reg_model.m_predictor.bus_in);
  end
endfunction : connect_phase

`endif // _POCS_ENGINE_ENV_SVH_
