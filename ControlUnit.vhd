  library ieee ;
  use ieee.std_logic_1164.all;
  
  -----------------------------------------------------
  
  entity ControlUnit is
  port(
    instruction: in std_logic_vector(31 downto 0);
  	
  	reg_dst: out std_logic;
  	alu_op: out std_logic_vector(2 downto 0);
  	reg_to_addr: out std_logic;
  	alu_src: out std_logic;
  	branch: out std_logic;
  	mem_read: out std_logic;
  	mem_write: out std_logic;
  	reg_write: out std_logic;
  	mem_to_reg: out std_logic
  );
  end ControlUnit;
  
  -----------------------------------------------------
  
  architecture Behaviour1 of ControlUnit is
  begin
  
    process(instruction)
      variable first_bits: std_logic_vector(2 downto 0);
      variable last_bits: std_logic_vector(2 downto 0);
    begin
      first_bits:=instruction(31 downto 29);
      last_bits:=instruction(2 downto 0);
      case first_bits is
        when "000"=> --r-type or jr
          if last_bits/="101" and last_bits/="000" then --r-type
            reg_dst<='1';
            alu_op<="010";
            reg_to_addr<='0';
            alu_src<='0';
            branch<='0';
            mem_read<='0';
            mem_write<='0';
            reg_write<='1';
            mem_to_reg<='0';
          elsif last_bits="101" then--jr
            reg_dst<='0'; --whatever
            alu_op<="110";
            reg_to_addr<='1';
            alu_src<='0'; --whatever
            branch<='1';
            mem_read<='0';
            mem_write<='0';
            reg_write<='0';
            mem_to_reg<='0';
          else --nop
            reg_dst<='0'; --whatever
            alu_op<="111";
            reg_to_addr<='0';
            alu_src<='0'; --whatever
            branch<='0';
            mem_read<='0';
            mem_write<='0';
            reg_write<='0';
            mem_to_reg<='0';
          end if;
          
        --not implemented
        -- when "001"=> --addi
        --   reg_dst<='0';
        --   alu_op<="000";
        --   reg_to_addr<='0';
        --   alu_src<='1';
        --   branch<='0';
        --   mem_read<='0';
        --   mem_write<='0';
        --   reg_write<='1';
        --   mem_to_reg<='0';
          
        when "010"=> --andi
          reg_dst<='0';
          alu_op<="000";
          reg_to_addr<='0';
          alu_src<='1';
          branch<='0';
          mem_read<='0';
          mem_write<='0';
          reg_write<='1';
          mem_to_reg<='0';
          
        when "011"=> --beq
          reg_dst<='0'; --whatever
          alu_op<="011";
          reg_to_addr<='0';
          alu_src<='0';
          branch<='1';
          mem_read<='0';
          mem_write<='0';
          reg_write<='0';
          mem_to_reg<='0'; --whatever
          
        when "100"=> --lw
          reg_dst<='0';
          alu_op<="100";
          reg_to_addr<='0';
          alu_src<='1';
          branch<='0';
          mem_read<='1';
          mem_write<='0';
          reg_write<='1';
          mem_to_reg<='1';
        
        when "101"=> --sw
          reg_dst<='0'; --whatever
          alu_op<="101";
          reg_to_addr<='0';
          alu_src<='1';
          branch<='0';
          mem_read<='0';
          mem_write<='1';
          reg_write<='0';
          mem_to_reg<='0'; --whatever
        
        when "110"=> --subi
          reg_dst<='0';
          alu_op<="001";
          reg_to_addr<='0';
          alu_src<='1';
          branch<='0';
          mem_read<='0';
          mem_write<='0';
          reg_write<='1';
          mem_to_reg<='0';
          
        when others=>
          
      end case;
    end process;
  
  end Behaviour1;