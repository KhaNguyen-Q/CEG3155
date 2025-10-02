LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY controlpath IS
PORT(
	i_Right, i_Left, i_clock, i_reset : IN STD_LOGIC;
	selDisplayA, selDisplayB, loadDisplay : OUT STD_LOGIC;
	loadLMask, lMaskShiftLeft : OUT STD_LOGIC;
	loadRMask, rMaskShiftRight : OUT STD_LOGIC
);
END controlpath;

architecture rtl of controlpath is
COMPONENT dflipflop
PORT (
	i_d : IN STD_LOGIC;
	i_clock : IN STD_LOGIC;
	i_enable : IN STD_LOGIC;
	i_async_reset : IN STD_LOGIC;
	i_async_set : IN STD_LOGIC;
	o_q, o_qBar : OUT STD_LOGIC
);
END COMPONENT;
SIGNAL s0, s1, s2, s3, s4 : STD_LOGIC;
begin
	dff_s0 : dflipflop
	PORT MAP(
		i_d => '0',
		i_clock => i_clock,
		i_enable => '1',
		i_async_set => i_reset,
		i_async_reset => '0',
		o_q => s0
	);
	
	dff_s1 : dflipflop
	PORT MAP(
		i_d => i_Left and i_Right,
		i_clock => i_clock,
		i_enable => '1',
		i_async_set => '0',
		i_async_reset => i_reset,
		o_q => s1
	);
	
	dff_s2 : dflipflop
	PORT MAP(
		i_d => i_Left and not i_Right,
		i_clock => i_clock,
		i_enable => '1',
		i_async_set => '0',
		i_async_reset => i_reset,
		o_q => s2
	);
	
	dff_s3 : dflipflop
	PORT MAP(
		i_d => not i_Left and i_Right,
		i_clock => i_clock,
		i_enable => '1',
		i_async_set => '0',
		i_async_reset => i_reset,
		o_q => s3
	);
	
	dff_s4 : dflipflop
	PORT MAP(
		i_d => not i_Left and not i_Right,
		i_clock => i_clock,
		i_enable => '1',
		i_async_set => '0',
		i_async_reset => i_reset,
		o_q => s4
	);
	
	loadDisplay <= s0 or s1 or s2 or s3 or s4;
	selDisplayA <= s1 or s3;
	selDisplayB <= s2 or s3;
	loadLMask <= s0;
	loadRMask <= s0;
	lMaskShiftLeft <= s1 or s2;
	rMaskShiftRight <= s1 or s3;
	
	
end rtl;