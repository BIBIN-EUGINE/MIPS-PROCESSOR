library ieee ;
use ieee.std_logic_1164.all;

-----------------------------------------------------

entity HazardDetectionUnit is
port(
  m_clock: in std_logic;
  instruction: in std_logic_vector(31 downto 0);
  
  hazard_detected: out std_logic
  );
end HazardDetectionUnit;

-----------------------------------------------------

architecture Behaviour1 of HazardDetectionUnit is

signal last_instruction: std_logic_vector(31 downto 0);
signal stall_counter: integer range 0 to 4:=0;

begin
  process(instruction, m_clock)
    variable first_bits: std_logic_vector(2 downto 0);
    variable last_bits: std_logic_vector(2 downto 0);
    variable dest_reg: std_logic_vector(3 downto 0);
    variable src_reg_1: std_logic_vector(3 downto 0);
    variable src_reg_2: std_logic_vector(3 downto 0); --"target" register
  begin
    first_bits:=instruction(31 downto 29);
    last_bits:=instruction(2 downto 0);
    
    --first, control hazards
    if (first_bits="011" or (first_bits="000" and last_bits="100")) then --Branch Equal or Jump Register
      --if not already done, stall pipeline for 2 cycles (execute and mem/branch resolve)
      if (stall_counter=0) then
        stall_counter<=2;
        hazard_detected<='1';
      else
        stall_counter<=stall_counter-1;
      end if;
      
    else
        hazard_detected<='0';
    end if;
  end process;

end Behaviour1;