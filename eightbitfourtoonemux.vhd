LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY eightbitfourtoonemux IS
PORT(
	w0 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	w1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	w2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	w3 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	s0 : IN STD_LOGIC;
	s1 : IN STD_LOGIC;
	f : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END eightbitfourtoonemux;

architecture rtl of eightbitfourtoonemux is
SIGNAL int_a, int_b : STD_LOGIC_VECTOR(7 DOWNTO 0); 
COMPONENT eightbittwotoonemux
	PORT(
		w0 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		w1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		s : IN STD_LOGIC;
		f : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
	END COMPONENT;
begin
	muxA: eightbittwotoonemux
	PORT MAP(
		w0 => w0,
		w1 => w1,
		s => s0,
		f => int_a
	);
	muxB: eightbittwotoonemux
	PORT MAP(
		w0 => w2,
		w1 => w3,
		s => s0,
		f => int_b
	);
	muxC: eightbittwotoonemux
	PORT MAP(
		w0 => int_a,
		w1 => int_b,
		s => s1,
		f => f
	);
end rtl;