
`ifndef _VECTOR_HANDLER_SVH_
`define _VECTOR_HANDLER_SVH_

class vector_handler #(avalon_st_inst_spec_t INST_SPEC) extends uvm_object;
  `uvm_object_param_utils(vector_handler #(INST_SPEC))

  vector_database #(INST_SPEC)  m_database;
  csr_reg_block                 m_reg_block;

  // Standard UVM Methods:
  extern function new(string name = "vector_handler");

  // Custom methods:
  extern           function void parse_vector(string vector);
  extern protected function void parse_config(string file);
  extern protected function void parse_samples(string file);
  extern protected function void parse_signal_orig(string file);
  extern protected function void parse_signal_recon(string file);

  extern function void get_config(ref csr_reg_block_t csr_config);
  extern function void get_samples(ref lvl_cross_sample_t samples[$]);
  extern function void get_signal_orig(ref logic [INST_SPEC.BUS_WIDTH-1:0] signal[$]);
  extern function void get_signal_recon(ref logic [INST_SPEC.BUS_WIDTH-1:0] signal[$]);
endclass : vector_handler

function vector_handler::new(string name = "vector_handler");
  super.new(name);

  m_database  = vector_database#(INST_SPEC)::type_id::create($sformatf("%s.m_database", name));
  m_reg_block = csr_reg_block::type_id::create($sformatf("%s.m_reg_block", name));

  m_reg_block.build();
  m_reg_block.reset("HARD");
endfunction : new

function void vector_handler::parse_vector(string vector);
  parse_config({ vector, "/config.txt" });
  `uvm_info("VECTOR_HANDLER", $sformatf("--- Test vector parameters: ---\n%p", m_database.config_vector), UVM_HIGH)

  parse_samples({ vector, "/samples.txt" });
  `uvm_info("VECTOR_HANDLER", $sformatf("--- Test vector samples: ---\n%p", m_database.samples_vector), UVM_HIGH)

  parse_signal_orig({ vector, "/signal_original.txt" });
  `uvm_info("VECTOR_HANDLER", $sformatf("--- Reference for original signal values: ---\n%p",
                                          m_database.signal_orig_vector), UVM_HIGH)

  parse_signal_recon({ vector, "/signal_reconstructed.txt" });
  `uvm_info("VECTOR_HANDLER", $sformatf("--- Reference for reconstructed signal values: ---\n%p",
                                          m_database.signal_recon_vector), UVM_HIGH)
endfunction : parse_vector

function void vector_handler::parse_config(string file);
  uvm_reg register;
  uvm_reg regs[$];
  uvm_reg_field field;
  string param_reg;
  string param_field;
  string field_val;
  string line;
  int value;
  int fid;

  fid = $fopen(file, "r");

  if (!fid) begin
    `uvm_fatal("VECTOR_HANDLER", $sformatf("Cannot open file '%s'!", file))
  end

  m_reg_block.default_map.get_registers(regs);

  while (!$feof(fid)) begin
    $fgets(line, fid);

    if (line[0] == ">") begin
      $sscanf(line, ">>> %s <<<\n", param_reg);
      register = null;

      foreach (regs[i]) begin
        if (regs[i].get_name() == param_reg.tolower()) begin
          register = regs[i];
          break;
        end
      end

      if (register == null) begin
        `uvm_error("VECTOR_HANDLER", $sformatf("Cannot find register '%s'!", param_reg.tolower()))
        continue;
      end
    end

    if (line[0] == "$") begin
      int idx1 = 0;
      int idx2 = 0;

      $sscanf(line, "$ %s %s", param_field, field_val);

      if (param_field[param_field.len()-1] == ":") begin
        param_field = param_field.substr(0, param_field.len()-2);
      end

      if (register == null) begin
        `uvm_error("VECTOR_HANDLER", $sformatf("Cannot find field '%s' - no register set!", param_field.tolower()))
        continue;
      end

      field = register.get_field_by_name(param_field.tolower());

      if (field == null) begin
        `uvm_error("VECTOR_HANDLER", $sformatf("Cannot find field '%s' in register '%s'!", param_field.tolower(), param_reg.tolower()))
        continue;
      end

      if (field_val[0] == "0" && field_val[1] == "x") begin
        value = field_val.substr(2, field_val.len()-1).atohex();
      end else begin
        value = field_val.atoi();
      end

      `uvm_info("TUTEJ",$sformatf("field_val = %s",field_val),UVM_LOW)
      `uvm_info("VECTOR_HANDLER", $sformatf("Setting value '0x%0X' to field '%s' in register '%s'", value, field.get_name(), register.get_name()), UVM_HIGH)
      field.set(value);
    end
  end

  foreach (regs[i]) begin
    m_database.config_vector[regs[i].get_name().toupper()] = regs[i].get();
  end
endfunction : parse_config

function void vector_handler::parse_samples(string file);
  // logic [INST_SPEC.BUS_WIDTH-1:0] value;
  string line;
  int value;
  int fid;

  fid = $fopen(file, "r");

  if (!fid) begin
    `uvm_fatal("VECTOR_HANDLER", $sformatf("Cannot open file '%s'!", file))
  end

  while (!$feof(fid)) begin
    $fgets(line, fid);

    if (line[0] == "#" || line[0] == "") begin
      continue;
    end

    $sscanf(line, "0x%0X", value);
    m_database.samples_vector.push_back(value);
  end
