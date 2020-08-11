add wave sim:/processor/*;
force -freeze sim:/processor/m_clock 1 0, 0 {50 ns} -r 100;
force pc_src_c '0';
force clear_pc '0';
run 100 ns;

force clear_pc '1';

run 2300 ns;



--HazardDetectionUnit
add wave sim:/HazardDetectionUnit/*;
force -freeze sim:/HazardDetectionUnit/m_clock 1 0, 0 {50 ns} -r 100;
force instruction x"a0c00004";
run 100 ns;
force instruction x"e000004";
run 100 ns;
force instruction x"42C0003";
run 100 ns;
force instruction x"42C0003";
run 100 ns;
force instruction x"42A0001";
run 100 ns;
force instruction x"4280000";
run 100 ns;


--All test benches
--inst_decode
--test read and write
add wave sim:/inst_dec/*;
force -freeze sim:/inst_dec/clk_dec 1 0, 0 {50 ns} -r 100;
force pcin "00001100";
force wren '0';
force radd1 "0000";
force radd2 "0011";
force wadd "0001";
force wdata "00000000000000000000000000101011"
force sigextin "000000000000000000001";
force regtin "0010";
force regdin "1000";
run 100 ns;
force wren '1';
run 100 ns;
force wadd "1100";
force wdata "00000000000000000000001101100000"
force wren '1';
run 100 ns;
force wren '0';
force radd1 "1100";
force radd2 "0010"
run 100 ns;
force radd2 "1100";
force radd1 "0010";
run 100 ns;
run 100 ns;


--Test Memory stage
add wave sim:/DataMemoryStage/*;
force -freeze sim:/DataMemoryStage/clk 1 0, 0 {50 ns} -r 100;
force mem_write_en '0';
force alu_result "00000000000000000000000000000000";
force mem_write_data "00000000000000000000001101100001";
force mux4 "0101";
run 100 ns;
force alu_result "00000000000000000000000000000001";
run 100 ns;
force mem_write_en '1';
force alu_result "00000000000000000000000001100000";
run 100 ns;
force mem_write_en '0';
force alu_result "00000000000000000000000000000000";
run 100 ns;
force alu_result "00000000000000000000000001100000";
run 100 ns;




--Exec stage
add wave sim:/ex_stage/*;
force aluop_ex "010";
force alusrc_ex '0';
force -freeze sim:/ex_stage/clk_ex 1 0, 0 {50 ns} -r 100;
force datain1_ex x"00000003";
force datain2_ex x"00000005";
force signextend_ex "00000000000000000000000000000010";
run 300 ns;

--ALU Unit
add wave sim:/alu_main_unit/*;
force readdata1 x"00000003";
force readdata2 x"000000023";
force aluopcode "000";
run 100 ns;
force aluopcode "001";
run 100 ns;
force aluopcode "010";
run 100 ns;
force aluopcode "011";
run 100 ns;
force aluopcode "100";
run 100 ns;
force aluopcode "101";
run 100 ns;
force readdata1 x"000000023";
run 100 ns;
--test signed
force readdata1 "11111111111111111111111111001001";
force readdata2 "11111111111111111111110001111100";
force aluopcode "000";
run 100 ns;
force aluopcode "001";
run 100 ns;
force aluopcode "010";
run 100 ns;
force aluopcode "011";
run 100 ns;
force aluopcode "100";
run 100 ns;
force aluopcode "101";
run 100 ns;
force readdata1 "11111111111111111111110001111100";
run 100 ns;


--Instruction fetch
add wave sim:/InstructionFetchStage/*;
force -freeze sim:/InstructionFetchStage/o_clock 1 0, 0 {50 ns} -r 100;
force pc_src '0';
force branch_address "000000000000000010000";
force pc_src '0';
force clear_pc '0';
run 100 ns;
force clear_pc '1';
run 999 ns;
noforce o_clock;
force o_clock '0';
force pc_src '1';
run 151 ns;
force -freeze sim:/InstructionFetchStage/o_clock 1 0, 0 {50 ns} -r 100;
run 200 ns;