endfunction : parse_samples

function void vector_handler::parse_signal_orig(string file);
  // logic [INST_SPEC.BUS_WIDTH-1:0] value;
  string line;

  int value;
  int fid;

  fid = $fopen(file, "r");

  if (!fid) begin
    `uvm_fatal("VECTOR_HANDLER", $sformatf("Cannot open file '%s'!", file))
  end

  while (!$feof(fid)) begin
    $fgets(line, fid);

    if (line[0] == "#" || line[0] == "") begin
      continue;
    end

    $sscanf(line, "0x%0X", value);
    m_database.signal_orig_vector.push_back(value);
  end
endfunction : parse_signal_orig

function void vector_handler::parse_signal_recon(string file);
  // logic [INST_SPEC.BUS_WIDTH-1:0] value;
  string line;
  int value;
  int fid;

  fid = $fopen(file, "r");

  if (!fid) begin
    `uvm_fatal("VECTOR_HANDLER", $sformatf("Cannot open file '%s'!", file))
  end

  while (!$feof(fid)) begin
    $fgets(line, fid);

    if (line[0] == "#" || line[0] == "") begin
      continue;
    end

    $sscanf(line, "0x%0X", value);
    m_database.signal_recon_vector.push_back(value);
  end
endfunction : parse_signal_recon

function void vector_handler::get_config(ref csr_reg_block_t csr_config);
  csr_config.status   = m_database.config_vector["STATUS"];
  csr_config.control  = m_database.config_vector["CONTROL"];
  csr_config.params   = m_database.config_vector["PARAMS"];
  csr_config.lvl_val_00_01  = m_database.config_vector["LVL_VAL_00_01"];
  csr_config.lvl_val_02_03  = m_database.config_vector["LVL_VAL_02_03"];
  csr_config.lvl_val_04_05  = m_database.config_vector["LVL_VAL_04_05"];
  csr_config.lvl_val_06_07  = m_database.config_vector["LVL_VAL_06_07"];
  csr_config.lvl_val_08_09  = m_database.config_vector["LVL_VAL_08_09"];
  csr_config.lvl_val_10_11  = m_database.config_vector["LVL_VAL_10_11"];
  csr_config.lvl_val_12_13  = m_database.config_vector["LVL_VAL_12_13"];
  csr_config.lvl_val_14_15  = m_database.config_vector["LVL_VAL_14_15"];
  csr_config.lvl_val_16_17  = m_database.config_vector["LVL_VAL_16_17"];
  csr_config.lvl_val_18_19  = m_database.config_vector["LVL_VAL_18_19"];
  csr_config.lvl_val_20_21  = m_database.config_vector["LVL_VAL_20_21"];
  csr_config.lvl_val_22_23  = m_database.config_vector["LVL_VAL_22_23"];
  csr_config.lvl_val_24_25  = m_database.config_vector["LVL_VAL_24_25"];
  csr_config.lvl_val_26_27  = m_database.config_vector["LVL_VAL_26_27"];
  csr_config.lvl_val_28_29  = m_database.config_vector["LVL_VAL_28_29"];
  csr_config.lvl_val_30_31  = m_database.config_vector["LVL_VAL_30_31"];
endfunction : get_config

function void vector_handler::get_samples(ref lvl_cross_sample_t samples[$]);
  samples = m_database.samples_vector;
endfunction : get_samples

function void vector_handler::get_signal_orig(ref logic [INST_SPEC.BUS_WIDTH-1:0] signal[$]);
  signal = m_database.signal_orig_vector;
endfunction : get_signal_orig

function void vector_handler::get_signal_recon(ref logic [INST_SPEC.BUS_WIDTH-1:0] signal[$]);
  signal = m_database.signal_recon_vector;
endfunction : get_signal_recon

`endif // _VECTOR_HANDLER_SVH_
